//
//  ViewController.m
//  DrectDemo
//
//  Created by yidai on 2020/5/4.
//  Copyright © 2020 yidai. All rights reserved.
//

#import "ViewController.h"
#import "YYTestVC.h"
#import "YYChartView.h"

@interface ViewController ()

@property (nonatomic, strong) YYChartView *chartView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _chartView = [[YYChartView alloc] initWithFrame:CGRectMake(0, 0, 302, 300)];
    _chartView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_chartView];
    _chartView.verticalAbs = 100;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_chartView reloadAllViews];
    });
}

- (IBAction)buttonClicked:(id)sender {
    YYTestVC *testVC = [[YYTestVC alloc] init];
    [self.navigationController pushViewController:testVC animated:true];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _chartView.center = self.view.center;
}


@end
