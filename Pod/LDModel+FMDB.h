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
 *  子类属性暂时只支持NSString、NSNumber
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

@end
