//
//  BaseCopyObject.m
//  18_PrototypeDemo
//
//  Created by Daiyi on 2021/3/9.
//

#import "BaseCopyObject.h"

@implementation BaseCopyObject

- (id)copyWithZone:(NSZone *)zone {
    BaseCopyObject *copyObject = [[self class] allocWithZone:zone];
    // 赋值
    [self copyOperationForObject:copyObject];
    
    return copyObject;
}

- (void)copyOperationForObject:(id)object {
    
}

@end
