//
//  Apple.m
//  15_MemoryToPattern
//
//  Created by Daiyi on 2021/3/4.
//

#import "Apple.h"

@implementation Apple

/// 获取状态
- (id)currentState {
    return @{
        @"name": self.name,
        @"age": @(self.age),
        @"size": @(self.size)
    };
}

/// 恢复状态
- (void)recoverFromState: (id)state {
    NSDictionary *data = state;
    self.name = data[@"name"];
    self.age = [data[@"age"] intValue];
    self.size = [data[@"size"] doubleValue];
}

@end
