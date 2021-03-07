//
//  CoachDriver.m
//  14_AppearenceDemo
//
//  Created by Daiyi on 2021/3/4.
//

#import "CoachDriver.h"
#import "Car.h"
#import "Teaching.h"

@implementation CoachDriver

+ (void)teachDriving {
    // 驾驶汽车
    Car *car = [[Car alloc] init];
    [car releaseBrakes]; // 松刹车
    [car pressAccelerator]; // 踩油门
    
    // 到达目的地
    [car pressBrakes];   // 踩刹车
    [car releaseAccelerator]; // 松油门

    // 教倒车
    Teaching *teach = [[Teaching alloc] init];
    [teach reversing];
}

+ (void)driveToLocation:(NSString *)location {
    [self teachDriving];
    NSLog(@"%@ 到达了", location);
}

@end
