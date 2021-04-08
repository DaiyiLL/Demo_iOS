//
//  DemoViewController.m
//  Performance004
//
//  Created by Daiyi on 2021/4/1.
//

#import "DemoViewController.h"
#import "TimerWraper.h"
#import "DYTimerTarget.h"
#import <objc/runtime.h>

@interface DemoViewController ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) DYTimerTarget *target;

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    // runloop -> timer -> target <- self
    _target = [DYTimerTarget new];
    class_addMethod([_target class], @selector(fire), (IMP)fire, "v@:");
//    class_addMethod([_target class], @selector(fire), (IMP)fire, "v@:");
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:_target selector:@selector(fire) userInfo:nil repeats:YES];
}

void fire() {
    NSLog(@"%s", __func__);
}

- (void)demo {
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(fire) userInfo:nil repeats:YES];
 //    _timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
 //        NSLog(@"%s", __func__);
 //    }];
}

- (void)fire {
    NSLog(@"%s", __func__);
}

- (void)dealloc {
    [_timer invalidate];
    _timer = nil;
    NSLog(@"dealloc");
}

@end
