//
//  AppDelegate+PushService.m
//  Antwice
//
//  Created by hcy on 2018/2/1.
//  Copyright © 2018年 HCY. All rights reserved.
//

#import "AppDelegate+PushService.h"
#import "RootViewController.h"
@implementation AppDelegate (PushService)

-(void)antInitWindow{
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor=[UIColor whiteColor];
    RootViewController *rootView=[[RootViewController alloc]init];
    UINavigationController *rootNav=[[UINavigationController alloc]initWithRootViewController:rootView];
    self.window.rootViewController=rootNav;
    [self.window makeKeyAndVisible];
}

@end
