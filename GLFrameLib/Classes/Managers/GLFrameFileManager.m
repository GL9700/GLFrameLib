//
//  GLFrameFileManager.m
//  GLFrameLib
//
//  Created by liguoliang on 2020/11/30.
//

#import "GLFrameFileManager.h"

@implementation GLFrameFileManager
+ (NSString *)contentFromLocalPath:(NSString *)path {
    NSString *rlt = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    printf("-> [file]\n\t...rlt load suc:%d\n\n",rlt==nil?0:1);
    return rlt;
}
@end
