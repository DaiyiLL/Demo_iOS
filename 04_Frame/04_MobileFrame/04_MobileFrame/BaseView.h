//
//  BaseView.h
//  04_MobileFrame
//
//  Created by Daiyi on 2021/2/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseView : UIView

@property (nonatomic, strong, readonly) UIButton *btnPrint;

// 接口隔离原则
- (void)changeBtnFrame: (CGRect)frame;

- (void)changeBtnFrame: (CGRect)frame backgroundColor: (UIColor *)backgroundColor;

- (void)changeBtnFrame:(CGRect)frame title: (NSString *)title;

@end

NS_ASSUME_NONNULL_END
