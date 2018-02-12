//
//  RootViewController.m
//  Antwice
//
//  Created by hcy on 2018/2/1.
//  Copyright © 2018年 HCY. All rights reserved.
//

#import "RootViewController.h"
#import "AntNetworkHeader.h"
#ifdef DEBUG
#define ANTLog(...) printf("[%s] %s [第%d行]: %s\n", __TIME__ ,__PRETTY_FUNCTION__ ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define ANTLog(...)
#endif

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor yellowColor];
    
    [AntNetworkManager productSuccessBlock:^(id returnData) {
        NSLog(@"%@",returnData);
    } failed:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
