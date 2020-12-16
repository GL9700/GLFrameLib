//
//  GLFrameXMLParser.m
//  GLFrameLib
//
//  Created by liguoliang on 2020/12/1.
//

#import "GLFrameXMLParser.h"
#import <objc/message.h>
#import "NSString+GLExtension.h"
#import "GLFrameLib_Dev_PCH.h"

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

@interface GLFrameXMLParser () <NSXMLParserDelegate>
@property (nonatomic) NSXMLParser *xml;
@property (nonatomic) int level;
@property (nonatomic) ElementEntity *root;
@property (nonatomic) NSMutableDictionary<NSString *, ElementEntity *> *nodes;
@property (nonatomic) void(^parserComplete)(ElementEntity *rootEntity);
@property (nonatomic) BOOL hasError;
@end

@implementation GLFrameXMLParser
- (void)treeForContent:(NSString *)content complete:(void (^)(ElementEntity *))handle {
    self.parserComplete = handle;
    self.xml = [[NSXMLParser alloc] initWithData:[content dataUsingEncoding:NSUTF8StringEncoding]];
    self.xml.delegate = self;
    [self.xml parse];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    GLFL_IN_DEV_MODE==0 ? : printf("-> [parser]\n\t...start\n\n");
    self.level = 0;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if(parser.parserError) {
        GLFL_IN_DEV_MODE==0 ? : printf("-> [parser]\n\t...end...has Error \n\t...Error:%s\n\n", [[parser.parserError.userInfo description] UTF8String]);
        return;
    }
    GLFL_IN_DEV_MODE==0 ? : printf("-> [parser]\n\t...end...pass\n\n");
    self.parserComplete ? self.parserComplete(self.root) : nil;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict {
    ElementEntity *parentNode = self.nodes[SF(@"%d", self.level)];
    self.level += 1;
    GLFL_IN_DEV_MODE==0 ? : printf("-> [parser]\n\t...<属性> (lv:%d) %s, %s\n\n", self.level, [elementName UTF8String], [[attributeDict description] UTF8String]);
    ElementEntity *node = [ElementEntity new];
    node.parent = parentNode;
    node.name = elementName;
    @autoreleasepool {
        for (NSString *attkey in attributeDict.allKeys) {
            id value = attributeDict[attkey];
            if([attkey isEqualToString:@"bundleId"]) {
                node.bundleProperty = value;
            }else{
                TypeProperty *propEntity = [TypeProperty createPropertyEntityWithKey:attkey Value:value];
                [node.props addObject:propEntity];
            }
        }
    }
    if(parentNode==nil){
        parentNode = node;
    }else{
        [parentNode.children addObject:node];
    }
    if(self.root == nil) {
        self.root = parentNode;
    }
    self.nodes[SF(@"%d", self.level)] = node;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName {
    self.level -= 1;
    GLFL_IN_DEV_MODE==0 ? : printf("-> [parser]\n\t...<结束标记> %s \n\n", [elementName UTF8String]);
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length > 0) {
        GLFL_IN_DEV_MODE==0 ? : printf("-> [parser]\n\t ...<内容> %s\n\n", [string UTF8String]);
    }
}

- (void)parser:(NSXMLParser *)parser foundComment:(NSString *)comment {
    GLFL_IN_DEV_MODE==0 ? : printf("-> [parser]\n\t ...<注释内容> %s\n\n", [comment UTF8String]);
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    GLFL_IN_DEV_MODE==0 ? : printf("-> [parser]\n\t ...<!! 解析出错 !!> %s\n\n", [[parseError.userInfo description] UTF8String]);
    [parser abortParsing];
}

- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError {
    GLFL_IN_DEV_MODE==0 ? : printf("-> [parser]\n\t ...<!! 验证错误 !!> %s\n\n", [[validationError.userInfo description] UTF8String]);
    [parser abortParsing];
}

- (NSMutableDictionary<NSString *, ElementEntity *> *)nodes {
    if (!_nodes) {
        _nodes = [NSMutableDictionary dictionary];
    }
    return _nodes;
}

@end
