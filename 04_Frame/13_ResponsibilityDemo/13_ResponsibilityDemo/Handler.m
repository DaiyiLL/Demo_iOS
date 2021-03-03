//
//  Handler.m
//  13_ResponsibilityDemo
//
//  Created by Daiyi on 2021/3/2.
//

#import "Handler.h"

@implementation Handler

// 处理请求的接口
- (void)handlerRequest:(Person *)request {
    // 如果不知道请求，就把请求给successor
    [self.successor handlerRequest:request];
}

@end
