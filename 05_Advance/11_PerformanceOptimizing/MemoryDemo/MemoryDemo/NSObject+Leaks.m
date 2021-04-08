//
//  NSObject+Leaks.m
//  MemoryDemo
//
//  Created by Daiyi on 2021/4/3.
//

#import "NSObject+Leaks.h"
#import <objc/runtime.h>

@implementation NSObject (Leaks)

- (void)willDealloc {
    __weak id weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong id strongSelf = weakSelf;
        [strongSelf assertNotDealloc];
    });
}
- (void) assertNotDealloc {
    NSLog(@"Leaks %@", NSStringFromClass([self class]));
}

+ (void) swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL {
   
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, originalSEL);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSEL);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSEL,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSEL,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
