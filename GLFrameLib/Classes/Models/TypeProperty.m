//
//  TypeProperty.m
//  GLUIKit
//
//  Created by liguoliang on 2020/11/6.
//

#import "TypeProperty.h"
@interface TypeProperty ()
@property (nonatomic) NSString *row;
@end

@implementation TypeProperty

+ (instancetype)createPropertyEntityWithKey:(NSString *)key Value:(id)value {
    TypeProperty *instance = [TypeProperty new];
    instance.key = key;
    instance.value = value;
    return instance;
}

+ (instancetype)createPropertyEntityFromElementRow:(NSString *)row {
    if (row.length < 3) {
        return nil;
    }
    TypeProperty *instance = [TypeProperty new];
    instance.row = row;
    NSArray *props = [row componentsSeparatedByString:@":"];
    NSMutableString *value = [props[1] mutableCopy];
    for (int i = 2; i < props.count; i++) {
        [value appendString:@":"];
        [value appendString:props[i]];
    }
    NSString *rvalue = [value copy];
    if ([value hasPrefix:@"\""] && [value hasSuffix:@"\""]) {
        rvalue = [value substringWithRange:NSMakeRange(1, value.length - 2)];
    }
    instance.key = props[0];
    instance.value = [rvalue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return instance;
}
@end
