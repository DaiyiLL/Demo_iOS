//
//  Car.h
//  14_AppearenceDemo
//
//  Created by Daiyi on 2021/3/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Car : NSObject

/// 松刹车
- (void)releaseBrakes;
/// 踩刹车
- (void)pressBrakes;
/// 踩油门
- (void)pressAccelerator;
/// 松油门
- (void)releaseAccelerator;

@end

NS_ASSUME_NONNULL_END
