//
//  Creater.h
//  07_BuildOne
//
//  Created by Daiyi on 2021/2/24.
//

#import <Foundation/Foundation.h>
#import "Builder.h"

NS_ASSUME_NONNULL_BEGIN

@interface Director : NSObject

// 创建传入的实现者
- (instancetype)initWithBuilder: (id<Builder>)builder;
// 建造
- (NSString *)construct;

@end

NS_ASSUME_NONNULL_END
