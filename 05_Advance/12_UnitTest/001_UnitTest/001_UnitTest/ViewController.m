//
//  ViewController.m
//  001_UnitTest
//
//  Created by Daiyi on 2021/4/7.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"哈哈一下");
}

- (int)getPlus:(int)num1 num2:(int)num2 {
    return num1 + num2 + 10;
}

- (void)loadData:(void (^)(id))dataBlock {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:2];
        NSString *dataStr = @"meilo30";
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"刷新UI");
            dataBlock(dataStr);
        });
    });
}

- (void)openCamera {
    for (int i = 0; i < 1000; i++) {
        NSLog(@"性能测试");
    }
}


@end
