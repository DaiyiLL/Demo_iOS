//
//  Node.m
//  12_CompositeDemo
//
//  Created by Daiyi on 2021/3/2.
//

#import "Node.h"

@implementation Node

- (instancetype)initWithData:(id)data {
    self = [[[self class] alloc] init];
    if (self) {
        _data = data;
    }
    return self;
}

@end
