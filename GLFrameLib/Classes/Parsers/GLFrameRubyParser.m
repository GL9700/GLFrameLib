//
//  GLFrameRubyParser.m
//  GLFrameLib
//
//  Created by liguoliang on 2020/11/30.
//

#import "GLFrameRubyParser.h"
#import <ElementEntity.h>
#import <TypeProperty.h>

@interface GLFrameRubyParser()
@property (nonatomic) NSMutableArray *tokens;
@property (nonatomic) NSInteger index;
@end

@implementation GLFrameRubyParser
- (ElementEntity *)treeForContent:(NSString *)content {
    NSArray *separateCharset = @[@"{", @"}", @"[", @"]", @"(", @")", @"<", @">", @",", @";", @"$", @"\""];
    NSMutableCharacterSet *passCharset = [NSMutableCharacterSet alphanumericCharacterSet];
    [passCharset addCharactersInString:@" @:-/._?&!%%#，。（）‘’“”"];
    NSScanner *scan = [NSScanner scannerWithString:content];
    [scan setCharactersToBeSkipped:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    while (![scan isAtEnd]) {
        if ([self.tokens.lastObject isEqualToString:@"\""]) {
            [self.tokens removeLastObject];
            NSString *value = nil;
            if ([scan scanUpToString:@"\"" intoString:&value]) {
                NSString *propKey = self.tokens.lastObject;
                [self.tokens removeLastObject];
                [self.tokens addObject:[NSString stringWithFormat:@"%@%@", propKey, value]];
                [scan scanString:@"\"" intoString:nil];
                continue;
            }
        }else {
            for (NSString *symbol in separateCharset) {
                if ([scan scanString:symbol intoString:nil]) {
                    if(![symbol isEqualToString:@","]){
                        [self.tokens addObject:symbol];
                    }
                    continue;
                }
                NSString *value = nil;
                if ([scan scanCharactersFromSet:passCharset intoString:&value]) {
                    [self.tokens addObject:value];
                    continue;
                }
            }
        }
    }
    printf("-> [parser]\n\t...token length:%lu\n\n", (unsigned long)self.tokens.count);
    return [self generateTokenTree];
}

- (ElementEntity *)generateTokenTree {
    self.index = 0;
    BOOL atEnd = NO, isProp = NO;
    ElementEntity *sup, *cur;
    
    while (!atEnd) {
        NSString *tokenContent = [self nextToken];
        atEnd = self.index >= self.tokens.count;
        if ([tokenContent isEqualToString:@"{"]) {
            if (cur) {
                sup = cur;
                cur = nil;
            }
            else {
                sup = [self createRootEntity];
            }
            continue;
        }
        else if ([tokenContent isEqualToString:@"}"]) {
            if (sup.superObj) {
                sup = sup.superObj;
            }
            continue;
        }
        if ([tokenContent isEqualToString:@"["]) {
            cur = [self createLeafEntityWithTypeName:[self nextToken] parent:sup];
            continue;
        }
        else if ([tokenContent isEqualToString:@"]"]) {
            cur = nil;
            continue;
        }
        if ([tokenContent isEqualToString:@"<"]) {
            cur.tagName = [self nextToken];
            continue;
        }
        else if ([tokenContent isEqualToString:@">"]) {
            continue;
        }
        if ([tokenContent isEqualToString:@"("]) {
            isProp = YES;
            if(cur==nil){
                cur = sup==nil ? [self createRootEntity] : sup;
            }
            continue;
        }
        else if ([tokenContent isEqualToString:@")"]) {
            isProp = NO;
            continue;
        }
        if (isProp == YES) {
            [self setProp:tokenContent intoObject:cur];
        }
    }
    return sup;
}

- (ElementEntity *)createRootEntity {
    return [self createLeafEntityWithTypeName:@"view" parent:nil];
}

- (ElementEntity *)createLeafEntityWithTypeName:(NSString *)typename parent:(ElementEntity *)parent {
    ElementEntity *cur = [ElementEntity new];
    cur.name = typename;
    cur.superObj = parent;
    [parent.subs addObject:cur];
    return cur;
}

- (void)setProp:(NSString *)prop intoObject:(ElementEntity *)obj {
    if (prop.length > 3) {
        [obj.props addObject:[TypeProperty createPropertyEntityFromElementRow:prop]];
    }
}

- (NSString *)nextToken {
    self.index++;
    if (self.index >= self.tokens.count) {
        return nil;
    }
    return self.tokens[self.index - 1];
}

- (NSMutableArray *)tokens {
    if(!_tokens) {
        _tokens = [NSMutableArray array];
    }
    return _tokens;
}

@end
