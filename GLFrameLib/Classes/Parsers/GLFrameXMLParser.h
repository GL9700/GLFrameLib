//
//  GLFrameXMLParser.h
//  GLFrameLib
//
//  Created by liguoliang on 2020/12/1.
//

#import <Foundation/Foundation.h>
#import <GLFrameParserProtocol.h>

@interface GLFrameXMLParser : NSObject <GLFrameParserProtocol>
- (ElementEntity *)treeForContent:(NSString *)content;
@end
