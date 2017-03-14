//
//  LDModel.h
//  LDFramework
//
//  Created by lindechun on 17/1/16.
//  Copyright © 2017年 lindechun. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 这是为以后创建数据模型类构建的基类，为子类提供构造方法，子类继承实例化时只用调用父类的构造方法即可，通常用于网络请求的数据解析.
 
 注意：如果提供的字典中的key与系统关键字冲突，可以转为大写，用字典给实例设置值时是大小写模糊的.
        如：字典中的key为 id 属性名为ID的属性依然可以取到对应的值.切忌不要再一个子类中同时存在uppercaseString值相同的字符串.

 */
@interface LDModel : NSObject<NSCoding>

/**
 *  遍历本类所有变量，如果字典里有变量对应的key，就对变量进行赋值
 *
 *  @param dic 传入的字典
 *
 *  @return 返回本类实例
 */
- (instancetype)initPropertyWithDictionary:(NSDictionary *)dic;

- (void)setPropertyWithDictionary:(NSDictionary *)dic;

//用相同类对象设置自身
- (void)setupSelf:(LDModel *)model;
/**
 *  生成一个包含实例中所有属性信息的字典
 *
 *  @return 字典
 */
- (NSDictionary *)getDic;
/**
 *  清空所有属性
 */
- (void)clearAllProperty;

@end
