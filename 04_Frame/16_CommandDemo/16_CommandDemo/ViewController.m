//
//  ViewController.m
//  16_CommandDemo
//
//  Created by Daiyi on 2021/3/7.
//

#import "ViewController.h"
#import "Receiver.h"

#import "Invoker.h"
#import "DarkerCommand.h"
#import "LinghterCommand.h"

typedef enum : NSUInteger {
    BtnTagTypeMinus = 50, // 降低亮度
    BtnTagTypeAdd = 51,   // 增加亮度
    BtnTagTypeBack = 52,  // 回退亮度
} BtnTagType;

@interface ViewController ()

@property (nonatomic, strong) Receiver *receiver;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 接收器
    self.receiver = [[Receiver alloc] init];
    self.receiver.receiverView = self.view;
    
}

- (IBAction)btnClicked:(UIButton *)button {
    if (button.tag == BtnTagTypeMinus) {
//        NSLog(@"打印的是 %ld", BtnTagTypeMinus);
//        [self.receiver makeDart:0.1];
        DarkerCommand *command = [[DarkerCommand alloc] initWithReceiver:_receiver param:0.1];
        [[Invoker shared] addAndExcute:command];

    } else if (button.tag == BtnTagTypeAdd) {
//        NSLog(@"打印的是 %ld", BtnTagTypeAdd);
//        [self.receiver makeLighter:0.1];
        LinghterCommand *command = [[LinghterCommand alloc] initWithReceiver:_receiver param:0.1];
        [[Invoker shared] addAndExcute:command];
        
    } else if (button.tag == BtnTagTypeBack) {
//        NSLog(@"打印的是 %ld", BtnTagTypeBack);
        [[Invoker shared] goBack];
    }
}



@end
