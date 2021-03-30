//
//  TestViewController.m
//  01_KVO
//
//  Created by Daiyi on 2021/3/29.
//

#import "TestViewController.h"
#import "DYPerson.h"
#import <objc/runtime.h>
#import "NSObject+KVO.h"

@interface TestViewController ()

@property (nonatomic, strong) DYPerson *person;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    _person = [DYPerson new];
    
    [_person dy_addObserver:self forKeyPath:@"name" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@", change);
    NSLog(@"context = %s", context);
}



- (void)dealloc {
    NSLog(@"dealloc normally");
//    [_person dy_removeObserver:self forKeyPath:@"name"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 手动通知
//    _person.steps ++;
//    [_person setSteps:10];
    
    _person.name = @"Tom";
    
}




@end
