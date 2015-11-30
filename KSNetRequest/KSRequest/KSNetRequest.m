//
//  KSNetRequest.m
//  Test
//
//  Created by KS on 15/11/24.
//  Copyright © 2015年 xianhe. All rights reserved.
//
#import "KSCache.h"

#import "KSNetRequest.h"
#import <AFNetworking.h>
#import "ProgressHUD.h"
#import "UIViewController+KSNoNetController.h"

//===========================请求超时时间==========================//
#define TIMEOUTINTERVAL 30
//====================是不是需要缓存==YES需要==NO不需要====================//
#define ISCACHE YES


@interface KSNetRequest ()

@end

@implementation KSNetRequest

/**
 *  判断网络状态的POST请求
 */
+ (void)requestTarget:(UIViewController*)target POST:(nonnull NSString*)URLString parameters:(nullable id)parameters success:(requestSuccess)success failure:(requestFailure)failure
{
    if ([self checkNetState]) {
        [target hiddenNonetWork];
        
        [self requestCache:URLString parameters:parameters success:success failure:failure];
        
    }else{
        [target showNonetWork];
    
        success?success(nil,nil):nil;
        failure?failure(nil,nil):nil;
    }
}

/**
 *  添加Cache
 */
+ (void)requestCache:(nonnull NSString*)URLString parameters:(nullable id)parameters success:(requestSuccess)success failure:(requestFailure)failure
{
    
    if (ISCACHE) {
        success(nil,[KSCache selectObjectWithURL:URLString parameter:parameters]);
        [self requestProgress:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
            #warning warning
            //=====这个判断需要和后台协商，什么情况下请求成功=然后才可以缓寸=====================================================//
            if ([responseObject[@"result"] isEqualToString:@"0"]) {
            //======================================================//
                [KSCache updateObject:responseObject withURL:URLString parameter:parameters];
                
            }
            success?success(task,responseObject):nil;
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
            failure?failure(task,error):nil;
        }];
    }else{
        [self requestProgress:URLString parameters:parameters success:success failure:failure];
    }
}
/**
 *  带活动指示器的请求
 */
+ (void)requestProgress:(nonnull NSString*)URLString parameters:(nullable id)parameters success:(requestSuccess)success failure:(requestFailure)failure
{
    [ProgressHUD show:@"Loading..."];
    
    [self requestPOST:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        [ProgressHUD dismiss];
        
        success?success(task,responseObject):nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        [ProgressHUD dismiss];
        
        failure?failure(task,error):nil;
    }];
}
/**
 *  基本POST请求
 */
+ (void)requestPOST:(nonnull NSString*)URLString parameters:(nullable id)parameters success:(requestSuccess)success failure:(requestFailure)failure
{
    AFHTTPSessionManager* manager = [self getManager];
    
    [manager POST:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        //先判断是否有回调，然后回调
        success?success(task,responseObject):nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //如果有回调，则返回处理
        failure?failure(task,error):NSLog(@"%@",error);
    }];
}


/**
 *  判断网络状态
 *
 *  @return 返回状态 YES 为有网 NO 为没有网
 */
+ (BOOL)checkNetState
{ 
    return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus > 0;
}

/**
 *  创建请求者
 *
 *  @return AFHTTPSessionManager
 */
+ (AFHTTPSessionManager*)getManager
{
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    //设置请求超时
    manager.requestSerializer.timeoutInterval = TIMEOUTINTERVAL;
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"html/text",@"text/json",nil];
    return manager;
}
@end
