//
//  ViewController.m
//  13_ResponsibilityDemo
//
//  Created by Daiyi on 2021/3/2.
//

#import "ViewController.h"
#import "Person.h"
#import "ConcreateHandlerOne.h"
#import "ConcreateHandlerTwo.h"
#import "ConcreateHandlerThree.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 1. 创建
    Handler *handler1 = [[ConcreateHandlerOne alloc] init];
    Handler *handler2 = [[ConcreateHandlerTwo alloc] init];
    Handler *handler3 = [[ConcreateHandlerThree alloc] init];
    // 2. 设置响应器的顺序
    handler1.successor = handler2;
    handler2.successor = handler3;
    // 3. 创建person，吧person进行传递
    Person *person = [[Person alloc] init];
    person.name = @"wangwu";
    [handler1 handlerRequest:person];
//    person.name = @"lisi";
//    [handler1 handlerRequest:person];
}


@end
