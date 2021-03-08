//
//  Invoker.h
//  16_CommandDemo
//
//  Created by Daiyi on 2021/3/7.
//

#import <Foundation/Foundation.h>
#import "CommandProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface Invoker : NSObject

+ (instancetype)shared;
// 回退指令
- (void)goBack;

// 添加操作指令
- (void)addAndExcute: (id<CommandProtocol>)command;


@end

NS_ASSUME_NONNULL_END
