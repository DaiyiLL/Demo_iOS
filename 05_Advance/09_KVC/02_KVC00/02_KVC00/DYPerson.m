//
//  DYPerson.m
//  02_KVC00
//
//  Created by Daiyi on 2021/3/28.
//

#import "DYPerson.h"


@implementation DYPerson

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dog = [DYDog new];
    }
    return self;
}

@end
