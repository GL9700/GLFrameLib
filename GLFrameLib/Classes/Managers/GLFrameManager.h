//
//  GLFrameManager.h
//  GLFrameLib
//
//  Created by liguoliang on 2020/11/30.
//

#import <Foundation/Foundation.h>

@interface GLFrameManager : NSObject

+ (void)registerFrameDict:(NSString *)path;

+ (void)frameFile:(NSString *)NameOrPath inContainer:(id)container complete:(void(^)(UIView *rootView))handleComplete;
@end
