//
//  StudentTableOperateViewController.m
//  FMDBModel
//
//  Created by lindechun on 17/2/8.
//  Copyright © 2017年 lindechun. All rights reserved.
//

#import "StudentTableOperateViewController.h"

@interface StudentTableOperateViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *idTextField;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *ageTextField;

@property (weak, nonatomic) IBOutlet UITextField *chineseTextField;

@property (weak, nonatomic) IBOutlet UITextField *mathTextField;

@property (weak, nonatomic) IBOutlet UITextField *englishTextField;

@end

@implementation StudentTableOperateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (self.type==StudentTableOperateTypeUpdate) {
        self.idTextField.text = self.student.ID.stringValue;
        self.nameTextField.text = self.student.name;
        self.ageTextField.text = self.student.age.stringValue;
        self.chineseTextField.text = self.student.chineseScore.stringValue;
        self.mathTextField.text = self.student.mathScore.stringValue;
        self.englishTextField.text = self.student.englishScore.stringValue;
        //这里将学生的名字作为纪录的唯一标识  不考虑重名
        self.nameTextField.userInteractionEnabled = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButtonAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButtonAction:(id)sender {
    
    if (self.idTextField.text.length==0||self.nameTextField.text.length==0||self.ageTextField.text.length==0||self.chineseTextField.text.length==0||self.mathTextField.text.length==0||self.englishTextField.text.length==0) {
        
        NSLog(@"学生信息不完整");
        return;
    }
    
    Student *student = [[Student alloc] init];
    student.ID = @(self.idTextField.text.integerValue);
    student.name = self.nameTextField.text;
    student.age = @(self.ageTextField.text.intValue);
    student.chineseScore = @(self.chineseTextField.text.intValue);
    student.mathScore = @(self.mathTextField.text.intValue);
    student.englishScore = @(self.englishTextField.text.intValue);
    
    if (self.type==StudentTableOperateTypeCreate) {
        
        [student insertIntoTable];
    }else {
        
        [student updateWherePropertyName:@"name" equal:student.name];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:StudentTableChangeNotification object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.idTextField resignFirstResponder];
    [self.nameTextField resignFirstResponder];
    [self.ageTextField resignFirstResponder];
    [self.chineseTextField resignFirstResponder];
    [self.mathTextField resignFirstResponder];
    [self.englishTextField resignFirstResponder];
}

#pragma mark --UITextFieldDelegate--

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

@end
