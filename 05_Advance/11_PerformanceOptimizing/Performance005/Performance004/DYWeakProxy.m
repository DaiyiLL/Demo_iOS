//
//  DYWeakProxy.m
//  Performance004
//
//  Created by Daiyi on 2021/4/2.
//

#import "DYWeakProxy.h"

@implementation DYWeakProxy

- (NSMethodSignature *) methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

- (void) forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}

@end
