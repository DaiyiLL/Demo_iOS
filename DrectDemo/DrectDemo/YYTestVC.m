//
//  YYTestVC.m
//  DrectDemo
//
//  Created by yidai on 2020/5/4.
//  Copyright © 2020 yidai. All rights reserved.
//

#import "YYTestVC.h"
#import "YYChartColorView.h"

@interface YYTestVC ()

@property (nonatomic, strong) YYChartColorView *chartView;

@end

@implementation YYTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    _chartView = [[YYChartColorView alloc] initWithFrame:CGRectMake(0, 0, 302, 300)];
    _chartView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_chartView];
    _chartView.verticalAbs = 100;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_chartView reloadAllViews];
    });
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _chartView.center = self.view.center;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
