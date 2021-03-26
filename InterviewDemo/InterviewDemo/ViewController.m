//
//  ViewController.m
//  InterviewDemo
//
//  Created by Daiyi on 2021/3/20.
//

#import "ViewController.h"

@interface ViewController () {
    dispatch_semaphore_t _semaphore;
}

@property (nonatomic, assign) NSInteger count;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self test01];
//    [self test02];
    [self test03];
}

- (void)test03 {
    _semaphore = dispatch_semaphore_create(1);
    for (int i = 0; i < 100; i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self asyncTask];
        });
    }
}

- (void)asyncTask {
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    _count ++;
    sleep(1);
    NSLog(@"执行任务: %zd", _count);
    dispatch_semaphore_signal(_semaphore);
}

- (void)test02 {
    dispatch_semaphore_t t = dispatch_semaphore_create(1);
    __block int number = 0;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        number = 100;
        // 信号加1
        dispatch_semaphore_signal(t);
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        number += 100;
        // 信号加1
        dispatch_semaphore_signal(t);
    });
    
    dispatch_semaphore_wait(t, DISPATCH_TIME_FOREVER);
    dispatch_semaphore_wait(t, DISPATCH_TIME_FOREVER);
    NSLog(@"最终结果-- %d", number);
}

- (void)test01 {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("test1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    for (int i = 0; i < 10; i++) {
        dispatch_group_async(group, concurrentQueue, ^{
            sleep(1);
            NSLog(@"=== %d 网络请求", i);
        });
    }
    
    dispatch_group_notify(group, concurrentQueue, ^{
        NSLog(@"刷新UI");
    });
}


@end
