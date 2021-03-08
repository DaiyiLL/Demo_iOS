//
//  Invoker.m
//  16_CommandDemo
//
//  Created by Daiyi on 2021/3/7.
//

#import "Invoker.h"

@interface Invoker()

@property (nonatomic, strong) NSMutableArray <id <CommandProtocol>>*commandList;  // 存储操作

@end

@implementation Invoker

+ (instancetype)shared {
    static Invoker *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
        shareInstance.commandList = [NSMutableArray array];
    });
    return shareInstance;
}


- (void)goBack {
    // 1. 获取数组中的最后一个操作
    id <CommandProtocol>command = self.commandList.lastObject;
    if (command == nil) {
        return;
    }
    // 2. 操作调用，撤销的步骤
    [command gobackCommand];
    // 3. 删除最后的操作
    [self.commandList removeLastObject];
}

- (void)addAndExcute:(id<CommandProtocol>)command {
    // 1. 把操作添加到数组中
    [self.commandList addObject:command];
    // 2. 让操作调用实现的协议方法
    [command excuteCommand];
}

@end
