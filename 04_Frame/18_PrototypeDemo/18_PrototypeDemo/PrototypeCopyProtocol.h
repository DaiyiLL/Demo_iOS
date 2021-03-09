//
//  PrototypeCopyProtocol.h
//  18_PrototypeDemo
//
//  Created by Daiyi on 2021/3/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PrototypeCopyProtocol <NSObject>

// 复制自己
- (id)clone;

@end

NS_ASSUME_NONNULL_END
