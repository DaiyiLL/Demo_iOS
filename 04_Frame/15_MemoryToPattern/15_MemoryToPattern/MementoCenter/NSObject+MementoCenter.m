//
//  NSObject+MementoCenter.m
//  15_MemoryToPattern
//
//  Created by Daiyi on 2021/3/5.
//

#import "NSObject+MementoCenter.h"
#import "MemenToCenter.h"

@implementation NSObject (MementoCenter)

- (void)saveStateWithKey:(NSString *)key {
    id <MementoProtocol> obj = (id <MementoProtocol>)self;
    if ([obj respondsToSelector:@selector(currentState)]) {
        [MemenToCenter saveMementoObject:obj withKey:key];
    }
}

- (void)recoverStateForKey:(NSString *)key {
    id state = [MemenToCenter mementoObjForKey:key];
    
    id <MementoProtocol> obj = (id <MementoProtocol>)self;
    if ([obj respondsToSelector:@selector(recoverStateForKey:)]) {
        [obj recoverFromState:state];
    }
}

@end
