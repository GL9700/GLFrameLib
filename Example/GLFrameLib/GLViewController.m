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
    
    [GLFrameManager frameFile:@"Login.ui" inContainer:self complete:^(UIView *rootView) {
        rootView.frame = self.view.frame;
        [self.view addSubview:rootView];
    }];
}


@end
