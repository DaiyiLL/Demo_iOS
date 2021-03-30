//
//  ViewController.m
//  Runloop00
//
//  Created by Daiyi on 2021/3/25.
//

#import "ViewController.h"
#import "DYThread.h"

@interface ViewController () <NSPortDelegate>

@property (nonatomic, assign) BOOL stopping;
@property (nonatomic, strong) NSPort *subThreadPort;
@property (nonatomic, strong) NSPort *mainThreadPort;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
//    NSLog(@"%@", runLoop);
    
    // activities = 0x1  _wrapRunLoopWithAutoreleasePoolHandler (0x110e8cd92),
    // _objc_autoreleasePoolPush()
    
    // activities = 0xa0 (kCFRunLoopExit|kCFRunLoopBeforeWaiting) _wrapRunLoopWithAutoreleasePoolHandler
    // kCFRunLoopBeforeWaiting  pop push
    // pop
    
    
//    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"Hello ");
//    }];
    // 等价于下
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"Hello");
    }];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    NSThread *th = [[NSThread alloc] initWithBlock:^{
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"Hello ");
        }];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    }];
    [th start];
}

- (void)demo {
    self.mainThreadPort = [NSPort port];
    self.mainThreadPort.delegate = self;
    
    [[NSRunLoop currentRunLoop] addPort:self.mainThreadPort forMode:NSDefaultRunLoopMode];
    
    [self task];
}

- (void)observerTest {
    CFRunLoopObserverRef oberser = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"%s", __func__);
    });
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), oberser, kCFRunLoopDefaultMode);
}

- (void)task {
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        self.subThreadPort = [NSPort port];
        self.subThreadPort.delegate = self;
        
        [[NSRunLoop currentRunLoop] addPort:self.subThreadPort forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    }];
    [thread setName:@"子线程"];
    [thread start];
}

- (void)handlePortMessage:(id)message {
//    NSLog(@"%s", __func__);
//    NSLog(@"%@", [NSThread currentThread]);
    
    NSMutableArray *components = [message valueForKey:@"components"];
    if (components.count > 0) {
        NSData *data = components[0];
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"___ %@", str);
    }
    
    sleep(2);
    if (![[NSThread currentThread] isMainThread]) {
        NSMutableArray *components = [NSMutableArray array];
        NSData *data = [@" World!" dataUsingEncoding:(NSUTF8StringEncoding)];
        [components addObject:data];
        [self.mainThreadPort sendBeforeDate:[NSDate date] components:components from:self.subThreadPort reserved:0];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    NSMutableArray *components = [NSMutableArray array];
    NSData *data = [@"Hello" dataUsingEncoding:(NSUTF8StringEncoding)];
    [components addObject:data];
    [self.subThreadPort sendBeforeDate:[NSDate date] components:components from:self.mainThreadPort reserved:0];
}


@end
