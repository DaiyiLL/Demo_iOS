//
//  DYPerson.m
//  003_ThreadPort
//
//  Created by Daiyi on 2021/4/15.
//

#import "DYPerson.h"
#import <objc/runtime.h>

@interface DYPerson()<NSMachPortDelegate>

@property (nonatomic, strong) NSPort *vcPort;
@property (nonatomic, strong) NSPort *myPort;

@end

@implementation DYPerson

- (void)personLaunchThreadWithPort:(NSPort *)port {
    NSLog(@"VC 响应了Person里面");
    
    @autoreleasepool {
        self.vcPort = port;
        
        [[NSRunLoop currentRunLoop] run];
        self.myPort = [NSMachPort port];
        self.myPort.delegate = self;
        
        [[NSRunLoop currentRunLoop] addPort:self.myPort forMode:NSDefaultRunLoopMode];
        
        [self sendPortMessage];
    }
}

- (void)sendPortMessage {
    NSData *data = [@"玫瑰小镇" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *data1 = [@"玫瑰小镇11" dataUsingEncoding:NSUTF8StringEncoding];
    [self.vcPort sendBeforeDate:[NSDate date] msgid:10086 components:[@[data, data1] mutableCopy] from:self.myPort reserved:0];
}

- (void)handlePortMessage:(id)message {
    NSLog(@"person:handlePortMessage  == %@",[NSThread currentThread]);
    NSLog(@"从VC 传过来一些信息:");
    
    NSLog(@"components == %@", [message valueForKey:@"components"]);
    NSLog(@"receivePort == %@", [message valueForKey:@"receivePort"]);
    NSLog(@"sendPort == %@", [message valueForKey:@"sendPort"]);
    NSLog(@"msgid == %@", [message valueForKey:@"msgid"]);
}

//- (void)handleMachMessage:(void *)msg {
//    NSLog(@"person:handlePortMessage  == %@",[NSThread currentThread]);
//    NSLog(@"从VC 传过来一些信息:");
////    NSLog(@"components == %@", [message valueForKey:@"components"]);
////    NSLog(@"receivePort == %@", [message valueForKey:@"receivePort"]);
////    NSLog(@"sendPort == %@", [message valueForKey:@"sendPort"]);
////    NSLog(@"msgid == %@", [message valueForKey:@"msgid"]);
//}


@end
