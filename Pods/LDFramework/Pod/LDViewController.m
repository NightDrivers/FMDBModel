//
//  LDViewController.m
//  ProductPrice
//
//  Created by 林德春 on 16/4/20.
//  Copyright © 2016年 lindechun. All rights reserved.
//

#import "LDViewController.h"
#import "LDNavigationController.h"

@implementation LDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.ld_NavigationController.navigationBar.translucent = NO;

}

- (void)pushViewController:(UIViewController *)controller animated:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:controller animated:animated];
}

- (void)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [self.navigationController popToViewController:viewController animated:YES];
}

- (void)popViewControllerAnimated:(BOOL)animated{
    
    [self.navigationController popViewControllerAnimated:animated];
}

- (void)popToRootViewControllerAnimated:(BOOL)animated {
    
    [self.navigationController popToRootViewControllerAnimated:animated];
}

- (void)popViewController {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)willPopViewController {
    
}

- (void)dealloc {
    
    NSLog(@"%@--dealloc",[self class]);
}

@end

@implementation LDViewController (LDNavigationController)

- (LDNavigationController *)ld_NavigationController {
    
    return (LDNavigationController *)self.navigationController;
}

- (UIBarButtonItem *)createBarButtonItemWithImage:(NSString *)imageName imageOrigin:(CGPoint)origin
                                           target:(id)target action:(SEL)action{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, 44);
    UIImage *image = [UIImage imageNamed:imageName];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.imageEdgeInsets = UIEdgeInsetsMake(origin.y, origin.x, 44 - image.size.height - origin.y, 44 - image.size.width - origin.x);
    [button setImage:image forState:UIControlStateNormal];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return barButtonItem;
}

- (void)createBackButtonItemWithImage:(NSString *)imageName imageOrigin:(CGPoint)origin target:(id)target action:(SEL)action {
    
    UIBarButtonItem *barButtonItem = [self createBarButtonItemWithImage:imageName imageOrigin:origin target:target action:action];
    self.navigationItem.leftBarButtonItems = @[barButtonItem];
}

- (UIBarButtonItem *)createBarButtonItemText:(NSString *)text fontSize:(CGFloat)size
                                   textColor:(UIColor *)color target:(id)target action:(SEL)action {
    
    CGRect frame = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, size) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]} context:nil];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, frame.size.width<44?44:frame.size.width, 44);
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:size];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return barButtonItem;
}

@end
