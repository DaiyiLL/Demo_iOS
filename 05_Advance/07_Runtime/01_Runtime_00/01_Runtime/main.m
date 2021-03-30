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

extern void test();

extern void instrumentObjcMessageSends(BOOL);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
//        test();
        instrumentObjcMessageSends(YES);
//        Person *p = [[Person alloc] init];
//        [p walk];
        [Person start];
        instrumentObjcMessageSends(NO);
        
    }
    return 0;
}
