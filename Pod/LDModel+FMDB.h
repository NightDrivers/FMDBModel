//
//  LDModel+FMDB.h
//  version
//
//  Created by lindechun on 17/2/6.
//  Copyright © 2017年 lindechun. All rights reserved.
//

#import <LDFramework/LDFramework.h>
#import <FMDB/FMDB.h>

@interface FMDatabase (sharedFMDatabase)

+ (instancetype)sharedFMDatabase;

@end
/**
 *  子类属性暂时只支持NSString、NSNumber,建表后修改数据模型后应该删表重新建表，不然会引起未知错误
 */
@interface LDModel (FMDB)

@property (nonatomic, weak) FMDatabase *database;
//将对象插入表中
- (void)insertIntoTable;
/**
 *  更新属性值等于value的记录,会修改所有该列值为value的纪录
 *
 *  @param name  属性名
 *  @param value 属性值
 */
- (void)updateWherePropertyName:(NSString *)name equal:(id)value;
//如果数据库内没有对应的表，就创建一张
+ (void)createTableIfNotExist;
//删表
+ (void)deleteTableIfExists;
/**
 *  获取表中属性值最大值
 *
 *  @param name 属性名
 *
 *  @return
 */
+ (id)maxModelWithPropertyName:(NSString *)name;
/**
 *  删除表中属性为value的对象
 *
 *  @param name  属性名
 *  @param value 属性值
 */
+ (void)deleteInstanceWithPropertyName:(NSString *)name value:(id)value;
//返回所有对象
+ (NSMutableArray *)allInstances;
//获取列值为value的记录
+ (NSMutableArray *)instancesPropertyName:(NSString *)name eaqualTo:(id)value;
@end
