//
//  Director.h
//  08_Builder_Mac
//
//  Created by Daiyi on 2021/2/25.
//

#import <Foundation/Foundation.h>
#import "MacBuilder.h"
NS_ASSUME_NONNULL_BEGIN

// 组装
@interface Director : NSObject

- (instancetype)initWithBuilder: (id<MacBuilder>)builder;

// 成品方法
- (void)constructCPU:(NSString *)cpu display: (NSString *)display mainboard: (NSString *)mainboard os: (NSString *)os;

@end

NS_ASSUME_NONNULL_END
