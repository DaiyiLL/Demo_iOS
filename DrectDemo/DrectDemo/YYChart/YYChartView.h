//
//  YYChartView.h
//  DrectDemo
//
//  Created by yidai on 2020/5/4.
//  Copyright © 2020 yidai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYChartModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYChartView : UIView

@property (nonatomic, assign) UIEdgeInsets innerPadding;
@property (nonatomic, assign) NSInteger    halfLineCount;
@property (nonatomic, assign) NSUInteger   verticalAbs;
@property (nonatomic, assign) NSUInteger   horizontalAbs;

@property (nonatomic, strong) NSArray<YYChartModel *> *dataList;

- (void)reloadAllViews;
// 方便使用继承
- (void)showDotViews;

- (void)dotClicked: (UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
