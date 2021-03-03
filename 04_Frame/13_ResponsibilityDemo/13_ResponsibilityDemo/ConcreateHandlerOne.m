//
//  ConcreateHandlerOne.m
//  13_ResponsibilityDemo
//
//  Created by Daiyi on 2021/3/2.
//

#import "ConcreateHandlerOne.h"

@implementation ConcreateHandlerOne

- (void)handlerRequest:(Person *)request {
    // 判断
    if ([request.name isEqualToString:@"zhangsan"]) {
        NSLog(@"%@ 来了", request.name);
    } else {
        NSLog(@"%@ 没来", request.name);
        [self.successor handlerRequest:request];
    }
}

@end
