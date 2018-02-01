//
//  AntNetworkRequest.m
//  Antwice
//
//  Created by hcy on 2018/2/1.
//  Copyright © 2018年 HCY. All rights reserved.
//

#import "AntNetworkRequest.h"

#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

@implementation AntNetworkRequest
static NSMutableArray *_allSessionTask;
static AFHTTPSessionManager *_sessionManager;

#pragma mark ————— GET请求 —————
+(NSURLSessionTask *)getRequest:(NSString *)requestUrl parameters:(id)parameters success:(AntHttpRequestSuccess)success failure:(AntHttpRequestFailed)failure{
    
    return [self getRequest:requestUrl parameters:parameters success:success failure:failure];
    
}

#pragma mark ————— POST请求 —————
+(NSURLSessionTask *)postRequest:(NSString *)requestUrl parameters:(id)parameters success:(AntHttpRequestSuccess)success failure:(AntHttpRequestFailed)failure{
    
    return [self postRequest:requestUrl parameters:parameters success:success failure:failure];
    
}

#pragma mark ————— GET请求,有缓存 —————
+(NSURLSessionTask *)getRequest:(NSString *)requestUrl parameters:(id)parameters responseCache:(AntHttpRequestCache)responseCache success:(AntHttpRequestSuccess)success failure:(AntHttpRequestFailed)failure{
    
    //读取缓存
    responseCache!=nil ? responseCache([AntNetworkCache httpCacheForURL:requestUrl parameters:parameters]) : nil;
    
    NSURLSessionTask *sessionTask =[_sessionManager GET:requestUrl parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        //对数据进行异步缓存
        responseCache!=nil ? [AntNetworkCache setHttpCache:responseObject URL:requestUrl parameters:parameters] : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
        
    }];
    
    // 添加最新的sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    return sessionTask;

}

#pragma mark ————— POST请求,有缓存 —————
+(NSURLSessionTask *)postRequest:(NSString *)requestUrl parameters:(id)parameters responseCache:(AntHttpRequestCache)responseCache success:(AntHttpRequestSuccess)success failure:(AntHttpRequestFailed)failure{
    
    //读取缓存
    responseCache!=nil ? responseCache([AntNetworkCache httpCacheForURL:requestUrl parameters:parameters]) : nil;
    NSURLSessionTask *sessionTask=[_sessionManager POST:requestUrl parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        //对数据进行异步缓存
        responseCache!=nil ? [AntNetworkCache setHttpCache:responseObject URL:requestUrl parameters:parameters] : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
        
    }];
    
    // 添加最新的sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    return sessionTask;
}

#pragma mark ————— 上传文件 —————
+(NSURLSessionTask *)uploadFileWithUrl:(NSString *)requestUrl parameters:(id)parameters name:(NSString *)name filePath:(NSString *)filePath progress:(AntNetworkProgress)progress success:(AntHttpRequestSuccess)success failure:(AntHttpRequestFailed)failure{
    
    
    NSURLSessionTask *sessionTask=[_sessionManager POST:requestUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSError *error = nil;
        [formData appendPartWithFileURL:[NSURL URLWithString:filePath] name:name error:&error];
        (failure && error) ? failure(error) : nil;
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
        
    }];
    
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;

}

#pragma mark ————— 上传多张图片 —————
+(NSURLSessionTask *)uploadImageWithUrl:(NSString *)requestUrl parameters:(id)parameters name:(NSString *)name images:(NSArray<UIImage *> *)images fileNames:(NSArray<NSString *> *)fileNames imageScale:(CGFloat)imageScale imageType:(NSString *)imageType progress:(AntNetworkProgress)progress success:(AntHttpRequestSuccess)success failure:(AntHttpRequestFailed)failure{
    
    NSURLSessionTask *sessionTask =[_sessionManager POST:requestUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (NSUInteger i = 0; i < images.count; i++) {
            // 图片经过等比压缩后得到的二进制文件
            NSData *imageData = UIImageJPEGRepresentation(images[i], imageScale ?: 1.f);
            // 默认图片的文件名, 若fileNames为nil就使用
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *imageFileName = NSStringFormat(@"%@%ld.%@",str,i,imageType?:@"jpg");
            
            [formData appendPartWithFileData:imageData
                                        name:name
                                    fileName:fileNames ? NSStringFormat(@"%@.%@",fileNames[i],imageType?:@"jpg") : imageFileName
                                    mimeType:NSStringFormat(@"image/%@",imageType ?: @"jpg")];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
        
    }];
    
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;

}


#pragma mark ————— 下载文件 —————

+(NSURLSessionTask *)downloadWithURL:(NSString *)requestUrl fileDir:(NSString *)fileDir progress:(AntNetworkProgress)progress success:(void (^)(NSString *))success failure:(AntHttpRequestFailed)failure{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestUrl]];
    __block NSURLSessionDownloadTask *downloadTask=[_sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        //下载进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(downloadProgress) : nil;
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        //返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        [[self allSessionTask] removeObject:downloadTask];
        if(failure && error) {failure(error) ; return ;};
        success ? success(filePath.absoluteString /** NSURL->NSString*/) : nil;
        
    }];
    
    //开始下载
    [downloadTask resume];
    // 添加sessionTask到数组
    downloadTask ? [[self allSessionTask] addObject:downloadTask] : nil ;
    
    return downloadTask;
    
}


/**
 存储着所有的请求task数组
 */
+ (NSMutableArray *)allSessionTask {
    if (!_allSessionTask) {
        _allSessionTask = [[NSMutableArray alloc] init];
    }
    return _allSessionTask;
}



@end
