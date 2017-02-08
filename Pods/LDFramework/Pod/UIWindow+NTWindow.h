//
//  UIWindow+NTWindow.h
//  netTaxi_passenger
//
//  Created by lindechun on 16/10/19.
//  Copyright © 2016年 lindechun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (NTWindow)
//活跃标识转轮颜色
@property (nonatomic, strong) UIColor *indicatorViewColor;
//活跃标识文字颜色
@property (nonatomic, strong) UIColor *indicatorTextColor;
/**
 *  用控制器创建窗口单例，或修改该窗口的root控制器
 *
 *  @param viewController 控制器
 *
 *  @return 窗口实例
 */
+ (instancetype)sharedWindowWithRootViewController:(UIViewController *)viewController;

+ (instancetype)sharedWindow;

- (void)showMyAlertViewWithText:(NSString *)text;

#pragma mark --状态栏颜色--
- (void)setStatusViewColor:(UIColor *)color;

- (void)hiddenStatusView;

#pragma mark --MBProgressHUD--
- (void)showMBProgressHudActivity;

- (void)hiddenMBProgressHudActivity;

@end
