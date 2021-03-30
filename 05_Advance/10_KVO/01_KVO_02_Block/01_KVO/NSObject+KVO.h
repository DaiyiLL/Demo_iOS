//
//  NSObject+KVO.h
//  01_KVO
//
//  Created by Daiyi on 2021/3/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^DYKVOBlock)(id observer, NSString *keyPath, id oldValue, id newValue);

@interface NSObject (KVO)

- (void)dy_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context handler: (DYKVOBlock)handler;

- (void)dy_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;

- (void)dy_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;

@end

NS_ASSUME_NONNULL_END
