//
//  GLBannerView.m
//  GLFrameLib_Example
//
//  Created by liguoliang on 2020/12/1.
//  Copyright © 2020 36617161@qq.com. All rights reserved.
//

#import "GLBannerView.h"
#import <SDWebImage.h>
#import <NSTimer+GLExtension.h>
#import <UIColor+GLExtension.h>

@interface GLBannerItem()
@property (nonatomic) UIImageView *imgview;
@end
@implementation GLBannerItem
+ (instancetype)createWithTitle:(NSString *)title Image:(NSString *)imgurl tgtURL:(NSString *)tgturl {
    GLBannerItem *item = [GLBannerItem new];
    item.title = title;
    item.imgUrl = imgurl;
    item.clickUrl = tgturl;
    return item;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.imgview.frame = self.bounds;
    self.backgroundColor = [UIColor randomColor];
}
- (UIImageView *)imgview {
    if(!_imgview) {
        NSLog(@"%s" , __func__);
        _imgview = [UIImageView new];
        [_imgview sd_setImageWithURL:[NSURL URLWithString:self.imgUrl]];
        _imgview.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imgview];
    }
    return _imgview;
}
- (void)setTitle:(NSString *)title {
    _title = title;
}
- (void)setImgUrl:(NSString *)imgUrl {
    _imgUrl = imgUrl;
    [self addSubview:self.imgview];
}
- (void)setClickUrl:(NSString *)clickUrl {
    _clickUrl = clickUrl;
}
@end


@interface GLBannerView()<GLFrameBaseProcotol>
@property (nonatomic) UIScrollView *scroll;
@property (nonatomic) int index;
@end

@implementation GLBannerView
@synthesize datasource = _datasource;
- (void)layoutSubviews {
    [super layoutSubviews];
    if(CGSizeEqualToSize(self.scroll.contentSize, CGSizeZero)) {
        for (int i=0; i<self.datasource.count; i++) {
            CGSize size = self.scroll.contentSize;
            GLBannerItem *element = self.datasource[i];
            CGRect elementRect = self.scroll.bounds;
            elementRect.origin.x = size.width;
            element.frame = elementRect;
            [self.scroll addSubview:element];
            size.width += self.scroll.bounds.size.width;
            self.scroll.contentSize = size;
        }
        [NSTimer startWithTimeInterval:2 repeat:YES withBlock:^{
            [self.scroll setContentOffset:CGPointMake([self nextX], 0) animated:YES];
        }];
    }
}
- (CGFloat)nextX {
    int count = self.scroll.contentSize.width/self.scroll.bounds.size.width;
    if(self.index == count-1){
        self.index = 0;
        return 0;
    }else{
        self.index++;
        return self.index * self.scroll.bounds.size.width;
    }
}
- (void)setDatasource:(NSArray<GLBannerItem *> *)datasource {
    _datasource = [datasource copy];
}
- (UIScrollView *)scroll {
    if(!_scroll) {
        _scroll = [UIScrollView new];
        _scroll.frame = self.bounds;
        _scroll.pagingEnabled = YES;
        _scroll.contentSize = CGSizeZero;
        [self addSubview:_scroll];
    }
    return _scroll;
}
- (NSArray<GLBannerItem *> *)datasource {
    if(!_datasource) {
        _datasource = [NSArray array];
    }
    return _datasource;
}
@end
