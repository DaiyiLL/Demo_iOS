//
//  NSObject+PrintMethod.h
//  01_KVO
//
//  Created by Daiyi on 2021/3/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (PrintMethod)

/// 打印对应的类及子类
+ (void) printClasses:(Class) cls;

@end

NS_ASSUME_NONNULL_END
