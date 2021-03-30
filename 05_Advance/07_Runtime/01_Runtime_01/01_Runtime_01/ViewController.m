//
//  ViewController.m
//  01_Runtime_01
//
//  Created by Daiyi on 2021/3/25.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self classTest];
}

void hunting(id self, SEL _cmd) {
    NSLog(@"%s", __func__);
}

- (void)classTest {
    // 创建一类对
    Class TZCat = objc_allocateClassPair([NSObject class], "TZCat", 0);
    // 添加实例变量
    // const char* types = "v@:"
    NSString *name = @"name";
    class_addIvar(TZCat, name.UTF8String, sizeof(id), log2(sizeof(id)), @encode(id));
    // 添加方法
    class_addMethod(TZCat, @selector(hunting), (IMP)hunting, "v@:");
    
    // 注册
    objc_registerClassPair(TZCat);
    
    // 创建实例对象
    id cat = [[TZCat alloc] init];
    [cat setValue:@"Tom" forKey:name];
    NSLog(@"name = %@", [cat valueForKey:name]);
    
    // 方法调用
    [cat performSelector:@selector(hunting)];
}



@end
