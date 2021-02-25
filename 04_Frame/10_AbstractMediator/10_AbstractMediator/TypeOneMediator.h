//
//  TypeOneMediator.h
//  10_AbstractMediator
//
//  Created by Daiyi on 2021/2/26.
//

#import "AbstractMediator.h"
#import "Colleague.h"
NS_ASSUME_NONNULL_BEGIN

@interface TypeOneMediator : AbstractMediator

@property (nonatomic, strong) Colleague *colleagueA;
@property (nonatomic, strong) Colleague *colleagueB;
@property (nonatomic, strong) Colleague *colleagueC;

// 查看信息
- (NSDictionary *)values;

@end

NS_ASSUME_NONNULL_END
