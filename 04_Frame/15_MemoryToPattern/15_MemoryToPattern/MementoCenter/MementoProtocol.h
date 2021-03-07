//
//  MementoProtocol.h
//  15_MemoryToPattern
//
//  Created by Daiyi on 2021/3/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MementoProtocol <NSObject>

/// 获取状态
- (id)currentState;

/// 恢复状态
- (void)recoverFromState: (id)state;

@end

NS_ASSUME_NONNULL_END
