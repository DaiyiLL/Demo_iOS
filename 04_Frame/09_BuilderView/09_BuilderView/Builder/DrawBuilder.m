//
//  DrawBuilder.m
//  09_BuilderView
//
//  Created by Daiyi on 2021/2/25.
//

#import "DrawBuilder.h"

@implementation DrawBuilder

/// 构建label
- (CGFloat)buildLabel {
    return 0;
}

/// 构建按钮
- (CGFloat)buildButton {
    return 0;
}

/// 构建蓝色的View
- (CGFloat)buildSizeView {
    return 0;
}

/// 构建结果
- (DrawView *)loadView {
    CGFloat drawWidth = 200;
    CGFloat drawHeight = 300;
    DrawView *drawView = [[DrawView alloc] initWithFrame:CGRectMake(0, 0, drawWidth, drawHeight)];
    
    drawView.buildLabel = [self buildLabel];
    drawView.buildButton = [self buildButton];
    drawView.buildSizeView = [self buildSizeView];
    
    return drawView;
}

@end
