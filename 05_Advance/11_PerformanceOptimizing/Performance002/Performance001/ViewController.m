//
//  ViewController.m
//  Performance001
//
//  Created by Daiyi on 2021/3/30.
//

#import "ViewController.h"
#import "DYPerson.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DYPerson *person = [DYPerson new];
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    for (int i = 0; i < 1000; i++) {
        dispatch_async(queue, ^{
//            person.name = [NSString stringWithFormat:@"%@", @"123456789"];
            // 字符串是常量，所以没有效果
//            person.name = @"1234567890jldsjfdsfds";
        });
    }
    
}


@end
