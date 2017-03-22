//
//  Student.h
//  LDFramework
//
//  Created by lindechun on 17/2/14.
//  Copyright © 2017年 lindechun. All rights reserved.
//

#import "LDModel.h"

@interface Student : LDModel

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSNumber *ID;

@property (nonatomic, strong) NSNumber *chineseScore;

@end
