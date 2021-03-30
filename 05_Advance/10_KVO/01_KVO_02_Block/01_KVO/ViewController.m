//
//  ViewController.m
//  01_KVO
//
//  Created by Daiyi on 2021/3/29.
//

#import "ViewController.h"
#import "DYPerson.h"
#import "TestViewController.h"
#import "NSObject+PrintMethod.h"
#import "NSObject+KVO.h"

@interface ViewController ()

@property (nonatomic, strong) DYPerson *person;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    _person = [DYPerson new];
//    // 添加观察者
//    [_person addObserver:self forKeyPath:@"steps" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionPrior) context:"hello"];
    
    
    [_person dy_addObserver:self forKeyPath:@"name" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionPrior) context:"hello"];
    
    [DYPerson printClasses:[DYPerson class]];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@", change);
    NSLog(@"context = %s", context);
}

- (IBAction)pushClicked:(id)sender {
    TestViewController *vc = [TestViewController new];
    [self.navigationController pushViewController:vc animated:true];
}



- (void)dealloc {
    NSLog(@"dealloc normally");
//    [_person removeObserver:self forKeyPath:@"steps"];
    [_person dy_removeObserver:self forKeyPath:@"name"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [DYPerson printClasses:[DYPerson class]];
    _person.name = @"daishuyi";
}

@end
