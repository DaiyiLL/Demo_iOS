//
//  DrawBuilder.h
//  09_BuilderView
//
//  Created by Daiyi on 2021/2/25.
//

#import <Foundation/Foundation.h>
#import "DrawView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DrawBuilder : NSObject


/// 构建label
- (CGFloat)buildLabel;

/// 构建按钮
- (CGFloat)buildButton;

/// 构建蓝色的View
- (CGFloat)buildSizeView;

/// 构建结果
- (DrawView *)loadView;

@end

NS_ASSUME_NONNULL_END
