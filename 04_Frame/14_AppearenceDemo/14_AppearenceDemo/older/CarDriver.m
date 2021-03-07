//
//  CarDriver.m
//  14_AppearenceDemo
//
//  Created by Daiyi on 2021/3/4.
//

#import "CarDriver.h"
#import "Taximeter.h"
#import "Car.h"

@implementation CarDriver

+ (void)driveToLocation:(NSString *)location {
    // 启动计价器
    Taximeter *taximeter = [[Taximeter alloc] init];
    [taximeter start];
    
    // 驾驶汽车
    Car *car = [[Car alloc] init];
    [car releaseBrakes]; // 松刹车
    [car pressAccelerator]; // 踩油门
    
    // 到达目的地
    [car pressBrakes];   // 踩刹车
    [car releaseAccelerator]; // 松油门
    [taximeter stop];
    
    NSLog(@"已经到达 %@", location);
}

@end
