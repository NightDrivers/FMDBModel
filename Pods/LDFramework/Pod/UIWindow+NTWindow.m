//
//  UIWindow+NTWindow.m
//  netTaxi_passenger
//
//  Created by lindechun on 16/10/19.
//  Copyright © 2016年 lindechun. All rights reserved.
//

#import "UIWindow+NTWindow.h"
#import "AppStatic.h"
#import "HexColor.h"
#import <objc/runtime.h>
#import "MBProgressHUD.h"

@interface UIWindow ()

@property (nonatomic, strong) UILabel *alertLabel;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong) UIView  *statusBarView;

@property (nonatomic, strong) MBProgressHUD *progressHud;

@end

static UIWindow *window;

const void *keyIndicatorColor = "indicator.color";
const void *keyAlertLabel = @"key.alert.label";
const void *keyStatusBarView = @"key.status.bar.view";
const void *keyIndicatorView = @"key.indicator.view";
const void *keyProgressHud = @"key.progress.hud";
const void *keyIndicatorTextColor = @"key.indicator.text.color";

@implementation UIWindow (NTWindow)

+ (instancetype)sharedWindowWithRootViewController:(UIViewController *)viewController {
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        window = [[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
    });
    window.rootViewController = viewController;
    return window;
}

+ (instancetype)sharedWindow {
    
    if (!window.rootViewController) {
        [NSException exceptionWithName:@"window rootViewController nil exception" reason:@"UIWindow对象没有对应的根视图控制器" userInfo:nil];
    }
    return window;
}

- (void)setIndicatorViewColor:(UIColor *)indicatorViewColor {
    
    objc_setAssociatedObject(self, keyIndicatorColor, indicatorViewColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)indicatorViewColor {
    
    UIColor *_indicatorViewColor = objc_getAssociatedObject(self, keyIndicatorColor);
    if (!_indicatorViewColor) {
        self.indicatorViewColor = [UIColor blackColor];
        _indicatorViewColor = objc_getAssociatedObject(self, keyIndicatorColor);
    }
    return _indicatorViewColor;
}

- (void)setIndicatorTextColor:(UIColor *)indicatorTextColor {
    
    objc_setAssociatedObject(self, keyIndicatorTextColor, indicatorTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)indicatorTextColor {
    
    UIColor *_indicatorTextColor = objc_getAssociatedObject(self, keyIndicatorTextColor);
    if (!_indicatorTextColor) {
        self.indicatorTextColor = [UIColor blackColor];
        _indicatorTextColor = objc_getAssociatedObject(self, keyIndicatorTextColor);
    }
    return _indicatorTextColor;
}

#pragma mark 活动标示
- (UIActivityIndicatorView *)indicatorView {
    
    UIActivityIndicatorView *_indicatorView = objc_getAssociatedObject(self, keyIndicatorView);
    if (!_indicatorView) {
        self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _indicatorView = objc_getAssociatedObject(self, keyIndicatorView);
        _indicatorView.frame = CGRectMake((screenW - 30)/2, (screenH - 30)/2, 30, 30);
        _indicatorView.color = self.indicatorViewColor?self.indicatorViewColor:[UIColor blackColor];
        [self addSubview:_indicatorView];
    }
    return _indicatorView;
}

- (void)setIndicatorView:(UIActivityIndicatorView *)indicatorView {
    
    objc_setAssociatedObject(self, keyIndicatorView, indicatorView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showRequestActivity {
    
    [self.indicatorView startAnimating];
}

- (void)hiddenRequestActivity {
    
    [self.indicatorView stopAnimating];
}

#pragma mark 信息提示
- (UILabel *)alertLabel {
    
    UILabel *_alertLabel = objc_getAssociatedObject(self, keyAlertLabel);
    if (!_alertLabel) {
        self.alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(24.5, (screenH - 50)/2, screenW - 24.5*2, 50)];
        _alertLabel = objc_getAssociatedObject(self, keyAlertLabel);
        _alertLabel.backgroundColor = [[HexColor hexStringToColor:@"#D1D1D1"] colorWithAlphaComponent:0.8];
        _alertLabel.textAlignment = NSTextAlignmentCenter;
        _alertLabel.font = [UIFont systemFontOfSize:12.f];
        _alertLabel.textColor = [HexColor hexStringToColor:@"#333333"];
        
        _alertLabel.layer.cornerRadius = 5.f;
        _alertLabel.layer.masksToBounds = YES;
    }
    return _alertLabel;
}

- (void)setAlertLabel:(UILabel *)alertLabel {
    
    objc_setAssociatedObject(self, keyAlertLabel, alertLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showMyAlertViewWithText:(NSString *)text {
    
    self.alertLabel.text = text;
    [self addSubview:self.alertLabel];
    [self.alertLabel performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1];
}

#pragma mark 状态栏背景色设置
- (UIView *)statusBarView {
    
    UIView *_statusBarView = objc_getAssociatedObject(self, keyStatusBarView);
    if (!_statusBarView) {
        self.statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, StatusBarHeight)];
        _statusBarView = objc_getAssociatedObject(self, keyStatusBarView);
    }
    return _statusBarView;
}

- (void)setStatusBarView:(UIView *)statusBarView {
    
    objc_setAssociatedObject(self, keyStatusBarView, statusBarView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setStatusViewColor:(UIColor *)color {
    
    self.statusBarView.backgroundColor = color;
    [self addSubview:self.statusBarView];
}

- (void)hiddenStatusView {
    
    [self.statusBarView removeFromSuperview];
}

#pragma mark --MBProgressHud--

- (MBProgressHUD *)progressHud {
    
    MBProgressHUD *progressHud = objc_getAssociatedObject(self, keyProgressHud);
    if (!progressHud) {
        progressHud = [[MBProgressHUD alloc] initWithView:self];
        progressHud.label.text = @"加载中";
        progressHud.contentColor = self.indicatorViewColor;
        progressHud.label.textColor = self.indicatorTextColor;
        self.progressHud = progressHud;
        [self addSubview:progressHud];
    }
    return progressHud;
}

- (void)setProgressHud:(MBProgressHUD *)progressHud {
    
    objc_setAssociatedObject(self, keyProgressHud, progressHud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showMBProgressHudActivity {
    
    [self.progressHud showAnimated:YES];
}

- (void)hiddenMBProgressHudActivity {
    
    [self.progressHud hideAnimated:YES];
}

@end
