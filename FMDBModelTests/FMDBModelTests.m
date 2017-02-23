//
//  FMDBModelTests.m
//  FMDBModelTests
//
//  Created by lindechun on 17/2/15.
//  Copyright © 2017年 lindechun. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Dog.h"

@interface FMDBModelTests : XCTestCase

@property (nonatomic, strong) Dog *dog;

@end

@implementation FMDBModelTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [Dog createTableIfNotExist];
    self.dog = [[Dog alloc] init];
    self.dog.name = @"Tom";
    self.dog.age  = @3;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [Dog deleteTableIfExists];
    [super tearDown];
}

- (void)testFMDBModelMethod {
    
    [self.dog insertIntoTable];
    NSMutableArray *dogs = [Dog allInstances];
    Dog *dog = dogs[0];
    XCTAssertNotNil(dog,@"insert a dog instance,dog should not be nil");
    XCTAssertTrue([dog.name isEqualToString:self.dog.name],@"");
    XCTAssertTrue([dog.age isEqualToNumber:self.dog.age],@"");
    
    self.dog.age = @4;
    [self.dog updateWherePropertyName:@"name" equal:@"Tom"];
    dogs = [Dog allInstances];
    dog = dogs[0];
    XCTAssertNotNil(dog,@"update a dog instance,dog should not be nil");
    XCTAssertTrue([dog.name isEqualToString:@"Tom"],@"");
    XCTAssertTrue([dog.age isEqualToNumber:@4],@"");
    
    [Dog deleteInstanceWithPropertyName:@"name" value:@"Tom"];
    dogs = [Dog allInstances];
    XCTAssertTrue(dogs.count==0,@"delete instance that name is equal to Tom,no object in dogs ");
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
