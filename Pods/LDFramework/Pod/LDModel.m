//
//  LDModel.m
//  LDFramework
//
//  Created by lindechun on 17/1/16.
//  Copyright © 2017年 lindechun. All rights reserved.
//

#import "LDModel.h"
#import <objc/runtime.h>

@implementation LDModel

- (instancetype)initPropertyWithDictionary:(NSDictionary *)dic {
    
    self = [super init];
    if (self) {
        [self setPropertyWithDictionary:dic];
    }
    return self;
}

- (void)setPropertyWithDictionary:(NSDictionary *)dic {
    
    unsigned int num;
    Ivar *ivar = class_copyIvarList([self class], &num);
    for (int i=0; i<num; i++) {
        Ivar temp = ivar[i];
        const char *ivar_name = ivar_getName(temp);
        ivar_name++;
        NSString *ivar_name_oc = [NSString stringWithCString:ivar_name encoding:NSUTF8StringEncoding];
        id value = dic[ivar_name_oc];
        
        if (value&&![value isKindOfClass:[NSDictionary class]]&&![value isKindOfClass:[NSArray class]]) {
            object_setIvar(self, temp, value);
        }else if (!value) {
            
            for (NSString *key in dic) {
                //查找字典中是否有忽略大小写对应的字典key，有的话，把值赋给对应的属性
                if ([key compare:ivar_name_oc options:NSCaseInsensitiveSearch]==NSOrderedSame) {
                    object_setIvar(self, temp, dic[key]);
                    break;
                }
            }
        }else {
            
        }
    }
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    if (self) {
        unsigned int num;
        Ivar *ivar = class_copyIvarList([self class], &num);
        for (int i=0; i<num; i++) {
            Ivar temp = ivar[i];
            const char *ivar_cstring_name = ivar_getName(temp);
            NSString *ivar_string_name = [NSString stringWithCString:ivar_cstring_name encoding:NSUTF8StringEncoding];
            id value = [aDecoder decodeObjectForKey:ivar_string_name];
            object_setIvar(self, temp, value);
        }
    }
    return self;
}

- (void)setupSelf:(LDModel *)model {
    
    unsigned int num;
    Ivar *ivar = class_copyIvarList([self class], &num);
    for (int i=0; i<num; i++) {
        Ivar temp = ivar[i];
        id modelValue = object_getIvar(model, temp);
        object_setIvar(self, temp, modelValue);
    }
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    unsigned int num;
    Ivar *ivar = class_copyIvarList([self class], &num);
    for (int i=0; i<num; i++) {
        Ivar temp = ivar[i];
        const char *ivar_cstring_name = ivar_getName(temp);
        NSString *ivar_string_name = [NSString stringWithCString:ivar_cstring_name encoding:NSUTF8StringEncoding];
        id value = object_getIvar(self, temp);
        [aCoder encodeObject:value forKey:ivar_string_name];
    }
}

- (NSString *)description {
    
    NSMutableString * mstr = [[NSMutableString alloc] init];
    unsigned int num;
    Ivar *ivar = class_copyIvarList([self class], &num);
    for (int i=0; i<num; i++) {
        Ivar temp = ivar[i];
        NSString *tempString = [[NSString alloc] initWithCString:ivar_getName(temp) encoding:NSUTF8StringEncoding];
        id value = object_getIvar(self, temp);
        NSString *str = [NSString stringWithFormat:@"-[%@]-[%@]-\n",tempString,value];
        [mstr appendString:str];
    }
    return mstr;
}

-(NSDictionary *)getDic {
    
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
    Ivar *ivar;
    unsigned int num;
    ivar = class_copyIvarList([self class], &num);
    for (int i=0; i<num; i++) {
        Ivar temp = ivar[i];
        NSString *tempString = [[NSString alloc] initWithCString:ivar_getName(temp) encoding:NSUTF8StringEncoding];
        id value = object_getIvar(self, temp);
        if (!value) {
            continue;
        }
        [mDic setValue:value forKey:[tempString substringFromIndex:1]];
    }
    return mDic;
}

- (void)clearAllProperty {
    
    unsigned int num;
    Ivar *ivar = class_copyIvarList([self class], &num);
    for (int i=0; i<num; i++) {
        Ivar temp = ivar[i];
        object_setIvar(self, temp, nil);
    }
}


@end
