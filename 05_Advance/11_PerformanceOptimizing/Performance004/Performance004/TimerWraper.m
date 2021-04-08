//
//  TimerWraper.m
//  Performance004
//
//  Created by Daiyi on 2021/4/2.
//

#import "TimerWraper.h"

@interface TimerWraper ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic,   weak) id  target;
@property (nonatomic, assign) SEL sel;

@end

@implementation TimerWraper

- (instancetype)initWithTmerInterval:(NSTimeInterval)interval target: (id)target selector: (SEL)selector {
    self = [super init];
    if (self) {
        _target = target;
        _sel = selector;
        _timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(fire) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)fire {
    if ([self.target respondsToSelector:_sel]) {
        [self.target performSelector:_sel];
    }
}

- (void)stop {
    [_timer invalidate];
    _timer = nil;
}

- (void)dealloc {
    NSLog(@"TimerWraper dealloc");
}

@end
