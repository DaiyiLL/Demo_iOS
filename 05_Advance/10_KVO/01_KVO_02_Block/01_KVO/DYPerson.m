//
//  DYPerson.m
//  01_KVO
//
//  Created by Daiyi on 2021/3/29.
//

#import "DYPerson.h"

@implementation DYPerson

- (void)setName:(NSString *)name{
    if (_name != name) {
        _name = name;
    }
}

//- (void)dealloc
//{
//    NSLog(@"DYPerson %s", __func__);
//}

//- (void) kvoDealloc {
//    
//    NSLog(@"%s", __func__);
//}

@end
