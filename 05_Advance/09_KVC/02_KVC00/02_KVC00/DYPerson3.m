//
//  DYPerson3.m
//  02_KVC00
//
//  Created by Daiyi on 2021/3/28.
//

#import "DYPerson3.h"

@implementation DYPerson3

- (void)setNilValueForKey:(NSString *)key {
    NSLog(@"%@ 值不能为空", key);
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"key = %@ 不存在", key);
}

- (id)valueForUndefinedKey:(NSString *)key {
    NSLog(@"key = %@ 不存在", key);
    return nil;
}

- (BOOL) validateValue:(inout id  _Nullable __autoreleasing *)ioValue forKey:(NSString *)inKey error:(out NSError *__autoreleasing  _Nullable *)outError {
    if ([inKey isEqualToString:@"age"]) {
        int age = (int)*ioValue;
        if (age <= 0) {
            return  false;
        }
    }
    return true;
}


@end
