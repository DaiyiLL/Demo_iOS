//
//  ViewController.m
//  002_LockDemo
//
//  Created by Daiyi on 2021/4/15.
//

#import "ViewController.h"
#import <pthread.h>
#import <libkern/OSAtomic.h>
#import <QuartzCore/QuartzCore.h>

typedef NS_ENUM(NSUInteger, LockType) {
    LockTypeOSSpinLock = 0,
    LockTypedispatch_semaphore,
    LockTypepthread_mutex,
    LockTypeNSCondition,
    LockTypeNSLock,
    LockTypepthread_mutex_recursive,
    LockTypeNSRecursiveLock,
    LockTypeNSConditionLock,
    LockTypesynchronized,
    LockTypeCount,
};
NSTimeInterval TimeCosts[LockTypeCount] = {0};
int TimeCount = 0;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}
- (IBAction)clearData:(id)sender {
    for (int i = 0; i < LockTypeCount; i++) {
        TimeCosts[i] = 0;
    }
    TimeCount = 0;
    printf("--- clear ----\n\n");
}

- (void)setupUI {
    int buttonCount = 5;
    for (int i = 0; i < buttonCount; i++) {
        UIButton *button = [self.view viewWithTag:100 + i];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    }
}

- (void)buttonClicked: (UIButton *)sender {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self test:pow(10, (sender.tag - 100) + 3)];
    });
}

- (void)test: (int)count {
    NSTimeInterval begin, end;
    TimeCount += count;
    
    {
        // 不再安全的 OSSpinLock 除此之外  dispatch_semaphore 和 ptheread_mutex 性能最高
        OSSpinLock lock = OS_SPINLOCK_INIT;
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            OSSpinLockLock(&lock);
            OSSpinLockUnlock(&lock);
        }
        end = CACurrentMediaTime();
        TimeCosts[LockTypeOSSpinLock] += end - begin;
        printf("OSSpinLock:               %8.2f ms\n", (end - begin) * 1000);
    }
    
    {
        dispatch_semaphore_t lock = dispatch_semaphore_create(1);
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
            dispatch_semaphore_signal(lock);
        }
        end = CACurrentMediaTime();
        TimeCosts[LockTypedispatch_semaphore] += (end - begin);
        printf("dispatch_semaphore:       %8.2f ms\n", (end - begin) * 1000);
    }
    
    {
        pthread_mutex_t lock;
        pthread_mutex_init(&lock, NULL);
        for (int i = 0; i < count; i++) {
            pthread_mutex_lock(&lock);
            pthread_mutex_unlock(&lock);
        }
        end = CACurrentMediaTime();
        TimeCosts[LockTypepthread_mutex] += (end - begin);
        printf("pthread_mutex:            %8.2f ms\n", (end - begin) * 1000);
    }
    
    {
        NSLock *lock = [NSLock new];
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            [lock lock];
            [lock unlock];
        }
        end = CACurrentMediaTime();
        TimeCosts[LockTypeNSLock] += end - begin;
        printf("NSLock:                   %8.2f ms\n", (end - begin) * 1000);
    }
    
    {
        pthread_mutex_t lock;
        pthread_mutexattr_t attr;
        pthread_mutexattr_init(&attr);
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
        pthread_mutex_init(&lock, &attr);
        pthread_mutexattr_destroy(&attr);
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            pthread_mutex_lock(&lock);
            pthread_mutex_unlock(&lock);
        }
        end = CACurrentMediaTime();
        TimeCosts[LockTypepthread_mutex_recursive] += end - begin;
        pthread_mutex_destroy(&lock);
        printf("pthread_mutex(recursive): %8.2f ms\n", (end - begin) * 1000);
    }
    
    {
        NSRecursiveLock *lock = [NSRecursiveLock new];
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            [lock lock];
            [lock unlock];
        }
        end = CACurrentMediaTime();
        TimeCosts[LockTypeNSRecursiveLock] += end - begin;
        printf("NSRecursiveLock:          %8.2f ms\n", (end - begin) * 1000);
    }
    
    {
        NSConditionLock *lock = [[NSConditionLock alloc] initWithCondition:1];
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            [lock lock];
            [lock unlock];
        }
        end = CACurrentMediaTime();
        TimeCosts[LockTypeNSConditionLock] += end - begin;
        printf("NSConditionLock:          %8.2f ms\n", (end - begin) * 1000);
    }
    
    {
        NSObject *lock = [NSObject new];
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            @synchronized (lock) {
            }
        }
        end = CACurrentMediaTime();
        TimeCosts[LockTypesynchronized] += end - begin;
        printf("@synchronized:            %8.2f ms\n", (end - begin) * 1000);
    }
    
    printf("---- fin (%d) ----\n\n",count);
    
}

@end
