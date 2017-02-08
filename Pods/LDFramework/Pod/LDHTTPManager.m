//
//  LDHTTPManager.m
//  LDFramework
//
//  Created by lindechun on 17/1/12.
//  Copyright © 2017年 lindechun. All rights reserved.
//

#import "LDHTTPManager.h"
#import "NSDictionary+NTDescription.h"
#import "UIWindow+NTWindow.h"

#define LD_TIMEOUT 10

static EncryptionBlock _encrytionBlock;

@interface LDHTTPManager ()

@property (nonatomic, strong) NSURLSession *urlSession;

@end

@implementation LDHTTPManager

+ (instancetype)manager {
    
    LDHTTPManager *manager = [[self alloc] init];
    return manager;
}

#pragma mark --get post 请求--

+ (void)PostWithUrl:(NSString *)urlString pramaters:(NSDictionary *)parameters
    SuccessExecute:(SuccessBlock)success
    FailureExecute:(FailureBlock)failure needActivityIndicator:(BOOL)show {
    
    if (show) {
        [[UIWindow sharedWindow] showMBProgressHudActivity];
    }
    
    LDHTTPManager *manager = [self manager];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.timeoutInterval = LD_TIMEOUT;
    request.HTTPMethod = @"POST";
    request.HTTPBody = [[parameters urlDataString] dataUsingEncoding:NSUTF8StringEncoding];
    
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *task = [manager.urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf handleResponseData:data response:response error:error successExecute:success failureExecute:failure needActivityIndicator:show];
        });
    }];
    [task resume];
}

+ (void)GetWithUrl:(NSString *)urlString pramaters:(NSDictionary *)parameters
    SuccessExecute:(SuccessBlock)success
    FailureExecute:(FailureBlock)failure needActivityIndicator:(BOOL)show {
    
    if (show) {
        [[UIWindow sharedWindow] showMBProgressHudActivity];
    }
    
    LDHTTPManager *manager = [self manager];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@",urlString,[parameters urlDataString]]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.timeoutInterval = LD_TIMEOUT;
    request.HTTPMethod = @"GET";
    
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *task = [manager.urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf handleResponseData:data response:response error:error successExecute:success failureExecute:failure needActivityIndicator:show];
        });
    }];
    [task resume];
}

+ (void)handleResponseData:(NSData *)data response:(NSURLResponse *)response
                     error:(NSError *)error successExecute:(SuccessBlock)success
            failureExecute:(FailureBlock)failure needActivityIndicator:(BOOL)show {
    
    if (error) {
        
        NSLog(@"%@",error);
        if (failure) {
            failure();
        }
    }else {
        
        NSError *jsonSerialzationError = nil;;
        id response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonSerialzationError];
        if (jsonSerialzationError) {
            
            NSLog(@"%@",jsonSerialzationError);
        }else {
            
            success(response);
        }
    }
    if (show) {
        [[UIWindow sharedWindow] hiddenMBProgressHudActivity];
    }
}

+ (void)setEncrytionBlock:(EncryptionBlock)encrytionBlock {
    
    _encrytionBlock = encrytionBlock;
}

+ (void)encrytionPostWithUrl:(NSString *)urlString pramaters:(NSDictionary *)parameters SuccessExecute:(SuccessBlock)success FailureExecute:(FailureBlock)failure needActivityIndicator:(BOOL)show {
    
    NSAssert(_encrytionBlock, @"没有加密算法，无法进行加密请求");
    NSDictionary *encrytionDic = _encrytionBlock(parameters);
    [self PostWithUrl:urlString pramaters:encrytionDic SuccessExecute:success FailureExecute:failure needActivityIndicator:show];
}

+ (void)encrytionGetWithUrl:(NSString *)urlString pramaters:(NSDictionary *)parameters SuccessExecute:(SuccessBlock)success FailureExecute:(FailureBlock)failure needActivityIndicator:(BOOL)show {
    
    NSAssert(_encrytionBlock, @"没有加密算法，无法进行加密请求");
    NSDictionary *encrytionDic = _encrytionBlock(parameters);
    [self GetWithUrl:urlString pramaters:encrytionDic SuccessExecute:success FailureExecute:failure needActivityIndicator:show];
}

#pragma mark --lazyInit--

- (NSURLSession *)urlSession {
    
    if (!_urlSession) {
        _urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return _urlSession;
}

@end
