//
//  GLFrameViewProp.h
//  GLFrameLib
//
//  Created by liguoliang on 2020/11/30.
//

#import <Foundation/Foundation.h>
#import <TypeProperty.h>
@interface GLFrameViewProp : NSObject
+ (void)setCommonProp:(TypeProperty *)prop withTarget:(UIView *)target inContainer:(UIViewController *)container;
@end
