//
//  ViewController.m
//  Runloop00
//
//  Created by Daiyi on 2021/3/25.
//

#import "ViewController.h"
#import "DYThread.h"

@interface ViewController ()

@property (nonatomic, assign) BOOL stopping;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self performSelector:@selector(fire) withObject:nil afterDelay:1.0];
    
//    CFRunLoopRef mainRunLoop = CFRunLoopGetMain();
//    CFRunLoopRef currentRunloop = CFRunLoopGetCurrent();
    
//    CFRunLoopRef rl = CFRunLoopGetCurrent();
//    CFRunLoopMode mode = CFRunLoopCopyCurrentMode(rl);
//    NSLog(@"mode ----> %@", mode);
//
//    CFArrayRef array = CFRunLoopCopyAllModes(rl);
//    NSLog(@"array - %@", array);
    
//    [self sourceTest];
    
}

- (void)sourceTest {
    CFRunLoopSourceContext context = {
        0,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        schedule,
        cancel,
        perform
    };
    CFRunLoopSourceRef source0 = CFRunLoopSourceCreate(CFAllocatorGetDefault(), 0, &context);
    // schedule
    CFRunLoopAddSource(CFRunLoopGetCurrent(), source0, kCFRunLoopDefaultMode);
    // perform
    CFRunLoopSourceSignal(source0);
    CFRunLoopWakeUp(CFRunLoopGetCurrent());
    // cancel
    CFRunLoopRemoveSource(CFRunLoopGetCurrent(), source0, kCFRunLoopDefaultMode);
    
    CFRelease(source0);
}

void schedule(void *info, CFRunLoopRef rl, CFRunLoopMode mode) {
    NSLog(@"%s", __func__);
}

void cancel(void *info, CFRunLoopRef rl, CFRunLoopMode mode) {
    NSLog(@"%s", __func__);
}

void perform(void *info) {
    NSLog(@"%s", __func__);
}

- (void)demo02 {
    typedef union {
        int a;
        float b;
    } UnionType;
    UnionType type;
    type.a = 3;
    type.b = 10.0;
    NSLog(@"a --> %p", &type.a);
    NSLog(@"v --> %p", &type.b);
    NSLog(@"%zd", sizeof(UnionType));
    NSLog(@"%ld  -- %f", type.a, type.b);
}

- (void)demo01 {
    self.stopping = NO;
    DYThread *th = [[DYThread alloc] initWithBlock:^{
        [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"定时打招呼!!, 您好");
            if (self.stopping) {
                [NSThread exit];
            }
        }];
        NSLog(@"%s", __func__);
        [[NSRunLoop currentRunLoop] run];
    }];
    [th start];
}

- (void)demo {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%s", __func__);
        });
    });
}

- (void)fire {
    NSLog(@"%s", __func__);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
    self.stopping = YES;
}

@end
