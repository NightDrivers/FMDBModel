//
//  AppStatic.h
//  DCFramework
//
//  Created by lindechun on 16/9/14.
//  Copyright © 2016年 lindechun. All rights reserved.
//

#ifndef AppStatic_h
#define AppStatic_h

#define  screenW                             [UIScreen mainScreen].bounds.size.width
#define  screenH                             [UIScreen mainScreen].bounds.size.height

// 状态栏高度
#define  StatusBarHeight                   20.f

// 导航栏高度
#define  NavigationBarHeight               44.f

// 标签栏高度
#define  TabbarHeight                      49.f

// 状态栏高度 + 导航栏高度
#define  StatusBarAndNavigationBarHeight   (20.f + 44.f)

#define  iPhone4_4s   (screenW == 320.f && screenH == 480.f ? YES : NO)
#define  iPhone5_5s   (screenW == 320.f && screenH == 568.f ? YES : NO)
#define  iPhone6      (screenW == 375.f && screenH == 667.f ? YES : NO)
#define  iPhone6_plus (screenW == 414.f && screenH == 736.f ? YES : NO)

#ifdef DEBUG 

#define NSLog(format, ...) do {                                                                          \
fprintf(stderr, "<%s : %d> %s\n",                                           \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__, __func__);                                                        \
(NSLog)((format), ##__VA_ARGS__);                                           \
fprintf(stderr, "-------\n");                                               \
} while (0)

#else

#define NSLog(format, ...)

#endif

#endif /* AppStatic_h */
