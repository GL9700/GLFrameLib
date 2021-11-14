//
//  GLFrameViewMaker.h
//  GLFrameLib
//
//  Created by liguoliang on 2020/11/30.
//

#import <Foundation/Foundation.h>
#import <ElementEntity.h>

@interface GLFrameViewMaker : NSObject

@property (nonatomic) id targetContainer;   // 绑定属性的父类
@property (nonatomic) ElementEntity *tokenTree;
@property (nonatomic) NSDictionary *additional;
@property (nonatomic) void(^handle_Complete)(UIView *rootView);
- (void)makerView;
@end
