//
//  MemenToCenter.m
//  15_MemoryToPattern
//
//  Created by Daiyi on 2021/3/4.
//

#import "MemenToCenter.h"
#import "FastCoder.h"

@implementation MemenToCenter

/// 存对象的状态
+ (void)saveMementoObject: (id<MementoProtocol>)obj withKey: (NSString *)key {
    id data = [obj currentState];
    // 转化data
    NSData *tmpData = [FastCoder dataWithRootObject:data];
    if (tmpData) {
        [[NSUserDefaults standardUserDefaults] setObject:tmpData forKey:key];
    }
}

/// 取出对象
+ (id)mementoObjForKey: (NSString *)key {
    id data = nil;
    NSData *tmpData = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (tmpData) {
        // 解码
        data = [FastCoder objectWithData:tmpData];
    }
    return data;
}

@end
