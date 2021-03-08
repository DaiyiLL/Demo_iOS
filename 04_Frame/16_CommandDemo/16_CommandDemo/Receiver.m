//
//  Receiver.m
//  16_CommandDemo
//
//  Created by Daiyi on 2021/3/7.
//

#import "Receiver.h"

@interface Receiver() {
    CGFloat _white;   // 白色
    CGFloat _alpha;   // 透明度
}



@end

@implementation Receiver

- (void)setReceiverView:(UIView *)receiverView {
    // 获取数值
    _receiverView = receiverView;
    UIColor *color = _receiverView.backgroundColor;
    
    [color getWhite:&_white alpha:&_alpha];
}

// 变暗的接口
- (void)makeDart: (CGFloat)parameter {
    // 获取数值
    _white -= parameter;
    // 设置取值范围
    _white = MAX(0, _white);
    
    // 设置背景色
    _receiverView.backgroundColor = [UIColor colorWithWhite:_white alpha:_alpha];
}
// 变量的接口
- (void)makeLighter: (CGFloat)parameter {
    // 获取数值
    _white += parameter;
    // 设置取值范围
    _white = MIN(1, _white);
    
    // 设置背景色
    _receiverView.backgroundColor = [UIColor colorWithWhite:_white alpha:_alpha];
}

@end
