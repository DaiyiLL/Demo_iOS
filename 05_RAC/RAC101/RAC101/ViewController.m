//
//  ViewController.m
//  RAC101
//
//  Created by Daiyi on 2021/3/9.
//

#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

#import "Person.h"

#define PI 10

@interface ViewController ()

@property (nonatomic, strong) Person *person;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.person = [[Person alloc] init];
//    NSLog(@"%@", self.person.name);
    
//    [self demo03];
    
    @weakify(self);
    
    int * a = PI;
}

- (void)demo04 {
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
            NSLog(@"%@", x);
    }];
}

- (void)demo03 {
//    __weak typedef(self) weakSelf = self;
    @weakify(self)
    [_textField.rac_textSignal subscribeNext:^(NSString * _Nullable text) {
        NSLog(@"%@", text);
        @strongify(self)
        // 不希望内部的block不消失，如果希望消失就不用管理
        self.textField.text = @"Hello";
    }];
    
    [[_btn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)demo02 {
    // 创建信号
    [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 发送信号
        [subscriber sendNext:@"This is RAC"];
        return nil;
    }] subscribeNext:^(id  _Nullable x) {
        // 订阅信号
        // x 信号的内容
        NSLog(@"%@", x);
    }];
}

- (void)demo01 {
    // 创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 发送信号
        [subscriber sendNext:@"This is RAC"];
        return nil;
    }];
    // 订阅信号
    [signal subscribeNext:^(id  _Nullable x) {
        // x 信号的内容
        NSLog(@"%@", x);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.person.name = [NSString stringWithFormat:@"Daishuyi %05d", arc4random_uniform(10000)];
    NSLog(@"%@", self.person.name);
    
    self.textField.text = @"1234";
}


@end
