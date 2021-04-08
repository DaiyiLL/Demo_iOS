//
//  DemoViewController.m
//  Performance004
//
//  Created by Daiyi on 2021/4/1.
//

#import "DemoViewController.h"
#import "TimerWraper.h"

@interface DemoViewController ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) TimerWraper *wraper;

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
   
    _wraper = [[TimerWraper alloc] initWithTmerInterval:1 target:self selector:@selector(fire)];
}

- (void)demo {
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(fire) userInfo:nil repeats:YES];
 //    _timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
 //        NSLog(@"%s", __func__);
 //    }];
}

- (void)didMoveToParentViewController:(UIViewController *)parent {
    [super didMoveToParentViewController:parent];
    [_timer invalidate];
    _timer = nil;
}

- (void)fire {
    NSLog(@"%s", __func__);
}

- (void)dealloc {
//    [_timer invalidate];
//    _timer = nil;
    NSLog(@"dealloc");
}

@end
