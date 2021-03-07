//
//  Apple.h
//  15_MemoryToPattern
//
//  Created by Daiyi on 2021/3/4.
//

#import <Foundation/Foundation.h>
#import "MementoProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface Apple : NSObject <MementoProtocol>

@property (nonatomic,   copy) NSString *name;
@property (nonatomic, assign) double    size;
@property (nonatomic, assign) int       age;

@end

NS_ASSUME_NONNULL_END
