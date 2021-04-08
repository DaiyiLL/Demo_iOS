//
//  main.m
//  Performance001
//
//  Created by Daiyi on 2021/3/30.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

// BSS段
int g1;
static int s1;

int g2 = 0;
static int s2 = 0;

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // 栈区
        int i = 10;
        int j = 10;
        NSObject *obj = [NSObject new];
        
        NSLog(@"%p", &i);
        NSLog(@"%p", &j);
        // obj指针的的地址
        NSLog(@"%p", &obj);
        
        // 堆区
        NSObject *obj1 = [NSObject new];
        NSObject *obj2 = [NSObject new];
        NSObject *obj3 = [NSObject new];
        NSLog(@"%p", obj1);
        NSLog(@"%p", obj2);
        NSLog(@"%p", obj3);
        
        NSLog(@"---------------------");
        NSLog(@"%p", &g1);
        NSLog(@"%p", &s1);
        
        NSLog(@"%p", &g2);
        NSLog(@"%p", &s2);
        
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
