//
//  Person.m
//  05_MsgSend、
//
//  Created by Daiyi on 2021/2/21.
//

/*
 // 消息转发
 - (id)forwardingTargetForSelector:(SEL)aSelector OBJC_AVAILABLE(10.5, 2.0, 9.0, 1.0, 2.0);
 
 // 标准消息转发
 - (void)forwardInvocation:(NSInvocation *)anInvocation OBJC_SWIFT_UNAVAILABLE("");
 - (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector OBJC_SWIFT_UNAVAILABLE("");

// 动态方法解析
 + (BOOL)resolveClassMethod:(SEL)sel OBJC_AVAILABLE(10.5, 2.0, 9.0, 1.0, 2.0);
 + (BOOL)resolveInstanceMethod:(SEL)sel OBJC_AVAILABLE(10.5, 2.0, 9.0, 1.0, 2.0);
 */

#import "Person.h"
#import <objc/message.h>

#import "Animation.h"


@implementation Person

//- (void)run {
//    NSLog(@"%@", self.class);
//}

// 1. 动态方法
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"sel = %@", NSStringFromSelector(sel));
    // 1. 判断没有实现方法，就动态添加方法
//    if (sel == @selector(run:)) {
//        // 动态添加方法
//        class_addMethod(self, sel, (IMP)newRun, "v@:@");
//        return YES;
//    }
    // 2.
    
    return [super resolveInstanceMethod:sel];
}

void newRun(id self, SEL sel, Person *person) {
    NSLog(@"-- run执行了-----%@", person.name);
}

// 二。消息转发冲定向
- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"%@", NSStringFromSelector(aSelector));
    
    return [super forwardingTargetForSelector:aSelector];
//    return [[Animation alloc] init];
}

// 三。生成方法签名。
// 生成方法签名
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    // 1. 转换字符串
    NSString *sel = NSStringFromSelector(aSelector);
    // 2. 进行判断
    if ([sel isEqualToString:@"run"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

// 拿到签名配发消息
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"-----%@", anInvocation);
    
    // 1. 拿到消息
    SEL selector = [anInvocation selector];
    // 2. 转发消息
    Animation *anm = [[Animation alloc] init];
    if ([anm respondsToSelector:selector]) {
        [anInvocation invokeWithTarget:anm];
        return;
    }
    
    [super forwardInvocation:anInvocation];
}

// 抛出异常
- (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSString *selStr = NSStringFromSelector(aSelector);
    NSLog(@"这个------%@----方法不存在", selStr);
}

@end
