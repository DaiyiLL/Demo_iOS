//
//  Car.m
//  14_AppearenceDemo
//
//  Created by Daiyi on 2021/3/4.
//

#import "Car.h"

@implementation Car

/// 松刹车
- (void)releaseBrakes {
    NSLog(@"松刹车");
}
/// 踩刹车
- (void)pressBrakes {
    NSLog(@"踩刹车");
}
/// 踩油门
- (void)pressAccelerator {
    NSLog(@"踩油门");
}
/// 松油门
- (void)releaseAccelerator {
    NSLog(@"松油门");
}

@end
