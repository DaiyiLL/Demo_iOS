//
//  Builder.h
//  07_BuildOne
//
//  Created by Daiyi on 2021/2/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol Builder <NSObject>

// 构建部分
- (NSString *)builderPart;

@end

NS_ASSUME_NONNULL_END
