//
//  StudentCell.m
//  FMDBModel
//
//  Created by lindechun on 17/2/8.
//  Copyright © 2017年 lindechun. All rights reserved.
//

#import "StudentCell.h"

@implementation StudentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setStudent:(Student *)student {
    
    _student = student;
    self.idLabel.text      = student.ID.stringValue;
    self.nameLabel.text    = student.name;
    self.ageLabel.text     = student.age.stringValue;
    self.chineseLabel.text = student.chineseScore.stringValue;
    self.mathLabel.text    = student.mathScore.stringValue;
    self.englishLabel.text = student.englishScore.stringValue;
}

@end
