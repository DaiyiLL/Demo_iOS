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
    
    
}

@end
