//
//  BaseCopyObject.h
//  18_PrototypeDemo
//
//  Created by Daiyi on 2021/3/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseCopyObject : NSObject <NSCopying>

// 子类不要重载
- (id)copyWithZone:(NSZone *)zone;

// 子类去实现
- (void)copyOperationForObject: (id)object;


@end

NS_ASSUME_NONNULL_END
