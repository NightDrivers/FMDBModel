//
//  StudentTableOperateViewController.h
//  FMDBModel
//
//  Created by lindechun on 17/2/8.
//  Copyright © 2017年 lindechun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student.h"

typedef NS_ENUM(NSInteger, StudentTableOperateType) {
    //新增
    StudentTableOperateTypeCreate = 1001,
    //更新
    StudentTableOperateTypeUpdate = 1002
};

static NSString *StudentTableChangeNotification = @"student.table.chenge.notification";

@interface StudentTableOperateViewController : UIViewController

@property (nonatomic, strong) Student *student;

@property (nonatomic, assign) StudentTableOperateType type;

@end
