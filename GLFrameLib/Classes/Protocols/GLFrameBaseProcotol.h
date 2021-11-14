//
//  GLFrameBaseProcotol.h
//  GLUIKit
//
//  Created by liguoliang on 2020/10/27.
//

#import <Foundation/Foundation.h>
//#import <GLUIKitViewProp.h>
@class TypeProperty;

@protocol GLFrameBaseProcotol <NSObject>
@optional
+ (instancetype)frameNew;
- (void)frameStyle;
- (void)frameSetProp:(TypeProperty *)prop inContainer:(UIViewController *)container;
@end
