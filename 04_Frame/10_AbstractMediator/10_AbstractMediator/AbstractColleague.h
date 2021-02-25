//
//  AbstractColleague.h
//  10_AbstractMediator
//
//  Created by Daiyi on 2021/2/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class AbstractColleague;
@protocol ColleagueDelegate <NSObject>

// 跟colleague对象交互
- (void)colleagueEvent: (AbstractColleague *)colleague;

@end

@interface AbstractColleague : NSObject

@property (nonatomic,   weak) id<ColleagueDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
