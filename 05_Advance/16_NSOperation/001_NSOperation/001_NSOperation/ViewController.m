//
//  ViewController.m
//  001_NSOperation
//
//  Created by Daiyi on 2021/4/20.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.queue = [[NSOperationQueue alloc] init];
    
//    [self demo01];
//    [self demo02];
    [self demo03];
}

- (void)demo03 {
    self.queue.name = @"com.dy.cn";
    NSBlockOperation *bo1 = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:0.5];
        NSLog(@"请求token");
    }];
    NSBlockOperation *bo2 = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"使用token，请求数据1");
    }];
    
    NSBlockOperation *bo3 = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"使用数据1，请求数据2");
    }];
    // 依赖
    [bo2 addDependency:bo1];
    [bo3 addDependency:bo2];
    
//    [self.queue addOperation:bo1];
//    [self.queue addOperation:bo2];
//    [self.queue addOperation:bo3];
    
    [self.queue addOperations:@[bo1, bo2, bo3] waitUntilFinished:NO];
    
    NSLog(@"执行完了，我要干其他事情");
}

- (void)demo02 {
    // GCD ---> 信号量: 对于线程来说NSOperation操作自如 --- suspernd cancel finish
    
    self.queue.name = @"com.dy.cn";
    self.queue.maxConcurrentOperationCount = 1;
    
    for (int i = 0; i < 100; i++) {
        [self.queue addOperationWithBlock:^{
            [NSThread sleepForTimeInterval:1];
            NSLog(@"%@ --- %d", [NSThread currentThread], i);
        }];
    }
//    [self.queue addOperationWithBlock:^{
//        for (int i = 0; i < 100; i++) {
//            [NSThread sleepForTimeInterval:1];
//            NSLog(@"%@ --- %d", [NSThread currentThread], i);
//        }
//    }];
//    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
//        for (int i = 0; i < 100; i++) {
//            [NSThread sleepForTimeInterval:2];
//            NSLog(@"%@ --- %d", [NSThread currentThread], i);
//        }
//    }];

//    [self.queue addOperation:op];
    
}
- (IBAction)pauseOrContinue:(id)sender {
    if (self.queue.operationCount == 0) {
        NSLog(@"没有执行操作了");
        return;
    }
    if (self.queue.suspended) {
        NSLog(@"当前挂起来了");
    } else {
        NSLog(@"执行...");
    }
//    self.queue.suspended = !self.queue.isSuspended;
    
    [self.queue setSuspended:!self.queue.isSuspended];
}

- (IBAction)cancel:(id)sender {
    [self.queue cancelAllOperations];
}


- (void)demo01 {
    // 操作优先级
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:1];
        NSLog(@"123");
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSLog(@"更新UI");
        }];
    }];
    [op addExecutionBlock:^{
        NSLog(@"456");
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    op.completionBlock = ^{
        NSLog(@"完成了");
    };
    
    // 由系统调用
    [queue addOperation:op];
}

- (void)demo00 {
    // 不能直接使用 事务+queue = 把事务添加到队列中
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(demo) object:nil];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    // 由系统调用
    [queue addOperation:op];
    // 手动调用
    [op start];
}

- (void)demo {
    NSLog(@"123");
}


@end
