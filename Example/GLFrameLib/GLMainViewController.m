//
//  GLMainViewController.m
//  GLFrameLib_Example
//
//  Created by liguoliang on 2020/12/1.
//  Copyright © 2020 36617161@qq.com. All rights reserved.
//

#import "GLMainViewController.h"
#import "GLBannerView.h"

@interface GLMainViewController ()
@property (nonatomic) GLBannerView *bannerView;
@end

@implementation GLMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.bannerView.datasource = @[
        [GLBannerItem createWithTitle:@"更好认识源远流长博大精深的中华文明" Image:@"https://p3.img.cctvpic.com/photoAlbum/page/performance/img/2020/11/30/1606740307240_392.jpg" tgtURL:nil],
        [GLBannerItem createWithTitle:@"走过“黄金十年”，下一站“钻石十年”" Image:@"https://p3.img.cctvpic.com/photoAlbum/page/performance/img/2020/12/1/1606773834105_525.jpg" tgtURL:nil],
        [GLBannerItem createWithTitle:@"结束160年流离 圆明园马首今天终于“回家”了！" Image:@"https://p1.img.cctvpic.com/photoAlbum/page/performance/img/2020/12/1/1606787871145_70.jpg" tgtURL:nil],
        [GLBannerItem createWithTitle:@"坚守，只为那一面五星红旗" Image:@"https://p3.img.cctvpic.com/photoAlbum/page/performance/img/2020/12/1/1606782113797_259.jpg" tgtURL:nil],
    ];
//    [self.view addSubview:self.bannerView];
    
    [GLFrameManager registerFrameDict:[[NSBundle mainBundle] pathForResource:@"Banner" ofType:@"plist"]];
    [GLFrameManager frameFile:@"Main2.xml" inContainer:self complete:^(UIView *rootView) {
        [self.view addSubview:rootView];
    }];
}

- (GLBannerView *)bannerView {
    if(!_bannerView){
        _bannerView = [GLBannerView new];
        _bannerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 320);
        _bannerView.backgroundColor = [UIColor lightGrayColor];
    }
    return _bannerView;
}

@end
