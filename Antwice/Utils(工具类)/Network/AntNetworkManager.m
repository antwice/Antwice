//
//  AntNetworkManager.m
//  Antwice
//
//  Created by hcy on 2018/2/1.
//  Copyright © 2018年 HCY. All rights reserved.
//

#import "AntNetworkManager.h"
#import "AntNetworkHeader.h"
@implementation AntNetworkManager


+(void)productSuccessBlock:(success)success failed:(faild)faild{
    [AntNetworkRequest getRequest:productContent parameters:nil success:success failure:faild];
}


@end
