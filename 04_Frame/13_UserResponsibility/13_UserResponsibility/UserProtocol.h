//
//  UserProtocol.h
//  13_UserResponsibility
//
//  Created by Daiyi on 2021/3/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol UserProtocol <NSObject>

// 下一个引用
@property (nonatomic, strong) id<UserProtocol> successor;

// 处理请求的接口
- (void)handlerRequest: (id)request;

@end

NS_ASSUME_NONNULL_END
