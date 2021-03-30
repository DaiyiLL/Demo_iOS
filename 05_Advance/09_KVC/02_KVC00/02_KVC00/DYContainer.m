//
//  DYContainer.m
//  02_KVC00
//
//  Created by Daiyi on 2021/3/28.
//

#import "DYContainer.h"

@interface DYContainer()

@property (nonatomic, strong) NSMutableDictionary *dict;

@end

@implementation DYContainer

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if (!key || [key isEqualToString:@""]) {
        return;
    }
    if (_dict == nil) {
        _dict = [NSMutableDictionary dictionaryWithCapacity:64];
    }
    [_dict setValue:value forKey:key];
}

- (id) valueForUndefinedKey:(NSString *)key {
    if (!key || [key isEqualToString:@""]) {
        return nil;
    }
    if (_dict == nil) {
        _dict = [NSMutableDictionary dictionaryWithCapacity:64];
    }
    return [_dict valueForKey:key];
}


@end
