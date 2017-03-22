//
//  LDModel+FMDB.m
//  version
//
//  Created by lindechun on 17/2/6.
//  Copyright © 2017年 lindechun. All rights reserved.
//

#import "LDModel+FMDB.h"
#import <objc/runtime.h>

@implementation FMDatabase (sharedFMDatabase)

+ (instancetype)sharedFMDatabase {
    
    static FMDatabase *database;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        database = [[self alloc] initWithPath:[NSString stringWithFormat:@"%@/%@.db",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject,[NSBundle mainBundle].infoDictionary[@"CFBundleName"]]];
    });
    return database;
}

@end

const char *keyDatabase = "key.database";

@implementation LDModel (FMDB)

#pragma mark --建表--
//如果没有对应的表
+ (void)createTableIfNotExist {
    
    FMDatabase *database = [FMDatabase sharedFMDatabase];
    
    NSString *sql = [self createTableSql];
    [self executeUpdate:database block:^BOOL{
        return [database executeUpdate:sql];
    }];
}
//创建和类对应表的sql语句
+ (NSString *)createTableSql {
    
    NSMutableString *sql = [[NSMutableString alloc] initWithFormat:@"create table if not exists %@ ",[self class]];
    
    NSMutableArray<NSString *> *tempArray = [[NSMutableArray alloc] init];
    [self traverseIvarWithExecute:^(Ivar ivar) {
        char *tempType;
        if (strcmp(ivar_getTypeEncoding(ivar), "@\"NSNumber\"")==0) {
            tempType = "integer";
        }else if (strcmp(ivar_getTypeEncoding(ivar), "@\"NSString\"")==0) {
            tempType = "varchar(256)";
        }else {
            [NSException raise:@"类里面包含不支持的数据类型" format:@""];
        }
        [tempArray addObject:[NSString stringWithFormat:@"%s %s",ivar_getName(ivar),tempType]];
    }];
    
    [sql appendFormat:@"(%@)",[tempArray componentsJoinedByString:@","]];
    return sql;
}
#pragma mark --删表--
//删除类对应的表，实际开发可能用处不大，用于测试
+ (void)deleteTableIfExists {
    
    FMDatabase *database = [FMDatabase sharedFMDatabase];
    
    NSString *sql = [NSString stringWithFormat:@"drop table if exists %@",[self class]];
    [self executeUpdate:database block:^BOOL{
        return [database executeUpdate:sql];
    }];
}

#pragma mark --插入--
//将对象信息插入表中
- (void)insertIntoTable {
    
    FMDatabase *database = self.database;
    
    NSString *sql = [self insertIntoTableSql];
    [self.class executeUpdate:database block:^BOOL{
        
        NSError *error = nil;
        
        BOOL success = [database executeUpdate:sql values:[self values] error:&error];
        
        if (error) {
            NSLog(@"%@",error);
        }
        return success;
    }];
}
//插入一条记录sql
- (NSString *)insertIntoTableSql {
    
    NSMutableString *sql = [[NSMutableString alloc] initWithFormat:@"insert into %@",[self class]];
    
    NSMutableArray<NSString *> *keywords = [[NSMutableArray alloc] init];
    NSMutableArray<NSString *> *placeholders = [[NSMutableArray alloc] init];
    
    [self.class traverseIvarWithExecute:^(Ivar ivar) {
        [keywords addObject:[NSString stringWithFormat:@"%s",ivar_getName(ivar)]];
        [placeholders addObject:@"?"];
    }];
    
    [sql appendFormat:@"(%@) values(%@)",[keywords componentsJoinedByString:@","],[placeholders componentsJoinedByString:@","]];
    // return @"insert into 表名(字段1,字段2,...) values(?,?,...)"
    return sql;
}

#pragma mark --修改--

- (void)updateWherePropertyName:(NSString *)name equal:(id)value {
    
    FMDatabase *database = self.database;
    
    __weak typeof(self) weakSelf = self;
    NSString *sql = [[self class] updateSqlWithKey:[NSString stringWithFormat:@"_%@",name]];
    [self.class executeUpdate:database block:^BOOL{
        
        NSError *error = nil;
        
        NSMutableArray *tempArr = [weakSelf values];
        [tempArr addObject:value];
        BOOL success = [database executeUpdate:sql values:tempArr error:&error];
        
        if (error) {
            NSLog(@"%@",error);
        }
        return success;
    }];
}

+ (NSString *)updateSqlWithKey:(NSString *)key {
    
    NSMutableString *sql = [[NSMutableString alloc] initWithFormat:@"update %@ set ",[self class]];
    
    NSMutableArray<NSString *> *setCompenents = [[NSMutableArray alloc] init];
    
    [self traverseIvarWithExecute:^(Ivar ivar) {
        [setCompenents addObject:[NSString stringWithFormat:@"%@ = ?",[NSString stringWithFormat:@"%s",ivar_getName(ivar)]]];
    }];

    [sql appendFormat:@"%@ where %@ = ?",[setCompenents componentsJoinedByString:@","],key];
    //return @"update %@ set 字段1 ＝ ?,字段2 ＝ ? ... where key = ?"
    return sql;
}

#pragma mark --删除记录--

+ (void)deleteInstanceWithPropertyName:(NSString *)name value:(id)value {
    
    FMDatabase *database = [FMDatabase sharedFMDatabase];
    
    NSString *sql = [self deletesqlWithKey:name];
    [self executeUpdate:database block:^BOOL{
        return [database executeUpdate:sql,value];
    }];
}

+ (NSString *)deletesqlWithKey:(NSString *)key {
    
    return [NSString stringWithFormat:@"delete from %@ where _%@ = ?",self,key];
}

#pragma mark --查找--
//获取存储在表中的所有该类实例
+ (NSMutableArray *)allInstances {
    
    NSString *sql = [NSString stringWithFormat:@"select * from %@",self];
    FMDatabase *database = [FMDatabase sharedFMDatabase];
    NSMutableArray *instances = [[NSMutableArray alloc] init];
    
    BOOL open = [database open];
    if (open) {
        
        FMResultSet *set = [database executeQuery:sql];
        while ([set next]) {
            
            LDModel *model = [[self alloc] init];
            
            [self traverseIvarWithExecute:^(Ivar ivar) {
                
                if (strcmp(ivar_getTypeEncoding(ivar), "@\"NSNumber\"")==0) {
                    
                    object_setIvar(model, ivar, @([set doubleForColumn:[NSString stringWithFormat:@"%s",ivar_getName(ivar)]]));
                }else if (strcmp(ivar_getTypeEncoding(ivar), "@\"NSString\"")==0) {
                    
                    object_setIvar(model, ivar, [set stringForColumn:[NSString stringWithFormat:@"%s",ivar_getName(ivar)]]);
                }else {
                    [NSException raise:@"类里面包含不支持的数据类型" format:@""];
                }
            }];
            [instances addObject:model];
        }
    }else {
        
        NSLog(@"%@",database.lastErrorMessage);
    }
    
    [database close];
    return instances;
}

+ (NSMutableArray *)instancesPropertyName:(NSString *)name eaqualTo:(id)value {
    
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where _%@ = ?",self,name];
    
    FMDatabase *database = [FMDatabase sharedFMDatabase];
    NSMutableArray *instances = [[NSMutableArray alloc] init];
    
    BOOL open = [database open];
    if (open) {
        
        FMResultSet *set = [database executeQuery:sql,value];
        while ([set next]) {
            
            LDModel *model = [[self alloc] init];
            
            [self traverseIvarWithExecute:^(Ivar ivar) {
                if (strcmp(ivar_getTypeEncoding(ivar), "@\"NSNumber\"")==0) {
                    
                    object_setIvar(model, ivar, @([set longLongIntForColumn:[NSString stringWithFormat:@"%s",ivar_getName(ivar)]]));
                }else if (strcmp(ivar_getTypeEncoding(ivar), "@\"NSString\"")==0) {
                    
                    object_setIvar(model, ivar, [set stringForColumn:[NSString stringWithFormat:@"%s",ivar_getName(ivar)]]);
                }else {
                    [NSException raise:@"类里面包含不支持的数据类型" format:@""];
                }
            }];
    
            [instances addObject:model];
        }
    }else {
        
        NSLog(@"%@",database.lastErrorMessage);
    }
    
    [database close];
    return instances;
}
#pragma mark --通用--
//获取对象中的value信息
- (NSMutableArray *)values {
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    [self.class traverseIvarWithExecute:^(Ivar ivar) {
        id value = object_getIvar(self, ivar);
        if (!value) {
            if (strcmp(ivar_getTypeEncoding(ivar), "@\"NSNumber\"")==0) {
                
                value = @0;
            }else if (strcmp(ivar_getTypeEncoding(ivar), "@\"NSString\"")==0) {
                
                value = @"";
            }else {
                [NSException raise:@"类里面包含不支持的数据类型" format:@""];
            }
        }
        [values addObject:value];
    }];
    
    return values;
}
//获取某一列的最大值
+ (id)maxModelWithPropertyName:(NSString *)name {
    
    NSString *sql = [self maxSqlWithKey:name];
    FMDatabase *database = [FMDatabase sharedFMDatabase];
    NSString *tempStr = [NSString stringWithFormat:@"_%@",name];
    id maxValue;
    
    BOOL open = [database open];
    if (open) {
        
        FMResultSet *set = [database executeQuery:sql];
        while ([set next]) {
            
            Ivar ivar = class_getInstanceVariable(self, [tempStr cStringUsingEncoding:NSUTF8StringEncoding]);
            if (strcmp(ivar_getTypeEncoding(ivar), "@\"NSNumber\"")==0) {
                
                maxValue = @([set longLongIntForColumn:[NSString stringWithFormat:@"%s",ivar_getName(ivar)]]);
            }else if (strcmp(ivar_getTypeEncoding(ivar), "@\"NSString\"")==0) {
                
                maxValue = [set stringForColumn:[NSString stringWithFormat:@"%s",ivar_getName(ivar)]];
            }else {
                [NSException raise:@"类里面包含不支持的数据类型" format:@""];
            }
            break;
        }
    }else {
        
        NSLog(@"%@",database.lastErrorMessage);
    }
    
    [database close];
    return maxValue;
}
//获取某一列最大值sql
+ (NSString *)maxSqlWithKey:(NSString *)key {
    
    return [NSString stringWithFormat:@"select MAX(_%@) as _%@ from %@",key,key,self];
}

+ (void)traverseIvarWithExecute:(void(^)(Ivar ivar))block {
    
    unsigned int ivar_count;
    Ivar *ivars = class_copyIvarList(self, &ivar_count);
    for (int i=0; i<ivar_count; i++) {
        Ivar ivar = ivars[i];
        block(ivar);
    }
    free(ivars);
}

+ (void)executeUpdate:(FMDatabase *)database block:(BOOL(^)(void))block {
    
    BOOL open = [database open];
    if (open) {
        
        BOOL success = block();
        
        if (success) {
            
        }else {
            NSLog(@"%@",database.lastErrorMessage);
        }
    }else {
        
        NSLog(@"%@",database.lastErrorMessage);
    }
    
    [database close];
}

#pragma mark --lazyInit--

- (FMDatabase *)database {
    
    FMDatabase *_database = objc_getAssociatedObject(self, keyDatabase);
    if (!_database) {
        self.database = [FMDatabase sharedFMDatabase];
        _database = objc_getAssociatedObject(self, keyDatabase);
    }
    return _database;
}

- (void)setDatabase:(FMDatabase *)database {
    
    objc_setAssociatedObject(self, keyDatabase, database, OBJC_ASSOCIATION_ASSIGN);
}

@end
