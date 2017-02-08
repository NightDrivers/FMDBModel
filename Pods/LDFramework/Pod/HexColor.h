//

//  Copyright (c). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HexColor : NSObject

/*
 * 十六进制颜色值转换成UIColor对象
 */
+ (UIColor *) hexStringToColor: (NSString *) stringToConvert;


/*
 *  UIColor对象转换成十六进制颜色值字符串
 */
+ (NSString *) changeUIColorToRGB:(UIColor *)color;
/**
 *  随机颜色
 *
 *  @return 颜色实例
 */
+ (UIColor *)randomColor;

@end
