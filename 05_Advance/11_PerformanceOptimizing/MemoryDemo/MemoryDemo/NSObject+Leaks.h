//
//  NSObject+Leaks.h
//  MemoryDemo
//
//  Created by Daiyi on 2021/4/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Leaks)

- (void)willDealloc;

+ (void) swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL;

@end

NS_ASSUME_NONNULL_END
