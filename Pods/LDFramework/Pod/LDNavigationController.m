//
//  LDNavigationController.m
//  ProductPrice
//
//  Created by 林德春 on 16/5/4.
//  Copyright © 2016年 lindechun. All rights reserved.
//

#import "LDNavigationController.h"
#import "LDViewController.h"

@interface LDNavigationController ()

@end

@implementation LDNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    
    self = [super initWithRootViewController:rootViewController];
    if (self) {

    }
    return self;
}

- (void)deleteNavigationBarBottomLine {
    
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage new]];
}

- (void)setNavigationBarBackgroundColor:(UIColor *)color titleTextAttributes:(NSDictionary<NSString *,id> *)titleTextAttributes {
    
    [self.navigationBar setTitleTextAttributes:titleTextAttributes];
    //设置bar类型会影响状态栏样式 
    self.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationBar.barTintColor = color;
    self.navigationBar.translucent = NO;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    LDViewController *root = (LDViewController *)viewController;
    if (self.viewControllers.count!=0) {
        [root createBackButtonItemWithImage:self.backButtonImageName imageOrigin:self.backButtonImageOrigin target:root action:@selector(popViewController)];
    }
    [super pushViewController:root animated:animated];
}
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    LDViewController *root = (LDViewController *)[super popViewControllerAnimated:animated];
    [root willPopViewController];
    return root;
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    NSArray<LDViewController *> *arr = [super popToViewController:viewController animated:animated];
    for (LDViewController *temp in arr) {
        [temp willPopViewController];
    }
    return arr;
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    
    NSArray<LDViewController *> *arr = [super popToRootViewControllerAnimated:animated];
    for (LDViewController *temp in arr) {
        [temp willPopViewController];
    }
    return arr;
}

@end
