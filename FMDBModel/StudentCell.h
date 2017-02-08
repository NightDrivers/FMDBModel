//
//  StudentCell.h
//  FMDBModel
//
//  Created by lindechun on 17/2/8.
//  Copyright © 2017年 lindechun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student.h"

@interface StudentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *idLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *ageLabel;

@property (weak, nonatomic) IBOutlet UILabel *chineseLabel;

@property (weak, nonatomic) IBOutlet UILabel *mathLabel;

@property (weak, nonatomic) IBOutlet UILabel *englishLabel;

@property (nonatomic, strong) Student *student;

@end
