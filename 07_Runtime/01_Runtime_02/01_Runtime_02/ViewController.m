//
//  ViewController.m
//  01_Runtime_02
//
//  Created by Daiyi on 2021/3/25.
//

#import "ViewController.h"
#import "DYPerson.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    DYPerson *p = [[DYPerson alloc] init];
    p.name = @"Cat";
    p.age = 18;
    p.address = @"重庆市";
    NSString *path = [NSString stringWithFormat:@"%@/archiver.plist", NSHomeDirectory()];
    // 归档
    [NSKeyedArchiver archiveRootObject:p toFile:path];
    // 解档
    DYPerson *p2 = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"name = %@, age = %ld", p2.name, p2.age);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%s", __func__);
}

@end
