//
//  NSObject+KVO.m
//  01_KVO
//
//  Created by Daiyi on 2021/3/29.
//

#import "NSObject+KVO.h"
//#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (KVO)

//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        NSString *selectName = @"dealloc";
//        // NSObject dealloc
//        SEL aSelector = NSSelectorFromString(selectName);
//        Method m1 = class_getInstanceMethod(self, aSelector);
//        Method m2 = class_getInstanceMethod(self, @selector(kvoDealloc));
//
//        method_exchangeImplementations(m1, m2);
//    });
//}

- (void)dy_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    // 动态创建一个子类
    Class newClass = [self createClass: keyPath];
    
    // 修改了isa的指向
    object_setClass(self, newClass);
    
    // 关联方发
    objc_setAssociatedObject(self, (__bridge void *)@"dy_objc_observer", observer, OBJC_ASSOCIATION_ASSIGN);
    
}

// NSKVONotifying_DYPerson
- (Class)createClass: (NSString *)keyPath {
    // 1. 拼接子类名
    NSString *oldName = NSStringFromClass([self class]);
    
    NSString *newName = [NSString stringWithFormat:@"DYKVONotifying_%@", oldName];
    // 2. 创建并注册类
    Class newClass = NSClassFromString(newName);
    if (!newClass) {
        newClass = objc_allocateClassPair([self class], newName.UTF8String, 0);
        objc_registerClassPair(newClass);
        // 动态的添加了一些方法 (setter class)
        // class方法
        Method classMethod = class_getInstanceMethod([self class], @selector(class));
        const char * classTypes = method_getTypeEncoding(classMethod);
        class_addMethod(newClass, @selector(class), (IMP)dy_class, classTypes);
        
        // setter方法
        NSString *setterMethodName = setterForGetter(keyPath);
        SEL setterSEL = NSSelectorFromString(setterMethodName);
        // 通过父类的setter方法获取参数
        Method setterMethod = class_getInstanceMethod([self class], setterSEL);
        const char *setterTypes = method_getTypeEncoding(setterMethod);
        class_addMethod(newClass, setterSEL, (IMP)dy_setter, setterTypes);
        
        // 添加西沟方法
        SEL deallocSEL = NSSelectorFromString(@"dealloc");
        Method deallocMethod = class_getInstanceMethod([self class], deallocSEL);
        const char *deallocTypes = method_getTypeEncoding(deallocMethod);
        class_addMethod(newClass, deallocSEL, (IMP)dyDealloc, deallocTypes);
        
//        [self hookDealloc];
    }
    
    return newClass;
}

void dyDealloc(id self, SEL _cmd) {
    Class superClass = class_getSuperclass(object_getClass(self));
    object_setClass(self, superClass);
    
//    objc_msgSend(object_getClass(self), NSSelectorFromString(@"dealloc"));
}

- (void) hookDealloc {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        NSString *selectName = @"dealloc";
//        // NSObject dealloc
//        SEL aSelector = NSSelectorFromString(selectName);
//        Method m1 = class_getInstanceMethod(object_getClass(self), aSelector);
//        Method m2 = class_getInstanceMethod(object_getClass(self), @selector(kvoDealloc));
//
//        method_exchangeImplementations(m1, m2);
//    });
    Method m1 = class_getInstanceMethod(object_getClass(self), NSSelectorFromString(@"dealloc"));
    Method m2 = class_getInstanceMethod(object_getClass(self), @selector(kvoDealloc));
    method_exchangeImplementations(m1, m2);
}

- (void) kvoDealloc {
    Class superClass = class_getSuperclass(object_getClass(self));
    object_setClass(self, superClass);
    [self kvoDealloc];
}

- (void)dy_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
//    objc_getAssociatedObject(self, (__bridge void *)@"dy_objc_observer");
    // 父类
    Class superClass = class_getSuperclass(object_getClass(self));
    object_setClass(self, superClass);
}

// setter方法
#pragma mark - c 函数
static void dy_setter(id self, SEL _cmd, id newValue) {
    struct objc_super superStruct = {
        self,
        class_getSuperclass(object_getClass(self))
    };
    // 改变父类的值
    objc_msgSendSuper(&superStruct, _cmd, newValue);
    
    // 通知观察者，值发生了变化
    // 观察者
    id observer = objc_getAssociatedObject(self, (__bridge void *)@"dy_objc_observer");
    
    NSString *setterName = NSStringFromSelector(_cmd);
    NSString *key = getterForSetter(setterName);
    // 通知变化
    objc_msgSend(observer, @selector(observeValueForKeyPath:ofObject:change:context:), key, self, @{key: newValue}, nil);
    
}

Class dy_class(id self, SEL _cmd) {
    return class_getSuperclass(object_getClass(self));
}

#pragma mark - 从get方法获取set方法的名称 key ===>>> setKey:
static NSString  * setterForGetter(NSString *getter){
    
    if (getter.length <= 0) { return nil; }
    
    NSString *firstString = [[getter substringToIndex:1] uppercaseString];
    NSString *leaveString = [getter substringFromIndex:1];
    
    return [NSString stringWithFormat:@"set%@%@:",firstString,leaveString];
}

#pragma mark - 从set方法获取getter方法的名称 set<Key>:===> Key
static NSString * getterForSetter(NSString *setter){
    
    if (setter.length <= 0 || ![setter hasPrefix:@"set"] || ![setter hasSuffix:@":"]) { return nil;}
    
    NSRange range = NSMakeRange(3, setter.length-4);
    NSString *getter = [setter substringWithRange:range];
    NSString *firstString = [[getter substringToIndex:1] lowercaseString];
    getter = [getter stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstString];
    
    return getter;
}

@end
