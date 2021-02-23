//
//  AbstractSpamMessages.m
//  06_NXProxy
//
//  Created by Daiyi on 2021/2/23.
//

#import "AbstractSpamMessages.h"

@implementation AbstractSpamMessages

+ (instancetype)shared {
    static id shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (void)emptySpamMessages: (NSArray *)parameter {
    NSLog(@"处理垃圾消息");
}

@end
