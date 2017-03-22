//
//  LDModelTest.m
//  LDFramework
//
//  Created by lindechun on 17/2/14.
//  Copyright © 2017年 lindechun. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Student.h"

@interface LDModelTest : XCTestCase

@property (nonatomic, strong) NSDictionary *dic;

@end

@implementation LDModelTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.dic = @{@"name":@"lindechun",@"id":@1,@"chinesescore":@30};
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitWithDictionary {
    
    Student *student = [[Student alloc] initPropertyWithDictionary:self.dic];
    XCTAssertTrue([student.name isEqualToString:@"lindechun"],@"name should equal");
    XCTAssertTrue([student.ID isEqualToNumber:@1],@"id should equal");
    XCTAssertTrue([student.chineseScore isEqualToNumber:@30],@"chineseScore should equal");
//    XCTAssertEqual(student.mathScore, @60,@"mathScore should equal");
//    XCTAssertEqual(student.englishScore, @90,@"englishScore should equal");
}

- (void)testGetDictionary {
    
    Student *student = [[Student alloc] init];
    student.name = @"lindechun";
    student.ID = @1;
    student.chineseScore = @30;
    NSDictionary *dic = [student getDic];
    XCTAssertTrue([dic[@"name"] isEqualToString:@"lindechun"],@"");
    XCTAssertTrue([dic[@"ID"] isEqualToNumber:@1],@"");
    XCTAssertTrue([dic[@"chineseScore"] isEqualToNumber:@30],@"");
    XCTAssertEqual(dic.count, self.dic.count,@"the count should equal");
}

- (void)testClearAllProperty {
    
    Student *student = [[Student alloc] init];
    student.name = @"lindechun";
    student.ID = @1;
    student.chineseScore = @30;
    [student clearAllProperty];
    XCTAssertNil(student.name,@"");
    XCTAssertNil(student.ID,@"");
    XCTAssertNil(student.chineseScore,@"");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
