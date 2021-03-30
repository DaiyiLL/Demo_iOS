//
//  DYIndexMGJRouterAPI.m
//  01_MGJRouterDemo
//
//  Created by Daiyi on 2021/3/17.
//

#import "DYIndexMGJRouterAPI.h"
#import <MGJRouter/MGJRouter.h>

@implementation DYIndexMGJRouterAPI

+ (void)test {
    [MGJRouter registerURLPattern:@"http://indexNav" toHandler:^(NSDictionary *routerParameters) {
        
    }];
}

@end
