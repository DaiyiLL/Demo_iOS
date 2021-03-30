//
//  ViewController.m
//  03_KVCDict
//
//  Created by Daiyi on 2021/3/28.
//

#import "ViewController.h"
#import "DYPerson.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self arrayKVCTest];
    
//    [self containerTest];
    
//    [self containerArrayTest];
    
//    [self containerNestingTest];
    
    [self demo01];
}

- (void)demo01 {
    DYPerson *p = [DYPerson new];
    p.count = 5;
    
    NSLog(@"books = %@", [p valueForKey:@"books"]);
    
    p.penArr = [NSMutableArray arrayWithObjects:@"pen0", @"pen1", @"pen2", @"pen3", nil];
    NSSet *set = [p valueForKey:@"pens"];
    NSLog(@"pens = %@", set);
    
    NSEnumerator *enumerator = [set objectEnumerator];
}

/// 聚合操作符 (@avg, @count, @max, @min, @sum)
- (void)containerTest {
    
    NSMutableArray *students = [NSMutableArray array];
    for (int i = 0; i < 6; i ++) {
        NSDictionary *dict = @{
            @"name": @"Tom",
            @"age": @(18 + i),
            @"nick": @"Cat",
            @"height": @(1.65 + 0.02*arc4random_uniform(6)),
            @"dd": @"hello"
        };
        
        DYPerson *student = [[DYPerson alloc] init];
        [student setValuesForKeysWithDictionary:dict];
        [students addObject:student];
    }
    NSLog(@"%@", [students valueForKey:@"height"]);
    // 平均升高
    float avg = [[students valueForKeyPath:@"@avg.height"] floatValue];
    NSLog(@"avg = %f", avg);
    // 最大
    float max = [[students valueForKeyPath:@"@max.height"] floatValue];
    NSLog(@"max = %f", max);
}

/// 数组操作符 @distinctUnionOfObjects @unionOfObjects
- (void)containerArrayTest {
    NSMutableArray *students = [NSMutableArray array];
    for (int i = 0; i < 6; i ++) {
        NSDictionary *dict = @{
            @"name": @"Tom",
            @"age": @(18 + i),
            @"nick": @"Cat",
            @"height": @(1.65 + 0.02*arc4random_uniform(6)),
            @"dd": @"hello"
        };
        
        DYPerson *student = [[DYPerson alloc] init];
        [student setValuesForKeysWithDictionary:dict];
        [students addObject:student];
    }
    NSLog(@"%@", [students valueForKey:@"height"]);
    
    NSArray *arr = [students valueForKeyPath:@"@distinctUnionOfObjects.height"];
    NSLog(@"%@", arr);
    
    
    NSArray *arr1 = [students valueForKeyPath:@"@unionOfObjects.height"];
    NSLog(@"%@", arr1);
}

/// 嵌套集合(array&Set)操作符 @distinctUnionOfArrays @unionOfArrays, @distinctUnionOfSets
- (void)containerNestingTest {
    NSMutableArray *students = [NSMutableArray array];
    for (int i = 0; i < 6; i ++) {
        NSDictionary *dict = @{
            @"name": @"Tom",
            @"age": @(18 + i),
            @"nick": @"Cat",
            @"height": @(1.65 + 0.02*arc4random_uniform(6)),
            @"dd": @"hello"
        };
        
        DYPerson *student = [[DYPerson alloc] init];
        [student setValuesForKeysWithDictionary:dict];
        [students addObject:student];
    }
    
    NSMutableArray *students1 = [NSMutableArray array];
    for (int i = 0; i < 6; i ++) {
        NSDictionary *dict = @{
            @"name": @"Tom",
            @"age": @(18 + i),
            @"nick": @"Cat",
            @"height": @(1.65 + 0.02*arc4random_uniform(6)),
            @"dd": @"hello"
        };
        
        DYPerson *student = [[DYPerson alloc] init];
        [student setValuesForKeysWithDictionary:dict];
        [students1 addObject:student];
    }
    
    // 嵌套数组
    NSArray *nestArr = @[students, students1];
    
    NSArray *arr = [nestArr valueForKeyPath:@"@distinctUnionOfArrays.height"];
    NSLog(@"%@", arr);
    
    
    NSArray *arr1 = [nestArr valueForKeyPath:@"@unionOfArrays.height"];
    NSLog(@"%@", arr1);
    
}


// KVC 消息传递
- (void) arrayKVCTest {
    NSArray *arr = @[@"Monday", @"Tuesday", @"wendesday"];
    NSArray *lengthArr = [arr valueForKey:@"length"];
    NSLog(@"%@", lengthArr);
    
    NSArray *lowercaseArr = [arr valueForKey:@"lowercaseString"];
    NSLog(@"%@", lowercaseArr);
}


- (void)demo00 {
    DYPerson *p = [DYPerson new];
    
    NSDictionary *dict = @{
        @"name": @"Tom",
        @"age": @28,
        @"nick": @"Cat",
        @"height": @180,
        @"dd": @"hello"
    };
    [p setValuesForKeysWithDictionary:dict];
    NSLog(@"%@ -- %ld -- %@ -- %f", p.name, p.age, p.nick, p.height);
    
    NSArray *keys = @[@"name", @"age"];
    NSDictionary *dict1 = [p dictionaryWithValuesForKeys:keys];
    NSLog(@"%@", dict1);
}

@end
