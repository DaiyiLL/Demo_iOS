//
//  UINavigationController+Leaks.m
//  MemoryDemo
//
//  Created by Daiyi on 2021/4/5.
//

#import "UINavigationController+Leaks.h"
#import "NSObject+Leaks.h"
#import <objc/runtime.h>

@implementation UINavigationController (Leaks)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSEL:@selector(popViewControllerAnimated:) withSEL:@selector(dy_popViewControllerAnimated:)];
    });
}

- (UIViewController *) dy_popViewControllerAnimated: (BOOL)animated {
    UIViewController *popViewController = [self dy_popViewControllerAnimated:animated];
    extern const void * const kHasBeenPoppedKey;
    if (popViewController) {
        objc_setAssociatedObject(popViewController, kHasBeenPoppedKey, @(YES), OBJC_ASSOCIATION_ASSIGN);
    }
    
    
    return popViewController;
}


@end
