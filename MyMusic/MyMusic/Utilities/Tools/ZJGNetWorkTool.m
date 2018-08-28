//
//  ZJGNetWorkTool.m
//  MyMusic
//
//  Created by 赵建钢 on 2018/2/21.
//  Copyright © 2018年 赵建钢. All rights reserved.
//

#import "ZJGNetWorkTool.h"
#import "AFNetworking.h"
@implementation ZJGNetWorkTool
+ (void)netWorkToolGetWithUrl:(NSString *)url parameters:(NSDictionary *)parameters response:(void (^)(id))success {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status <=0) {
            [ZJGPromptTool promptModeText:@"网络未连接" afterDelay:2];
        }else {
            MBProgressHUD *netPrompt = [ZJGPromptTool promptModeIndeterminatetext:@"加载中,请稍后"];
            //加载数据
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"application/javascript", nil];
            [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (responseObject) {
                    [netPrompt removeFromSuperview];
                    if (success) {
                        success(responseObject);
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [netPrompt removeFromSuperview];
                NSLog(@"%@",error);
            }];
        }
    }];
    
    
    
}
+ (void)netWorkToolDownloadWithUrl:(NSString *)string targetPath:(NSSearchPathDirectory)path DomainMask:(NSSearchPathDomainMask)mask endPath:(void (^)(NSURL *))endPath {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *documentUrl = [[NSFileManager defaultManager] URLForDirectory:path inDomain:mask appropriateForURL:nil create:NO error:nil];
        return [documentUrl URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"%@",error);
        if (!error && endPath) {
            endPath(filePath);
        }
    }];
    [downloadTask resume];
}
@end
