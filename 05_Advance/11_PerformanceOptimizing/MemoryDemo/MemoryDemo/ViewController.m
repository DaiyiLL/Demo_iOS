//
//  ViewController.m
//  MemoryDemo
//
//  Created by Daiyi on 2021/4/2.
//

#import "ViewController.h"
#import "DemoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    DemoViewController *demoVC = [[DemoViewController alloc] init];
    [self.navigationController pushViewController:demoVC animated:true];
}


@end
