//
//  NSString+addMethod.h
//  LDCStaticFramework
//
//  Created by lindechun on 16/8/18.
//  Copyright © 2016年 lindechun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Encryption)
//MD5加密
- (NSString *)md5String;

@end

@interface NSString (RegularExpression)
//邮箱验证
- (BOOL)validateEmail;
//手机号验证
- (BOOL)validateMobile;
//身份证号验证
- (BOOL)validateIdentityCard;

@end

@interface NSString (Chinese)

- (NSString *)firstCharactor;

- (NSString *)firstCharactors;
//将中文字符串转为可用的URL字符串
- (NSString *)validUrlString;

@end