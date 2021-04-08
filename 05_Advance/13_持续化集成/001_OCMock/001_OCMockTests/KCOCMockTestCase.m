//
//  KCOCMockTestCase.m
//  001_OCMockTests
//
//  Created by Daiyi on 2021/4/8.
//

#import "KCBaseTestCase.h"
#import "ViewController.h"
#import "Person.h"
#import <OCMock.h>
#import "OCMockViewController.h"

@interface KCOCMockTestCase : KCBaseTestCase

@end

@implementation KCOCMockTestCase

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

- (void)testPerson {
    Person *p = [[Person alloc] init];
    
    Person *mock_p = OCMClassMock([Person class]);
    
//    OCMStub([mock_p getPersonName]).andReturn(@"OCMOCK");
    OCMStub([mock_p getPersonName]).andReturn(@"OCMock");
    
    
    XCTAssertEqual([mock_p getPersonName], [p getPersonName], @"两个相等 ==");
}

- (void)testTableViewDelete {
    ViewController *vc = [[ViewController alloc] init];
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableView *tableView = [[UITableView alloc] init];
    
    // 虚拟的tableView
    id tableView_ocmock = OCMClassMock([UITableView class]);
    [vc tableView:tableView_ocmock commitEditingStyle:(UITableViewCellEditingStyleDelete) forRowAtIndexPath:path];
    [tableView_ocmock deleteRowsAtIndexPaths:@[path] withRowAnimation:(UITableViewRowAnimationFade)];
    
}

- (void)testMockDemo {
    OCMockViewController *vc = [[OCMockViewController alloc] init];
    // manager
    id manager = OCMClassMock([Manager class]);
    // 数据
    Dog *dog1 = [[Dog alloc] init];
    dog1.userName = @"Tom";
    Dog *dog2 = [[Dog alloc] init];
    dog2.userName = @"Json";
    NSArray *array = @[dog1, dog2];
    OCMStub([manager fetchDogs]).andReturn(array);
    // 试图
    id cardView = OCMClassMock([IDCardView class]);
    vc.idCardView = cardView;
    OCMVerify([vc updateIDCardView]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
