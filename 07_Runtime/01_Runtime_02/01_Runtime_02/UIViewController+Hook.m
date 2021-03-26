//
//  UIViewController+Hook.m
//  01_Runtime_02
//
//  Created by Daiyi on 2021/3/25.
//

#import "UIViewController+Hook.h"
#import <objc/runtime.h>

@implementation UIViewController (Hook)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method m1 = class_getInstanceMethod(self, @selector(viewWillAppear:));
        Method m2 = class_getInstanceMethod(self, @selector(dy_viewWillAppear:));
        method_exchangeImplementations(m1, m2);
    });
}

- (void)dy_viewWillAppear: (BOOL)animated {
    NSLog(@"%s", __func__);
    [self dy_viewWillAppear: animated];
}

@end
