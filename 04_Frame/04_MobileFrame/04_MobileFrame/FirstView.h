//
//  FirstView.h
//  04_MobileFrame
//
//  Created by Daiyi on 2021/2/9.
// 开闭原则

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface FirstView : BaseView

@property (nonatomic,   copy) NSString *string; // 添加了字符串

- (void)changeBtnFrame:(CGRect)frame title: (NSString *)title;

@end

NS_ASSUME_NONNULL_END
