//
//  ViewController.m
//  00_CoreAnimation_Demo1
//
//  Created by yidai on 2020/7/28.
//  Copyright © 2020 yidai. All rights reserved.
//
/*
 动画三步骤
 1. 初始化动画对象
 2. 修改动画属性值
 3. 将动画添加到layer
 
 看到的都是假象，UIView并没有发生变化
 隐式动画: 默认duration=0.25
 presentationLayer负责显示
 
 
 */

#import "ViewController.h"

@interface ViewController () <CAAnimationDelegate>

@property (weak, nonatomic) IBOutlet UIView *redView;
@property (nonatomic, strong) CALayer *layer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CALayer *layer = [[CALayer alloc] init];
    layer.frame = CGRectMake(100, 100, 100, 100);
    layer.backgroundColor = [UIColor greenColor].CGColor;
    
    [self.view.layer addSublayer:layer];
    _layer = layer;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    _layer.frame = CGRectMake(100, 400, 100, 100);
//    _layer.backgroundColor = [UIColor orangeColor].CGColor;
//    CGPoint p = [[touches anyObject] locationInView:self.view];
//    if (_redView.layer.presentationLayer == [_redView.layer hitTest:p]) {
//        NSLog(@"1");
//    }
//    // 修改模型图层
    _redView.frame = CGRectMake(50, 400, 100, 100);
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"position.y";
//    anim.toValue = @400;
    anim.duration = 1;
    anim.removedOnCompletion = NO;
    anim.delegate = self;
//    anim.fillMode = kCAFillModeForwards;
    [_redView.layer addAnimation:anim forKey:nil];
}

#pragma mark - 所有的代理方法------------------------------------
- (void)animationDidStart:(CAAnimation *)anim {
    NSLog(@"start: %@", NSStringFromCGRect(_redView.frame));
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"end: %@", NSStringFromCGRect(_redView.frame));
    NSLog(@"layer end: %@", NSStringFromCGRect(_redView.layer.presentationLayer.frame));
}

@end
