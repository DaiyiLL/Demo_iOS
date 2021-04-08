//
//  main.m
//  Performance001
//
//  Created by Daiyi on 2021/3/30.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <objc/runtime.h>

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        NSObject *obj = [NSObject new];
        // 8字节：不正确，  正确的是 >= 16
        NSLog(@"%zd", class_getInstanceSize([obj class]));
        
//        for (int i = 0; i < 10; i++) {
//            NSNumber *num = @(i*0xFFFFFFFFFFFFFFF);
//
//            // 0x8e2352ee9d828678  前后  8 是标志位
//            NSLog(@"%p", num);
////            NSLog(@"&& = %p", &num);
//        }
        
        NSString *s = @"123";
        NSString *s1 = [NSString stringWithFormat:@"123"];
        NSString *s2 = [NSString stringWithFormat:@"1234567890"];
        NSLog(@"s = %p", s);
        NSLog(@"s = %p", s1);
        NSLog(@"s = %p", s2);
        
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
