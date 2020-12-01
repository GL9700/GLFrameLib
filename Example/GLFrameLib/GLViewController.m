//
//  GLViewController.m
//  GLFrameLib
//
//  Created by 36617161@qq.com on 11/30/2020.
//  Copyright (c) 2020 36617161@qq.com. All rights reserved.
//

#import "GLViewController.h"

@implementation GLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [GLFrameManager enableDebug:YES];
    [GLFrameManager frameFile:@"Login.xml" inContainer:self complete:^(UIView *rootView) {
        CGFloat x = 0;
        CGFloat y = self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
        CGFloat width = self.view.bounds.size.width;
        CGFloat height = self.view.bounds.size.height - y - 34;
        rootView.frame = CGRectMake(x, 0, width, height);
        [self.view addSubview:rootView];
    }];
}

- (void)onClickBackground {
    NSLog(@"点击了背景");
    [self.view endEditing:YES];
}


- (void)onClickLoadVerifyCode {
    NSLog(@"获取验证码成功。。。。");
    rto_dsp(@"r://push/GLMainViewController", nil);
}

@end
