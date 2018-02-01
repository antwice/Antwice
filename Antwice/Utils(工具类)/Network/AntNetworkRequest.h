//
//  AntNetworkRequest.h
//  Antwice
//
//  Created by hcy on 2018/2/1.
//  Copyright © 2018年 HCY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "AntNetworkCache.h"
//判断是否有网

//是否是手机网络

//是否是wifi网络


/**
 * 检测网络的类型
 */
typedef NS_ENUM(NSInteger,AntNetworkStatusType) {
    AntNetworkStatusUnkown,
    AntNetworkStatusNotReachable,
    AntNetworkStatusReachableViaWWAN,
    AntNetworkStatusReachableViaWiFi
};

/**
 * 请求成功的Block
 */
typedef void (AntHttpRequestSuccess)(id responseObject);

/**
 * 请求失败的Block
 */
typedef void (AntHttpRequestFailed)(NSError *error);

/**
 * 缓存的Block
 */
typedef void (AntHttpRequestCache)(id responseCache);

/**
 * 上传下载进度
 */
typedef void (AntNetworkProgress)(NSProgress *progress);

/**
 * 检测网络状态
 */
typedef void (AntNetworkStatus)(AntNetworkStatusType networkStatus);


@class AFHTTPSessionManager;
@interface AntNetworkRequest : NSObject

/**
 *  GET请求
 *
 *  @param requestUrl        请求地址
 *  @param parameters 请求参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 */
+ (__kindof NSURLSessionTask *)getRequest:(NSString *)requestUrl
                               parameters:(id)parameters
                                  success:(AntHttpRequestSuccess)success
                                  failure:(AntHttpRequestFailed)failure;

/**
 *  GET请求,有缓存
 *
 *  @param requestUrl        请求地址
 *  @param parameters 请求参数
 *  @param responseCache 缓存
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 */
+ (__kindof NSURLSessionTask *)getRequest:(NSString *)requestUrl
                               parameters:(id)parameters
                            responseCache:(AntHttpRequestCache)responseCache
                                  success:(AntHttpRequestSuccess)success
                                  failure:(AntHttpRequestFailed)failure;

/**
 *  POST请求
 *
 *  @param requestUrl        请求地址
 *  @param parameters 请求参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 */
+ (__kindof NSURLSessionTask *)postRequest:(NSString *)requestUrl
                               parameters:(id)parameters
                                  success:(AntHttpRequestSuccess)success
                                  failure:(AntHttpRequestFailed)failure;

/**
 *  POST请求,有缓存
 *
 *  @param requestUrl        请求地址
 *  @param parameters 请求参数
 *  @param responseCache 缓存
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 */
+ (__kindof NSURLSessionTask *)postRequest:(NSString *)requestUrl
                                parameters:(id)parameters
                             responseCache:(AntHttpRequestCache)responseCache
                                   success:(AntHttpRequestSuccess)success
                                   failure:(AntHttpRequestFailed)failure;

/**
 *  上传文件
 *
 *  @param requestUrl        请求地址
 *  @param parameters 请求参数
 *  @param name       文件对应服务器上的字段
 *  @param filePath   文件本地的沙盒路径
 *  @param progress   上传进度信息
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 */
+(__kindof NSURLSessionTask *)uploadFileWithUrl:(NSString *)requestUrl
                            parameters:(id)parameters
                                  name:(NSString *)name
                              filePath:(NSString *)filePath
                              progress:(AntNetworkProgress)progress
                               success:(AntHttpRequestSuccess)success
                               failure:(AntHttpRequestFailed)failure;

/**
 *  上传单/多张图片
 *
 *  @param requestUrl        请求地址
 *  @param parameters 请求参数
 *  @param name       图片对应服务器上的字段
 *  @param images     图片数组
 *  @param fileNames  图片文件名数组, 可以为nil, 数组内的文件名默认为当前日期时间"yyyyMMddHHmmss"
 *  @param imageScale 图片文件压缩比 范围 (0.f ~ 1.f)
 *  @param imageType  图片文件的类型,例:png、jpg(默认类型)....
 *  @param progress   上传进度信息
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 */
+(__kindof NSURLSessionTask *)uploadImageWithUrl:(NSString *)requestUrl
                                      parameters:(id)parameters
                                            name:(NSString *)name
                                          images:(NSArray<UIImage *> *)images
                                       fileNames:(NSArray<NSString *> *)fileNames
                                      imageScale:(CGFloat)imageScale
                                       imageType:(NSString *)imageType progress:(AntNetworkProgress)progress
                                         success:(AntHttpRequestSuccess)success
                                         failure:(AntHttpRequestFailed)failure;

/**
 *  下载文件
 *
 *  @param requestUrl      请求地址
 *  @param fileDir  文件存储目录(默认存储目录为Download)
 *  @param progress 文件下载的进度信息
 *  @param success  下载成功的回调(回调参数filePath:文件的路径)
 *  @param failure  下载失败的回调
 *
 *  @return 返回NSURLSessionDownloadTask实例，可用于暂停继续，暂停调用suspend方法，开始下载调用resume方法
 */
+ (__kindof NSURLSessionTask *)downloadWithURL:(NSString *)requestUrl
                                       fileDir:(NSString *)fileDir
                                      progress:(AntNetworkProgress)progress
                                       success:(void(^)(NSString *filePath))success
                                       failure:(AntHttpRequestFailed)failure;



@end
