//
//  Person.m
//  13_GameDemo
//
//  Created by Daiyi on 2021/3/3.
//

#import "Person.h"

@implementation Person

- (void)handlerRequest:(Gongji *)request {
    NSLog(@"被打了----%@-----", [request class]);
}

@end
