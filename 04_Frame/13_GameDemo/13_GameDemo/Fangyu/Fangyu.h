//
//  Fangyu.h
//  13_GameDemo
//
//  Created by Daiyi on 2021/3/3.
//

#import <Foundation/Foundation.h>
#import "Gongji.h"
NS_ASSUME_NONNULL_BEGIN

@interface Fangyu : NSObject

// 下一个响应者
@property (nonatomic, strong) Fangyu *nextHandler;

// 处理请求的接口
- (void)handlerRequest: (Gongji *)request;

@end

NS_ASSUME_NONNULL_END
