//
//  Person.m
//  01_Runtime
//
//  Created by Daiyi on 2021/3/22.
//

#import "Person.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "Dog.h"

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

void test() {
    NSLog(@"%s", __func__);
}


void walk() {
    NSLog(@"%s", __func__);
}


+ (void)end {
    NSLog(@"%s", __func__);
}


- (id)forwardingTargetForSelector:(SEL)aSelector {
//    if (aSelector == @selector(walk)) {
//        return [[Dog alloc] init];
//    }
    return [super forwardingTargetForSelector:aSelector];
}

/// 方法名注册
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (aSelector == @selector(walk)) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void) forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"%s", __func__);
    
//    [anInvocation invokeWithTarget:[Dog new]];
    anInvocation.selector = @selector(run);
    [anInvocation invoke];
}

+ (id)forwardingTargetForSelector:(SEL)aSelector {
//    if (aSelector == @selector(start)) {
//        return [Dog class];
//    }
    return [super forwardingTargetForSelector:aSelector];
}

/// 方法名注册
+ (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (aSelector == @selector(start)) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

+ (void) forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"%s", __func__);
    
//    [anInvocation invokeWithTarget:[Dog new]];
    anInvocation.selector = @selector(end);
    anInvocation.target = self;
    [anInvocation invoke];
}



@end
