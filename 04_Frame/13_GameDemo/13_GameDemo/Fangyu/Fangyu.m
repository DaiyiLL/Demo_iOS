//
//  Fangyu.m
//  13_GameDemo
//
//  Created by Daiyi on 2021/3/3.
//

#import "Fangyu.h"

@implementation Fangyu

- (void)handlerRequest:(Gongji *)request {
    [self.nextHandler handlerRequest:request];
}

@end
