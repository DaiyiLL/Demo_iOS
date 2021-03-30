//
//  DYPerson.m
//  01_KVO
//
//  Created by Daiyi on 2021/3/29.
//

#import "DYPerson.h"

@implementation DYPerson

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@%@", _firstName, _lastName];
}

+ (NSSet<NSString *> *)keyPathsForValuesAffectingFullName
{
    return [NSSet setWithObjects:@"lastName", @"firstName", nil];
}

+ (BOOL)automaticallyNotifiesObserversOfSteps {
    return NO;
}

//+ (NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
//
//}

@end
