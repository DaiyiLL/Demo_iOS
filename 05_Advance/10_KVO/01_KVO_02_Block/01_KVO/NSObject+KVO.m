//
//  NSObject+KVO.m
//  01_KVO
//
//  Created by Daiyi on 2021/3/29.
//

#import "NSObject+KVO.h"
//#import <objc/runtime.h>
#import <objc/message.h>

static const char * kDYKVOAssiociateKey = "dy_objc_info_list";
@interface DYKVOInfo : NSObject

@property (nonatomic,   weak) NSObject *observer;
@property (nonatomic, strong) NSString *keyPath;
@property (nonatomic,   copy) DYKVOBlock handler;

@end

@implementation DYKVOInfo

- (instancetype)initWithObserver: (NSObject *)observer keyPath: (NSString *)keyPath handler: (DYKVOBlock)handler
{
    self = [super init];
    if (self) {
        _observer = observer;
        _keyPath = [keyPath copy];
        _handler = handler;
    }
    return self;
}

@end


@implementation NSObject (KVO)


- (void)dy_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    
    DYKVOInfo *info = [[DYKVOInfo alloc] initWithObserver:observer keyPath:keyPath handler:nil];
    
    // 动态创建一个子类
    Class newClass = [self createClass: keyPath];
    
    // 修改了isa的指向
    object_setClass(self, newClass);
    
    // 关联方发
//    objc_setAssociatedObject(self, (__bridge void *)@"dy_objc_observer", observer, OBJC_ASSOCIATION_ASSIGN);
    // 信息保存
    NSMutableArray *array = objc_getAssociatedObject(self, kDYKVOAssiociateKey);
    if (!array) {
        array = [NSMutableArray array];
        objc_setAssociatedObject(self, kDYKVOAssiociateKey, array, OBJC_ASSOCIATION_RETAIN);
    }
    [array addObject:info];
    
}

- (void)dy_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context handler:(nonnull DYKVOBlock)handler {
    DYKVOInfo *info = [[DYKVOInfo alloc] initWithObserver:observer keyPath:keyPath handler:handler];
    
    // 动态创建一个子类
    Class newClass = [self createClass: keyPath];
    
    // 修改了isa的指向
    object_setClass(self, newClass);
    
    // 信息保存
    NSMutableArray *array = objc_getAssociatedObject(self, kDYKVOAssiociateKey);
    if (!array) {
        array = [NSMutableArray array];
        objc_setAssociatedObject(self, kDYKVOAssiociateKey, array, OBJC_ASSOCIATION_RETAIN);
    }
    [array addObject:info];
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
    // 从数组中移除self
    // 观察者
    NSMutableArray *list = objc_getAssociatedObject(self, kDYKVOAssiociateKey);
    
    // 通知变化
    if (list) {
        for (DYKVOInfo *info in list) {
            if (info.observer) {
                [list removeObject:info];
                break;
            }
            
        }
    }
   
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
    
    NSMutableArray *list = objc_getAssociatedObject(self, kDYKVOAssiociateKey);
    if (list) {
        for (DYKVOInfo *info in list) {
            if (info.observer == observer && [keyPath isEqual:info.keyPath]) {
                [list removeObject:info];
                break;
            }
            
        }
    }
}

// setter方法
#pragma mark - c 函数
static void dy_setter(id self, SEL _cmd, id newValue) {
    struct objc_super superStruct = {
        self,
        class_getSuperclass(object_getClass(self))
    };
    
    NSString *setterName = NSStringFromSelector(_cmd);
    NSString *keyPath = getterForSetter(setterName);
    id oldValue = [self valueForKeyPath:keyPath];

    // 改变父类的值
    objc_msgSendSuper(&superStruct, _cmd, newValue);
    
    // 通知观察者，值发生了变化
    // 观察者
    NSArray *list = objc_getAssociatedObject(self, kDYKVOAssiociateKey);
    
    
    // 通知变化
    if (list == nil) {
        return;
    }
    for (DYKVOInfo *info in list) {
        if (info.observer && [keyPath isEqualToString:info.keyPath]) {
            if (info.handler) {
                info.handler(info.observer, info.keyPath, oldValue, newValue);
            } else {
                objc_msgSend(info.observer, @selector(observeValueForKeyPath:ofObject:change:context:), keyPath, self, @{keyPath: newValue}, nil);
            }
        }
        
    }
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
