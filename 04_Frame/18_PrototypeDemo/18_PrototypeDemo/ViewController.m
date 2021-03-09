//
//  ViewController.m
//  18_PrototypeDemo
//
//  Created by Daiyi on 2021/3/8.
//

#import "ViewController.h"
#import "StudentModel.h"
#import "ClassModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    StudentModel *stu1 = [[StudentModel alloc] init];
    stu1.name = @"张三";
    stu1.age = @(18);
    stu1.address = @"帝都";
    stu1.totalScore = @(700);
    StudentModel *stu2 = [stu1 clone];
    StudentModel *stu3 = [stu1 clone];
    
    stu3.name = @"王五";
    
    StudentModel *stu4 = [stu1 copy];
    NSLog(@"%@ -- %@ : %@  -- %@", stu1, stu4, stu4.name, stu4.address);
    
    ClassModel *cls1 = [ClassModel new];
    cls1.className = NSStringFromClass(StudentModel.class);
    cls1.students = @[stu1, stu2, stu3];
    
    NSLog(@" ===  %@", cls1.students);
    ClassModel *cls2 = cls1.copy;
    NSLog(@" ===  %@", cls2.students);
}


@end
