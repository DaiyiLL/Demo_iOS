//
//  ConcreateHandlerThree.m
//  13_ResponsibilityDemo
//
//  Created by Daiyi on 2021/3/2.
//

#import "ConcreateHandlerThree.h"

@implementation ConcreateHandlerThree

- (void)handlerRequest:(Person *)request {
    // 判断
    NSLog(@"three: %@ 来了，大家快来", request.name);
}

@end
