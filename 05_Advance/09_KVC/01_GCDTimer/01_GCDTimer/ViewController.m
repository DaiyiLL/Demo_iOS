//
//  ViewController.m
//  01_GCDTimer
//
//  Created by Daiyi on 2021/3/28.
//

#import "ViewController.h"

@interface ViewController () {
    dispatch_source_t _timer;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // NSTimer不准时的原因，主要有两个
    // 1. RunLoop循环处理这个时间
    // 2. 受到RunLoop模式的影响
    
//    [self gcdTimerTest];
}

- (void)gcdTimerTest {
//    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_queue_t queue = dispatch_queue_create("", DISPATCH_QUEUE_SERIAL);
    // 创建定时器
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    // 设定定时的开始时间，间隔时间
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    // 设定定时器回调
    dispatch_source_set_event_handler(_timer, ^{
        NSLog(@"你好");
    });
    // 启动定时器，默认是关闭的
    dispatch_resume(_timer);
}


@end
