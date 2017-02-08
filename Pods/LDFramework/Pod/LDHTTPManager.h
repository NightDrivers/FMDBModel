//
//  LDHTTPManager.h
//  LDFramework
//
//  Created by lindechun on 17/1/12.
//  Copyright © 2017年 lindechun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(id jsonObject);

typedef void(^FailureBlock)(void);

typedef NSDictionary *(^EncryptionBlock)(NSDictionary *parameters);

@interface LDHTTPManager : NSObject

/**
 *  get请求
 *
 *  @param urlString  接口
 *  @param parameters 参数字典
 *  @param success    成功回调
 *  @param failure    失败回调
 *  @param show       是否需要请求活动标识
 */
+ (void)PostWithUrl:(NSString *)urlString pramaters:(NSDictionary *)parameters
     SuccessExecute:(SuccessBlock)success
     FailureExecute:(FailureBlock)failure needActivityIndicator:(BOOL)show;
/**
 *  post请求
 *
 *  @param urlString  接口
 *  @param parameters 参数字典
 *  @param success    成功回调
 *  @param failure    失败回调
 *  @param show       是否需要请求活动标识
 */
+ (void)GetWithUrl:(NSString *)urlString pramaters:(NSDictionary *)parameters
     SuccessExecute:(SuccessBlock)success
     FailureExecute:(FailureBlock)failure needActivityIndicator:(BOOL)show;
/**
 *  设置加密算法，存在block中
 *
 *  @param encrytionBlock block
 */
+ (void)setEncrytionBlock:(EncryptionBlock)encrytionBlock;
/**
 *  加密的post请求
 *
 *  @param urlString  加密接口
 *  @param parameters 参数字典
 *  @param success    成功回调
 *  @param failure    失败回调
 *  @param show       是否需要请求活动标识
 */
+ (void)encrytionPostWithUrl:(NSString *)urlString pramaters:(NSDictionary *)parameters
     SuccessExecute:(SuccessBlock)success
     FailureExecute:(FailureBlock)failure needActivityIndicator:(BOOL)show;
/**
 *  加密的get请求
 *
 *  @param urlString  加密接口
 *  @param parameters 参数字典
 *  @param success    成功回调
 *  @param failure    失败回调
 *  @param show       是否需要请求活动标识
 */
+ (void)encrytionGetWithUrl:(NSString *)urlString pramaters:(NSDictionary *)parameters
    SuccessExecute:(SuccessBlock)success
    FailureExecute:(FailureBlock)failure needActivityIndicator:(BOOL)show;

@end
