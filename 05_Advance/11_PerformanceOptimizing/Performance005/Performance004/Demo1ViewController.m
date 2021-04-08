//
//  Demo1ViewController.m
//  Performance004
//
//  Created by Daiyi on 2021/4/2.
//

#import "Demo1ViewController.h"
#import "DYWeakProxy.h"

@interface Demo1ViewController ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) DYWeakProxy *proxy;

@end

@implementation Demo1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.proxy = [DYWeakProxy alloc];
    self.proxy.target = self;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self.proxy selector:@selector(fire) userInfo:nil repeats:YES];
//    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(fire) userInfo:nil repeats:YES];
}

- (void)fire {
    NSLog(@"%s", __func__);
}

- (void)dealloc
{
    [_timer invalidate];
    _timer = nil;
    NSLog(@"Demo1ViewController dealloc");
}
@end
