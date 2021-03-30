//
//  DYPerson2.m
//  02_KVC00
//
//  Created by Daiyi on 2021/3/28.
//

#import "DYPerson2.h"

@implementation DYPerson2

- (void)setName: (NSString *)name {
    NSLog(@"%s", __func__);
}

- (void)_setName: (NSString *)name {
    NSLog(@"%s", __func__);
}

- (void)setIsName: (NSString *)name {
    NSLog(@"%s", __func__);
}


//- (NSString *)getName {
//    NSLog(@"%s", __func__);
//    return @"Tom_Get";
//}
//
//- (NSString *)name {
//    NSLog(@"%s", __func__);
//    return @"Tom_Get";
//}



+ (BOOL)accessInstanceVariablesDirectly {
    return NO;
//    return [super accessInstanceVariablesDirectly];
}

// 该方法没有调用
//- (void)_setIsName: (NSString *)name {
//    NSLog(@"%s", __func__);
//}


@end
