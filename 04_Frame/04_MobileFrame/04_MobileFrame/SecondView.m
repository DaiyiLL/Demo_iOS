//
//  SecondView.m
//  04_MobileFrame
//
//  Created by Daiyi on 2021/2/9.
//

#import "SecondView.h"

@implementation SecondView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)changeBtnFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor {
    // 实现代码
}

- (void)changeBtnFrame:(CGRect)frame title:(NSString *)title {
    // 实现代码
    [self changeBtnFrame:frame];
    [self.btnPrint addTarget:self action:@selector(onBtnPrintClick) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)onBtnPrintClick {
    [self printString];
}

- (void)printString {
    NSLog(@"打印过来了");
}

@end
