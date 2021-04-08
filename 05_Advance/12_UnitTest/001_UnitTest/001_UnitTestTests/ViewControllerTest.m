//
//  ViewControllerTest.m
//  001_UnitTestTests
//
//  Created by Daiyi on 2021/4/7.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface ViewControllerTest : XCTestCase

@property (nonatomic, strong) ViewController *vc;

@end

@implementation ViewControllerTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.vc = [ViewController new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.vc = nil;
    ///  dealloc等等
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testGetPlus {
    // 三步骤
    // give:
    int a = 10;
    int b = 20;
    // when
    int c = [self.vc getPlus:a num2:b];
    // then
    XCTAssertEqual(c, 30, @"测试不通过");
    
    
}

// 性能测试  ---》 方法  ---》 耗时
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        [self.vc openCamera];
        [self.vc openCamera];
    }];
}

- (void)testPerformanceExample00 {
    [self measureMetrics:@[XCTPerformanceMetric_WallClockTime] automaticallyStartMeasuring:NO forBlock:^{
        [self.vc openCamera];
        
        [self startMeasuring];
        [self.vc openCamera];
        [self stopMeasuring];
    }];
}

- (void)testAsy {
    NSLog(@"开始测试异步");
    // given
    // 时间
    XCTestExpectation *exc = [self expectationWithDescription:@"这是我的期望"];
    
    // when
    [self.vc loadData:^(id data) {
         // 夹 逻辑
        XCTAssertNotNil(data, @"返回空了");
        
        [exc fulfill];
    }];
    // then
    [self waitForExpectationsWithTimeout:3 handler:^(NSError * _Nullable error) {
        NSLog(@"已经超时了");
    }];
}



@end
