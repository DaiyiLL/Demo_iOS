//
//  Person.m
//  01_Runtime
//
//  Created by Daiyi on 2021/3/22.
//

#import "Person.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation Person

//- (void)walk {
//    NSLog(@"%s", __func__);
//}

- (void)run {
    NSLog(@"%s", __func__);
}


//+ (void)start {
//    NSLog(@"%s", __func__);
//}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"%s", __func__);
    
    if (sel == @selector(walk)) {
//        return class_addMethod(self, sel, (IMP)walk, "v@:");
        Method runMethod = class_getInstanceMethod(self, @selector(run));
        IMP runIMP = method_getImplementation(runMethod);
        const char* type = method_getTypeEncoding(runMethod);
        NSLog(@"%s", type);
        return class_addMethod(self, sel, runIMP, type);
    }
    return [super resolveInstanceMethod:sel];
}

void walk() {
    NSLog(@"%s", __func__);
}

+ (BOOL)resolveClassMethod:(SEL)sel {
    NSLog(@"%s", __func__);
    
    if (sel == @selector(start)) {
//        return class_addMethod(self, sel, (IMP)walk, "v@:");
        Method endMethod = class_getClassMethod(self, @selector(end));
        IMP endIMP = method_getImplementation(endMethod);
        const char* type = method_getTypeEncoding(endMethod);
        NSLog(@"%s", type);
        return class_addMethod(object_getClass(self), sel, endIMP, type);
    }
    
    return [super resolveClassMethod:sel];
}

+ (void)end {
    NSLog(@"%s", __func__);
}
@end
