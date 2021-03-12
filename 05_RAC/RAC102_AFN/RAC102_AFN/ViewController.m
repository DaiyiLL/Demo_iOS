//
//  ViewController.m
//  RAC102_AFN
//
//  Created by Daiyi on 2021/3/10.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "Person.h"

#import "NetworkTools.h"

#define NUMBER 10
#define ADD(a,b) (a + b)

#define STRINGIFY(S) #S


#define CALCILATE(A,B) _CALCILATE(A,B) //轉換宏
#define _CALCILATE(A,B) (A##10##B)

@interface ViewController ()

@property (nonatomic, strong) Person *person;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UITextField *textField;


@end

@implementation ViewController

- (void)dealloc
{
    NSLog(@"dealloc normal");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITextField *nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, 300, 40)];
    nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:nameTextField];
    
    UITextField *pwdTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(20, 150, 300, 40)];
    pwdTextFiled.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:pwdTextFiled];
    
//    [[nameTextField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"%@", x);
//    }];
    
    
//    [[RACSignal combineLatest:@[nameTextField.rac_textSignal, pwdTextFiled.rac_textSignal]] subscribeNext:^(RACTuple * _Nullable x) {
////        NSLog(@"%@", x);
//        NSString *name = x.first;
//        NSString *pwd = x.second;
//
//        NSLog(@"%@ --- %@", name, pwd);
//    }];
    
//    [[RACSignal combineLatest:@[nameTextField.rac_textSignal, pwdTextFiled.rac_textSignal] reduce:^id _Nonnull (NSString *name, NSString *pwd){
//        NSLog(@"%@ --- %@", name, pwd);
//        return nil;
//    }] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@", x);
//    }];
    
    [[RACSignal combineLatest:@[nameTextField.rac_textSignal, pwdTextFiled.rac_textSignal] reduce:^id _Nonnull (NSString *name, NSString *pwd){
//        NSLog(@"%@ --- %@", name, pwd);
        return @(name.length > 0 && pwd.length > 0);
//        return nil;
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
        self.button.enabled = [x boolValue];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    self.person.name = [NSString stringWithFormat:@"daishuyi %05d", arc4random_uniform(10000)];
}

- (void)demo03 {
//    [[NetworkTools shareTools] request:@"http://www.weather.com.cn/data/sk/101010100.html" parameters:nil];
    
//    [[[NetworkTools shareTools] racRequest:@"http://www.weather.com.cn/data/sk/101010100.html" parameters:nil] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@", x);
//    } error:^(NSError * _Nullable error) {
//        NSLog(@"错误%@", error);
//    } completed:^{
//        NSLog(@"完成");
//    }];
        
    [[[NetworkTools shareTools] racRequest:@"http://www.weather.com.cn/data/sk/101010100.html" parameters:nil] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    } error:^(NSError * _Nullable error) {
        NSLog(@"错误%@", error);
    }];
}

- (void)demo02 {
    @weakify(self);
    [[self.textField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@", x);
        @strongify(self);
        self.nameLabel.text = x;
    }];
}

- (void)demo01 {
    [[self.button rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)demo00 {
    // KVO
    self.person = [Person new];
    // 监听name变化
    @weakify(self);
    [RACObserve(self.person, name) subscribeNext:^(id  _Nullable x) {
        NSLog(@"name = %@", x);
        @strongify(self);
        self.nameLabel.text = x;
    }];
}

@end
