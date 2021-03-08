//
//  CommandProtocol.h
//  16_CommandDemo
//
//  Created by Daiyi on 2021/3/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CommandProtocol <NSObject>
// 执行命令
- (void)excuteCommand;

// 撤销命令
- (void)gobackCommand;

@end

NS_ASSUME_NONNULL_END
