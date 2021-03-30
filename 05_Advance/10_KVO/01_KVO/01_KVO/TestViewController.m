//
//  TestViewController.m
//  01_KVO
//
//  Created by Daiyi on 2021/3/29.
//

#import "TestViewController.h"
#import "DYPerson.h"

@interface TestViewController ()

@property (nonatomic, strong) DYPerson *person;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    _person = [DYPerson new];
    // 添加观察者
    [_person addObserver:self forKeyPath:@"fullName" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionPrior) context:"hello"];
    [_person addObserver:self forKeyPath:@"steps" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionPrior) context:"hello"];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@", change);
    NSLog(@"context = %s", context);
}


- (void)dealloc {
    NSLog(@"dealloc normally");
    [_person removeObserver:self forKeyPath:@"fullName"];
    [_person removeObserver:self forKeyPath:@"steps"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 手动通知
    [_person willChangeValueForKey:@"steps"];
    _person.steps ++;
    [_person didChangeValueForKey:@"steps"];
    
//    _person.firstName = @"三";
}

@end
