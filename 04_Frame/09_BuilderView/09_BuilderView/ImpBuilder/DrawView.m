//
//  DrawView.m
//  09_BuilderView
//
//  Created by Daiyi on 2021/2/25.
//

#import "DrawView.h"

@implementation DrawView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    self.backgroundColor = UIColor.redColor;
    
    // label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.buildLabel, 100, 50, 80)];
    label.text = @"TZ";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = UIColor.blackColor;
    [self addSubview:label];
    
    // 按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, [self buildButton], 100, 50)];
    [btn setTitle:@"蓝色" forState:(UIControlStateNormal)];
    btn.titleLabel.backgroundColor = UIColor.redColor;
    [self addSubview:btn];
    
    // 添加view
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 100, [self buildSizeView])];
    subView.backgroundColor = UIColor.blueColor;
    [self addSubview:subView];
    
    UIImage *backgroundImage = [UIImage imageNamed:@"launcher-60"];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
    [self addSubview:backgroundView];
}

@end
