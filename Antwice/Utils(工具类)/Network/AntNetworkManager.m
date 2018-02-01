//
//  AntNetworkManager.m
//  Antwice
//
//  Created by hcy on 2018/2/1.
//  Copyright © 2018年 HCY. All rights reserved.
//

#import "AntNetworkManager.h"

@implementation AntNetworkManager


+ (void)productContentCountsuccessBlock:(AntHttpRequestSuccess)successBlock
                                   parameters:(NSDictionary *)parameters
                           failureBlock:(AntHttpRequestFailed)failureBlock
                                showHUD:(BOOL)showHUD
{
    NSDictionary *dict=[[NSDictionary alloc]init];
    [dict setValue:@"count" forKey:@"count"];
    [dict setValue:@"access_token" forKey:@"access_token"];
    [AntNetworkRequest postRequest:productContent parameters:dict success:successBlock failure:failureBlock];
}


@end
