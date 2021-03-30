//
//  RootViewController.m
//  RAC102_AFN
//
//  Created by Daiyi on 2021/3/10.
//

#import "RootViewController.h"
#import "ViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ViewController *vc = [[ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}

@end
