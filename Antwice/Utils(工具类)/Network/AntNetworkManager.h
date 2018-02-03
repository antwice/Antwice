//
//  AntNetworkManager.h
//  Antwice
//
//  Created by hcy on 2018/2/1.
//  Copyright © 2018年 HCY. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^success)(id returnData);
typedef void (^faild)(NSError *error);

@interface AntNetworkManager : NSObject

+(void)productSuccessBlock:(success)success failed:(faild)faild;

@end
