//
//  NSObject+MementoCenter.h
//  15_MemoryToPattern
//
//  Created by Daiyi on 2021/3/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (MementoCenter)

/// 存对象的状态
- (void)saveStateWithKey: (NSString *)key;

/// 恢复
- (void)recoverStateForKey: (NSString *)key;

@end

NS_ASSUME_NONNULL_END
