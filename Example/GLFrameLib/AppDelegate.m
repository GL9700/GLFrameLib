//
//  AppDelegate.m
//  GLFrameLib
//
//  Created by 36617161@qq.com on 11/30/2020.
//  Copyright (c) 2020 36617161@qq.com. All rights reserved.
//

#import "AppDelegate.h"
#import "GLMainListViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:[GLMainListViewController new]];
    navController.navigationBar.translucent = NO;
    
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
