//
//  TestViewController.m
//  01_KVO
//
//  Created by Daiyi on 2021/3/29.
//

#import "TestViewController.h"
#import "DYPerson.h"
#import <objc/runtime.h>

@interface TestViewController ()

@property (nonatomic, strong) DYPerson *person;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    _person = [DYPerson new];
    
    Class class1 = NSClassFromString(@"NSKVONotifying_DYPerson");
    if (class1) {
        NSLog(@"exist NSKVONotifying_DYPerson");
    } else {
        NSLog(@"not exist NSKVONotifying_DYPerson");
    }
    // 添加观察者
    [_person addObserver:self forKeyPath:@"steps" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionPrior) context:"hello"];
    
    Class class = NSClassFromString(@"NSKVONotifying_DYPerson");
    if (class) {
        NSLog(@"exist NSKVONotifying_DYPerson");
        [self printMethods:class];
    } else {
        NSLog(@"not exist NSKVONotifying_DYPerson");
    }
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@", change);
    NSLog(@"context = %s", context);
}


- (void)dealloc {
    NSLog(@"dealloc normally");
    [_person removeObserver:self forKeyPath:@"steps"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 手动通知
//    _person.steps ++;
//    [_person setSteps:10];
    
    _person.steps ++;
    
}

- (void)printMethods: (Class)cls {
    unsigned int count = 0;
    Method *methods = class_copyMethodList(cls, &count);
    NSMutableArray *list = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        Method method = methods[i];
        SEL sel = method_getName(method);
        IMP imp = method_getImplementation(method);
        NSString *methodName = NSStringFromSelector(sel);
        [list addObject:methodName];
    }
    
    NSLog(@"%@", list);
    
    
    
    free(methods);
}

/**
 NSKeyValueWillChange
 [DYPerson setSteps:]
 NSKeyValueDidChange
 NSKeyValueNotifyObserver
 
 通知观察者
 - (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
     NSLog(@"%@", change);
     NSLog(@"context = %s", context);
 }
 */

@end
