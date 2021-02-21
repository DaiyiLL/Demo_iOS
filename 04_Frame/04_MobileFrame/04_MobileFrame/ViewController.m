//
//  ViewController.m
//  04_MobileFrame
//
//  Created by Daiyi on 2021/2/9.
//

/*
 设计原则
 */

#import "ViewController.h"
#import "BaseView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    BaseView *bsView = [[BaseView alloc] init];
    [bsView changeBtnFrame:CGRectMake(0, 0, 100, 200)];
    bsView.frame = self.view.bounds;
    [self.view addSubview:bsView];
}


@end
