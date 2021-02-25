//
//  Colleague.h
//  10_AbstractMediator
//
//  Created by Daiyi on 2021/2/26.
//

#import "AbstractColleague.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Colleague : AbstractColleague

@property (nonatomic, assign) CGFloat value;

// 修改数值
- (void)changeValue: (CGFloat)value;

@end

NS_ASSUME_NONNULL_END
