//
//  main.m
//  01_Runtime
//
//  Created by Daiyi on 2021/3/22.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Dog.h"
#import <objc/runtime.h>
#import <objc/message.h>

// 代码 -> 编译连接 -> 执行

void run() {
    NSLog(@"ccc %s", __func__);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
//        run();
        Person *p = [[Person alloc] init];
        /*
        Method m1 = class_getInstanceMethod([p class], @selector(walk));
        Method m2 = class_getInstanceMethod([p class], @selector(run));
        IMP imp = method_getImplementation(m2);
        method_setImplementation(m1, (IMP)run);
         */
        
        /*
        Dog *d = [[Dog alloc] init];
        object_setClass(p, [d class]);
         */
        
        /*
        // 下面是等价的
        [p walk];
        ((void(*)(id, SEL))(void *)objc_msgSend)((id)p, sel_registerName("walk"));
        objc_msgSend(p, sel_registerName("walk"));
        NSLog(@"%p, %p", sel_registerName("walk"), @selector(walk));
        objc_msgSend(p, @selector(walk));
         */
        /*
        [Person start];
        objc_msgSend(objc_getClass("Person"), sel_registerName("start"));
        */
//        [p walk];
        
        [Person start];
    }
    return 0;
}
