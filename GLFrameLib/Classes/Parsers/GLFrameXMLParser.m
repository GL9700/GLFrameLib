//
//  GLFrameXMLParser.m
//  GLFrameLib
//
//  Created by liguoliang on 2020/12/1.
//

#import "GLFrameXMLParser.h"
#import <objc/message.h>

@interface NSDictionary (DescExt)
@end
@implementation NSDictionary (DescExt)
- (NSString *)description {
    NSMutableString *str = [NSMutableString stringWithString:@"{\n"];
    for (NSString *key in self.allKeys) {
        [str appendFormat:@"\t%@ = %@ (%@)\n", key, self[key], NSStringFromClass([self[key] class])];
    }
    [str appendString:@"}"];
    return [str copy];
}
@end

@interface GLFrameXMLParser() <NSXMLParserDelegate>
@property (nonatomic) NSXMLParser *xml;
@property (nonatomic) int level;
@property (nonatomic) ElementEntity *root;
@property (nonatomic) ElementEntity *upnode;
@end
@implementation GLFrameXMLParser
- (ElementEntity *)treeForContent:(NSString *)content {
    self.xml = [[NSXMLParser alloc] initWithData:[content dataUsingEncoding:NSUTF8StringEncoding]];
    self.xml.delegate = self;
    [self.xml parse];
    return nil;
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    printf("-> [parser]\n\t...start\n\n");
    self.level = 0;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    printf("-> [parser]\n\t...end\n\n");
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict {
    self.level+=1;
    printf("-> [parser]\n\t...<属性> %s, %s\n\n", [elementName UTF8String], [[attributeDict description] UTF8String]);
    ElementEntity *entity = [ElementEntity new];
    entity.superObj = self.upnode;
    entity.name = elementName;
    if(self.level==1){
        self.root = entity;
        self.upnode = self.root;
    }else{
        [self.upnode.subs addObject:entity];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName {
    self.level-=1;
    printf("-> [parser]\n\t...<结束标记> %s \n\n", [elementName UTF8String]);
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if([[string stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length>0){
        printf("-> [parser]\n\t ...<内容> %s\n\n", [string UTF8String]);
    }
}

- (void)parser:(NSXMLParser *)parser foundComment:(NSString *)comment {
    printf("-> [parser]\n\t ...<注释内容> %s\n\n", [comment UTF8String]);
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    printf("-> [parser]\n\t ...<!! 解析出错 !!> %s\n\n", [[parseError.userInfo description] UTF8String]);
    [parser abortParsing];
}

- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError {
    printf("-> [parser]\n\t ...<!! 验证错误 !!> %s\n\n",[[validationError.userInfo description] UTF8String]);
    [parser abortParsing];
}
@end
