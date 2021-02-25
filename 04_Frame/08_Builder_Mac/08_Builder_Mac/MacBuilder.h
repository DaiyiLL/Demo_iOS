//
//  MacBuilder.h
//  08_Builder_Mac
//
//  Created by Daiyi on 2021/2/24.
//

#import <Foundation/Foundation.h>
#import "MacComputerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MacBuilder <NSObject>

// 构建cpu
- (id<MacBuilder>)buildCPU:(NSString *)cpu;

// 构建显卡
- (id<MacBuilder>)buildDisplay:(NSString *)display;

// 构建主板
- (id<MacBuilder>)buildMainboard:(NSString *)mainboard;

// 构建系统
- (id<MacBuilder>)buildSystemOS:(NSString *)os;

// 构建
- (id<MacComputerProtocol>)build;

@end

NS_ASSUME_NONNULL_END
