//
//  AntNetworkManager.h
//  Antwice
//
//  Created by hcy on 2018/2/1.
//  Copyright © 2018年 HCY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AntNetworkRequest.h"
#import "AntNetworkUrl.h"
@interface AntNetworkManager : NSObject

//例如，充值按钮
+ (void)productContentCountsuccessBlock:(AntHttpRequestSuccess)successBlock
                                   parameters:(NSDictionary *)parameters
                           failureBlock:(AntHttpRequestFailed)failureBlock
                                showHUD:(BOOL)showHUD;

@end
