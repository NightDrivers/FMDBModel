//
//  Dog.h
//  FMDBModel
//
//  Created by lindechun on 17/2/15.
//  Copyright © 2017年 lindechun. All rights reserved.
//

#import <LDFramework/LDFramework.h>
#import "LDModel+FMDB.h"

@interface Dog : LDModel

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSNumber *age;

@end
