//
//  ConcreateHandlerTwo.m
//  13_ResponsibilityDemo
//
//  Created by Daiyi on 2021/3/2.
//

#import "ConcreateHandlerTwo.h"

@implementation ConcreateHandlerTwo

- (void)handlerRequest:(Person *)request {
    // 判断
    if ([request.name isEqualToString:@"lisi"]) {
        NSLog(@"two: %@ 来了", request.name);
    } else {
        NSLog(@"two: %@ 没来", request.name);
        [self.successor handlerRequest:request];
    }
}

@end
