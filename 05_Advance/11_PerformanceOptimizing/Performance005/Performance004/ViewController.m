//
//  ViewController.m
//  Performance004
//
//  Created by Daiyi on 2021/4/1.
//

#import "ViewController.h"
#import "DemoViewController.h"
#import "DYTimerTarget.h"
#import "Demo1ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    DemoViewController *demoVC = [[DemoViewController alloc] init];
    Demo1ViewController *demoVC = [Demo1ViewController new];
    [self.navigationController pushViewController:demoVC animated:true];
    
}


@end
