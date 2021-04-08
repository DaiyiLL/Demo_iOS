//
//  main.m
//  Performance004
//
//  Created by Daiyi on 2021/4/1.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

extern void _objc_autoreleasePoolPrint(void);

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
        // aautoreleasepoolpage    4096 - 56 = 4040 / 8 = 505 - 1(哨兵) = 504
        /*
        for (int i = 0; i < 3; i++) {
            NSObject *obj = [[[NSObject alloc] init] autorelease];
            
        }
        @autoreleasepool {
            for (int i = 0; i < 3; i++) {
                NSObject *obj = [[[NSObject alloc] init] autorelease];
                
            }
            _objc_autoreleasePoolPrint();
        }
        
        _objc_autoreleasePoolPrint();
        */
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
//    return 0;
}
