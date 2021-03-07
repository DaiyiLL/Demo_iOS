//
//  MemenToCenter.h
//  15_MemoryToPattern
//
//  Created by Daiyi on 2021/3/4.
//

#import <Foundation/Foundation.h>
#import "MementoProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MemenToCenter : NSObject

/// 存对象的状态
+ (void)saveMementoObject: (id<MementoProtocol>)obj withKey: (NSString *)key;

/// 取出对象
+ (id)mementoObjForKey: (NSString *)key;

@end

NS_ASSUME_NONNULL_END
