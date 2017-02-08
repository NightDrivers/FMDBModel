//
//  LDNavigationController.h
//  ProductPrice
//
//  Created by 林德春 on 16/5/4.
//  Copyright © 2016年 lindechun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDNavigationController : UINavigationController
/**
 *  返回按钮图片
 */
@property (nonatomic, copy) NSString *backButtonImageName;
/**
 *  返回按钮图片位置，定位距上距左距离
 */
@property (nonatomic, assign) CGPoint backButtonImageOrigin;
/**
 *  删除导航栏底部的线
 */
- (void)deleteNavigationBarBottomLine;
/**
 *  设置导航栏样式
 *
 *  @param color               背景色
 *  @param titleTextAttributes 字体样式
 */
- (void)setNavigationBarBackgroundColor:(UIColor *)color titleTextAttributes:(NSDictionary<NSString *,id> *)titleTextAttributes;

@end
