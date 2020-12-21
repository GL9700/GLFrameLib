//
//  GLBannerView.h
//  GLFrameLib_Example
//
//  Created by liguoliang on 2020/12/1.
//  Copyright © 2020 36617161@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLBannerItem : UIView
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *imgUrl;
@property (nonatomic) NSString *clickUrl;
+ (instancetype)createWithTitle:(NSString *)title Image:(NSString *)imgurl tgtURL:(NSString *)tgturl;
@end

@interface GLBannerView : UIView
@property (nonatomic) NSArray<GLBannerItem *> *datasource;
@end
