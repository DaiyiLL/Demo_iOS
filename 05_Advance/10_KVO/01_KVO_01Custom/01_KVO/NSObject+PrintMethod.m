//
//  NSObject+PrintMethod.m
//  01_KVO
//
//  Created by Daiyi on 2021/3/29.
//

#import "NSObject+PrintMethod.h"
#import <objc/runtime.h>

@implementation NSObject (PrintMethod)

/// 打印对应的类及子类
+ (void) printClasses:(Class) cls {
    
    /// 注册类的总数
    int count = objc_getClassList(NULL, 0);
    
    /// 创建一个数组， 其中包含给定对象
    NSMutableArray* array = [NSMutableArray arrayWithObject:cls];
    
    /// 获取所有已注册的类
    Class* classes = (Class*)malloc(sizeof(Class)*count);
    objc_getClassList(classes, count);
    
    /// 遍历s
    for (int i = 0; i < count; i++) {
        if (cls == class_getSuperclass(classes[i])) {
            [array addObject:classes[i]];
        }
    }
    
    free(classes);
    
    NSLog(@"classes = %@", array);
}

@end
