//
//  ViewController.m
//  001_ThreadDemo
//
//  Created by Daiyi on 2021/4/14.
//

#import "ViewController.h"
#import "Person.h"
#include <pthread.h>

@interface ViewController ()

@property (nonatomic, strong) Person *p;
@property (nonatomic, strong) NSThread *t;

@end

@implementation ViewController

/*
 int pthread_create(
      pthread_t *restrict tidp,   //新创建的线程ID指向的内存单元。
      const pthread_attr_t *restrict attr,  //线程属性，默认为NULL
      void *(*start_rtn)(void *), //新创建的线程从start_rtn函数的地址开始运行
      void *restrict arg //默认为NULL。若上述函数需要参数，将参数放入结构中并将地址作为arg传入。
  );

 
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self testThreadProperty];
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self threadTest];
    [self touchEvent];
}

- (void)touchEvent {
    if (self.t == nil) {
        NSThread *t = [[NSThread alloc] initWithTarget:self selector:@selector(testThreadStatus) object:nil];
        [t start];
        t.name = @"学习线程1";
        self.t = t;
    } else {
        [self.t cancel];
    }

}

- (void)testThreadProperty {
    NSLog(@"%lu", (unsigned long)[NSThread currentThread].stackSize);
    NSThread *t = [[NSThread alloc] initWithTarget:self selector:@selector(testThreadStatus) object:nil];
    [t start];
    t.name = @"学习线程";
    t.stackSize = 64 * 1024;
}

- (void)testThreadStatus {
    NSLog(@"来了");
    if (self.t == nil || self.t.isCancelled || self.t.isFinished || self.t.isExecuting) {
        NSThread *t = [[NSThread alloc] initWithTarget:self selector:@selector(testThreadStatus) object:nil];
        [t start];
        t.name = @"泡妞线程";
        
        
    } else {
        for (int i = 0; i < 10; i++) {
            if (i == 2) {
                [NSThread sleepForTimeInterval:3];
            }
            NSLog(@"%@ ----- %d", [NSThread currentThread], i);
        }
        [self.t cancel];
        self.t = nil;
    }
    NSLog(@"完成");
    
}

- (void)demo {
    // thread
//    [NSThread detachNewThreadSelector:@selector(threadTest) toTarget:self withObject:nil];
    // GCD
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [self threadTest];
//    });
    
    // pthread
    pthread_t threadId = NULL;
    /*
     1: 线程id
     2: 线程属性
     3: 函数回调地址
     4: 参数
     */
    char *pthStr = "daishuyi";
    pthread_create(&threadId, NULL, pthreadDemo, pthStr);
}

void pthreadDemo() {
    [[[ViewController alloc] init] threadTest];
}

- (void)threadTest {
    NSLog(@"begin");
    // 现象： 堵塞 <--> 死锁 (A 等待C C等待A)
    NSInteger count = 1000 * 100;
    // NSLog I/O 流
    for (int i = 0; i < count; i++) {
        // 文字常量区: 未初始化的全局变量 静态变量去
        // 代码区: 存放二进制代码
        // 五大区: 栈 堆 常量区 文字常量区 代码区
        // 栈： study函数(栈帧，存储局部变量，函数参数)
        NSInteger num = i;
        // 常量区
        NSString *name = @"HelloCode";
        NSString *myName = [NSString stringWithFormat:@"%@ --- %zd", name, num];
        NSLog(@"%@", myName);
    }
    NSLog(@"over");
}


@end
