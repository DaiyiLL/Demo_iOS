//
//  _01_UnitTestTests.m
//  001_UnitTestTests
//
//  Created by Daiyi on 2021/4/7.
//

#import <XCTest/XCTest.h>

@interface _01_UnitTestTests : XCTestCase

@end

// 中间砍（自己的服务器） --- 假数据 --- 订单 --->
// 因子 ---》 测试 ----》 单一变量原则
@implementation _01_UnitTestTests

// 执行顺序
- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
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
