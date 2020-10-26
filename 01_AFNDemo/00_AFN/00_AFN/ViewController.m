//
//  ViewController.m
//  00_AFN
//
//  Created by yidai on 2020/9/17.
//  Copyright © 2020 yidai. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>


@interface ViewController ()

@property (strong, atomic) NSString *target;
@property (assign, atomic) NSInteger number;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self get];
//    [self test00];
//    [self test01];
//    [self test02];
//    [self test03];
//    [self test04];
//    [self test05];
//    [self test06];
//    [self test07];
//    [self test08];
//    [self test09];
    [self test10];
}

- (void)test10 {
    NSLock *lock = [[NSLock alloc] init];
    dispatch_apply(10000, dispatch_get_global_queue(0, 0), ^(size_t index) {
        [lock lock];
        self.number++;
        [lock unlock];
    });
    NSLog(@"total = %ld", self.number);
}

- (void)test09 {
    dispatch_queue_t queue = dispatch_queue_create(NULL, DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 10000; i++) {
        dispatch_async(queue, ^{
            self.target = [NSString stringWithFormat:@"i = %d", i];
        });
    }
    NSLog(@"%@", self.target);
}

- (void)test08 {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        @synchronized (self) {
            NSLog(@"1");
            sleep(2);
            NSLog(@"1 OK");
        }
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        @synchronized (self) {
            NSLog(@"2");
            sleep(2);
            NSLog(@"2 OK");
        }
    });
}

- (void)test07 {
    // 必须是同步的队列
    dispatch_queue_t queue = dispatch_queue_create(NULL, DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"1");
    });
    dispatch_async(queue, ^{
        NSLog(@"2");
    });
    dispatch_async(queue, ^{
        NSLog(@"3");
    });
    dispatch_barrier_async(queue, ^{
        NSLog(@"barrier");
    });
    dispatch_async(queue, ^{
        NSLog(@"4");
    });
    dispatch_async(queue, ^{
        NSLog(@"5");
    });
}

// 信号量：控制线程的并发数
- (void)test06 {
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//    for (int i = 0; i < 10; i++) {
//        dispatch_async(queue, ^{
//            NSLog(@"%@", [NSThread currentThread]);
//        });
//    }
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
    dispatch_apply(10, dispatch_get_global_queue(0, 0), ^(size_t index) {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"%zd", index);
        sleep(1);
        NSLog(@"%zd ok", index);
        dispatch_semaphore_signal(semaphore);
    });
}

- (void)test05 {
    dispatch_queue_t q1 = dispatch_queue_create("com.q1", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t q2 = dispatch_queue_create("com.q2", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t q3 = dispatch_queue_create("com.q3", DISPATCH_QUEUE_SERIAL);
    
    dispatch_set_target_queue(q3, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0));
    
    dispatch_async(q1, ^{
        sleep(1);
        NSLog(@"1");
    });
    dispatch_async(q2, ^{
        NSLog(@"2");
    });
    dispatch_async(q3, ^{
        NSLog(@"3");
    });
}


- (void)test04 {
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t globalQ = dispatch_get_global_queue(0, 0);
//    dispatch_group_async(group, globalQ, ^{
//        NSLog(@"1");
//    });
//    dispatch_group_async(group, globalQ, ^{
//        NSLog(@"2");
//        sleep(2);
//    });
//    dispatch_group_async(group, globalQ, ^{
//        NSLog(@"3");
//    });
    
    dispatch_group_enter(group);
    dispatch_group_async(group, globalQ, ^{
//        NSLog(@"1");
        dispatch_async(globalQ, ^{
            NSLog(@"1");
            dispatch_group_leave(group);
        });
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, globalQ, ^{
        dispatch_async(globalQ, ^{
            NSLog(@"2");
            dispatch_group_leave(group);
        });
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, globalQ, ^{
        dispatch_async(globalQ, ^{
            NSLog(@"3");
            dispatch_group_leave(group);
        });
    });
    
    dispatch_group_notify(group, globalQ, ^{
        NSLog(@"完成");
    });
    NSLog(@"任务");
}

- (void)test03 {
    // 开辟子线程需要占用内存和小号cpu的资源的，main（1M）子线程（512kb）并不是线程越多越好，306条
    dispatch_queue_t queue = dispatch_queue_create(NULL, DISPATCH_QUEUE_CONCURRENT);
//    for (int i = 0; i < 10; i++) {
//        dispatch_async(queue, ^{
//            NSLog(@"%@", [NSThread currentThread]);
//        });
//    }
//    NSLog(@"End");
//    dispatch_apply(10, queue, ^(size_t index) {
//        NSLog(@"%ld", index);
//    });
    dispatch_apply(10, queue, ^(size_t index) {
        NSLog(@"%ld", index);
        dispatch_async(queue, ^{
            NSLog(@"%@", [NSThread currentThread]);
        });
    });
    
    NSLog(@"Done");
}

- (void)test02 {
    NSLog(@"begin");
//    dispatch_queue_t queue = dispatch_queue_create("com.gcd", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue = dispatch_queue_create("com.gcd", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(queue, ^{
        NSLog(@"任务1");
        dispatch_sync(queue, ^{
            NSLog(@"任务2");
        });
        sleep(1);
        NSLog(@"任务3");
    });

    NSLog(@"end");
}


- (void)test01 {
    NSLog(@"begin");
    dispatch_queue_t queue = dispatch_queue_create("com.gcd", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
//        sleep(2);
        NSLog(@"任务1-%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
//        sleep(3);
        NSLog(@"任务2-%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
//        sleep(1);
        NSLog(@"任务3-%@", [NSThread currentThread]);
    });
//    dispatch_sync(queue, ^{
//        sleep(2);
//        NSLog(@"任务1");
//    });
//    dispatch_sync(queue, ^{
//        sleep(3);
//        NSLog(@"任务2");
//    });
//    dispatch_sync(queue, ^{
//        sleep(1);
//        NSLog(@"任务3");
//    });
    NSLog(@"end");
}

- (void)test00 {
    NSString *urlStr = @"";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = [self securityPolicy];
    
    [manager GET:urlStr parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (AFSecurityPolicy *)securityPolicy {
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"12306" ofType:@"cer"];
    NSData *cerData = [NSData dataWithContentsOfURL:[NSURL URLWithString:cerPath]];
    NSSet *set = [NSSet setWithObject:cerData];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:(AFSSLPinningModeCertificate) withPinnedCertificates:set];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    return securityPolicy;
}

- (void)get {
//    NSString *urlStr = @"https://movie.douban.com/top250";
//    NSDictionary *params = @{
//        @"filter": @"",
//        @"start": @20
//    };
//    NSDictionary *headers = @{
//        @"Referer": @"https://book.douban.com/tag/%E5%B0%8F%E8%AF%B4",
//        @"User-Agent": @"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.94 Safari/537.36"
//    };
    NSString *urlStr = @"http://c.m.163.com/nc/article/headline/T1348647853363/0-40.html";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    manager.requestSerializer.timeoutInterval = 5;
    [manager GET:urlStr parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Success");
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failed");
        NSLog(@"%@", error.localizedDescription);
    }];
}


@end
