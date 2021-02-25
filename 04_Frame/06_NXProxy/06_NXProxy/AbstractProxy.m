//
//  AbstractProxy.m
//  06_NXProxy
//
//  Created by Daiyi on 2021/2/22.
//

#import "AbstractProxy.h"
#import "AbstractSpamMessages.h"
#import <objc/runtime.h>

@implementation AbstractProxy
// 方法签名
- (nullable NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    // 如果支持这个熊希，就将这个方法签名返回回去
    if ([self.delegate respondsToSelector:sel]) {
        return [self.delegate methodSignatureForSelector:sel];
    } else {
        AbstractSpamMessages *message = [AbstractSpamMessages shared];
        
        //
        return [message methodSignatureForSelector:NSSelectorFromString(@"emptySpamMessages:")];
    }
}
// 配发消息
- (void)forwardInvocation:(NSInvocation *)invocation {
    // 1. 获取sel
    SEL selector = [invocation selector];
    // 2. 判断
    if ([self.delegate respondsToSelector:selector]) {
        // 设置代理
        [invocation setTarget:self.delegate];
        // 执行方法，派发消息
        [invocation invoke];
    } else {
        // 获取参数
        NSString *selectorString = NSStringFromSelector(invocation.selector);
        // 1. 替换
        invocation.selector = NSSelectorFromString(@"emptySpamMessages:");
        // 2. 再次获取单例对象
        AbstractSpamMessages *message = [AbstractSpamMessages shared];
        // 设置代理
        [invocation setTarget:message];
        
        const char *className = class_getName([self class]);
        NSArray *parmater = nil;
        if (self.delegate) {
            parmater = @[[NSString stringWithUTF8String:className], selectorString, @" "];
        } else {
            parmater = @[[NSString stringWithUTF8String:className], selectorString];
        }
        // 因为0，1被两个隐式参数占用self，_cmd，分别表示的是target和selector
        [invocation setArgument:&parmater atIndex:2];
//        [invocation setArgument:&str atIndex:3];
        // 执行方法，派发消息
        [invocation invoke];
    }
}

@end
