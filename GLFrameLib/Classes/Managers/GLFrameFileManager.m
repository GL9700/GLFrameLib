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
    printf("-> [file]\n\t...Resource file load :%s\n\n",rlt==nil?"FAD":"SUC");
    return rlt;
}
@end
