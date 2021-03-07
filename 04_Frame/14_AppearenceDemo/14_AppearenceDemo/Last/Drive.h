//
//  Drive.h
//  14_AppearenceDemo
//
//  Created by Daiyi on 2021/3/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Drive : NSObject

// 到达指定的位置
+ (void)driveToLocation: (NSString *)location;

@end

NS_ASSUME_NONNULL_END
