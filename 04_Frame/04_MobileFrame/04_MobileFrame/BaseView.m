//
//  BaseView.m
//  04_MobileFrame
//
//  Created by Daiyi on 2021/2/9.
//

#import "BaseView.h"

@interface BaseView()

@property (nonatomic, strong) UIButton *btnPrint;

@end

@implementation BaseView

- (UIButton *)btnPrint {
    if (!_btnPrint) {
        _btnPrint = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnPrint setTitle:@"button" forState:(UIControlStateNormal)];
        [_btnPrint setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
        _btnPrint.backgroundColor = UIColor.redColor;
        [_btnPrint addTarget:self action:@selector(onPrintClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_btnPrint];
    }
    return _btnPrint;
}

- (void)changeBtnFrame:(CGRect)frame {
    self.btnPrint.frame = frame;
}

- (void)changeBtnFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor {
//    self.btnPrint.frame = frame;
//    self.backgroundColor = backgroundColor;
}

- (void)changeBtnFrame:(CGRect)frame title:(NSString *)title {
    // 代码省略
}

- (void)onPrintClick {
    
}

@end
