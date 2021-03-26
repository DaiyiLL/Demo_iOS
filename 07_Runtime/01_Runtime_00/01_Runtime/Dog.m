//
//  Dog.m
//  01_Runtime
//
//  Created by Daiyi on 2021/3/22.
//

#import "Dog.h"

@implementation Dog

- (void)walk {
    NSLog(@"%s", __func__);
}

- (void)run {
    NSLog(@"%s", __func__);
}

+ (void)start {
    NSLog(@"%s", __func__);
}

@end
