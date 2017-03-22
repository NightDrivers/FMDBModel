//
//  Student.h
//  FMDBModel
//
//  Created by lindechun on 17/2/7.
//  Copyright © 2017年 lindechun. All rights reserved.
//

#import "LDModel.h"
#import "LDModel+FMDB.h"

@interface Student : LDModel

@property (nonatomic, strong) NSNumber *ID;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSNumber *age;

@property (nonatomic, strong) NSNumber *chineseScore;

@property (nonatomic, strong) NSNumber *mathScore;

@property (nonatomic, strong) NSNumber *englishScore;

@end
