//
//  GLUIParserProtocol.h
//  GLUIKit
//
//  Created by liguoliang on 2020/11/17.
//

#import <Foundation/Foundation.h>
#import <ElementEntity.h>

@protocol GLFrameParserProtocol <NSObject>
- (void)treeForContent:(NSString *)content complete:(void(^)(ElementEntity *rootEntity))handle;
@end
