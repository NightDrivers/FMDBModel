//
//  HomeViewController.m
//  FMDBModel
//
//  Created by lindechun on 17/2/7.
//  Copyright © 2017年 lindechun. All rights reserved.
//

#import "HomeViewController.h"
#import "StudentTableOperateViewController.h"
#import "StudentCell.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<Student *> *students;

@end

static NSString *studentCellIden = @"student.cell.iden";

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configureTableView];
    [Student createTableIfNotExist];
    [self synchronizeDatabaseAndUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(synchronizeDatabaseAndUI) name:StudentTableChangeNotification object:nil];
}

- (void)configureTableView {
    
    [self.tableView registerNib:[UINib nibWithNibName:@"StudentCell" bundle:nil] forCellReuseIdentifier:studentCellIden];
}

- (void)synchronizeDatabaseAndUI {
    
    self.students = nil;
    
    for (Student *student in [Student allInstances]) {
        [self.students addObject:student];
    }
    
    [self.tableView reloadData];
}

#pragma mark --数据库操作--
- (IBAction)insertButtonAction:(id)sender {
    
    StudentTableOperateViewController *operate = [[StudentTableOperateViewController alloc] init];
    operate.type = StudentTableOperateTypeCreate;
    [self presentViewController:operate animated:YES completion:nil];
}

- (IBAction)updateButtonAction:(id)sender {
    
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    if (!indexPath||indexPath.row==0) {
        NSLog(@"请选中一个学生");
        return;
    }
    
    StudentTableOperateViewController *operate = [[StudentTableOperateViewController alloc] init];
    operate.type = StudentTableOperateTypeUpdate;
    operate.student = self.students[indexPath.row - 1];
    [self presentViewController:operate animated:YES completion:nil];
}

- (IBAction)deleteButtonAction:(id)sender {
    
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    if (!indexPath||indexPath.row==0) {
        NSLog(@"请选中一个学生");
        return;
    }
    
    [Student deleteInstanceWithPropertyName:@"name" value:self.students[indexPath.row - 1].name];
    [self synchronizeDatabaseAndUI];
}

#pragma mark --UITableviewDelegate--

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.students.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0) {
        StudentCell *cell = [tableView dequeueReusableCellWithIdentifier:studentCellIden];
        cell.idLabel.text      = @"ID";
        cell.nameLabel.text    = @"姓名";
        cell.ageLabel.text     = @"年龄";
        cell.chineseLabel.text = @"语文";
        cell.mathLabel.text    = @"数学";
        cell.englishLabel.text = @"英语";
        return cell;
    }else {
        StudentCell *cell = [tableView dequeueReusableCellWithIdentifier:studentCellIden];
        cell.student = self.students[indexPath.row - 1];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark --lazyInit--

- (NSMutableArray<Student *> *)students {
    
    if (!_students) {
        _students = [[NSMutableArray alloc] init];
    }
    return _students;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:StudentTableChangeNotification object:nil];
}

@end
