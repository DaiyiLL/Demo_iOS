//
//  NSObject+KVC.m
//  02_KVC00
//
//  Created by Daiyi on 2021/3/28.
//

#import "NSObject+KVC.h"
#import <objc/runtime.h>

@implementation NSObject (KVC)

- (void)dy_setValue:(id)value forKey:(NSString *)key {
    // 判断是否合法
    if (key == nil && key.length == 0) {
        return;
    }
    
    NSString *Key = key.capitalizedString;
    // 先找相关方法
    // set<Key>:; _set<Key>:; setIs<Key>:
    NSString *setKey = [NSString stringWithFormat:@"set%@:", Key];
    SEL setKeySel = NSSelectorFromString(setKey);
    if ([self respondsToSelector:setKeySel]) {
        [self performSelector:setKeySel withObject:value];
        return;
    }
    
    NSString *_setKey = [NSString stringWithFormat:@"_set%@:", Key];
    SEL _setKeySel = NSSelectorFromString(_setKey);
    if ([self respondsToSelector:_setKeySel]) {
        [self performSelector:_setKeySel withObject:value];
        return;
    }
    
    NSString *setIsKey = [NSString stringWithFormat:@"setIs%@:", Key];
    SEL setIsKeySel = NSSelectorFromString(setIsKey);
    if ([self respondsToSelector:setIsKeySel]) {
        [self performSelector:setIsKeySel withObject:value];
        return;
    }
    // 再找相关变量
    if ([self.class accessInstanceVariablesDirectly]) {
        NSException *exception = [NSException exceptionWithName:@"NSUnknownedKeyException" reason:@"setValue:forUndefineKey" userInfo:nil];
        @throw exception;
    }
    // 获取所有的成员变量
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    
    NSString *_vKey = [NSString stringWithFormat:@"_%@", key];
    NSString *_isVKey = [NSString stringWithFormat:@"_%@", Key];
    NSString *vKey = [NSString stringWithFormat:@"_%@", key];
    NSString *isVKey = [NSString stringWithFormat:@"_%@", Key];
    for (int i = 0; i < count; i++) {
        Ivar var = ivars[i];
        const char *varName = ivar_getName(var);
        NSString *name = [NSString stringWithUTF8String:varName];
        
        if ([name isEqualToString:_vKey]
            || [name isEqualToString:_isVKey]
            || [name isEqualToString:vKey]
            || [name isEqualToString:isVKey]) {
            object_setIvar(self, ivars[i], value);
            free(ivars);
            return;
        }
    }
    free(ivars);
    
    [self setValue:value forUndefinedKey:key];
}

@end
