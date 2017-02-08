//
//  LDViewController.h
//  ProductPrice
//
//  Created by 林德春 on 16/4/20.
//  Copyright © 2016年 lindechun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LDNavigationController;

@interface LDViewController : UIViewController

- (void)pushViewController:(UIViewController *)controller animated:(BOOL)animated;

- (void)popViewControllerAnimated:(BOOL)animated;

- (void)popToViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (void)popToRootViewControllerAnimated:(BOOL)animated;
//控制器将要pop时调用的方法，本类为空实现
- (void)willPopViewController;
//返回按钮会调用这个方法，将控制器pop
- (void)popViewController;

@end

@interface LDViewController (LDNavigationController)

@property (nonatomic, weak, readonly) LDNavigationController *ld_NavigationController;
/**
 *  用图片创建UIBarButtonItem实例
 *
 *  @param imageName 图片名
 *  @param origin    图片距上距左距离
 *  @param target    target
 *  @param action    action
 *
 *  @return 实例
 */
- (UIBarButtonItem *)createBarButtonItemWithImage:(NSString *)imageName imageOrigin:(CGPoint)origin
                                           target:(id)target action:(SEL)action;
/**
 *  设置返回按钮
 *
 *  @param imageName 图片名
 *  @param origin    图片距上距左距离
 *  @param target    target
 *  @param action    action
 */
- (void)createBackButtonItemWithImage:(NSString *)imageName imageOrigin:(CGPoint)origin
                               target:(id)target action:(SEL)action;
/**
 *  用字符串创建UIBarButtonItem实例
 *
 *  @param text   字符串
 *  @param size   字体大小
 *  @param color  字体颜色
 *  @param target target
 *  @param action action
 *
 *  @return 实例
 */
- (UIBarButtonItem *)createBarButtonItemText:(NSString *)text fontSize:(CGFloat)size
                                   textColor:(UIColor *)color target:(id)target action:(SEL)action;

@end
