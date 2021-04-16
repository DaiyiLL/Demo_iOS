//
//  ViewController.m
//  003_ThreadPort
//
//  Created by Daiyi on 2021/4/15.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "DYPerson.h"

@interface ViewController () <NSMachPortDelegate>

@property (nonatomic, strong) NSPort *myPort;
@property (nonatomic, strong) DYPerson *person;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.person = [[DYPerson alloc] init];
    self.myPort = [NSMachPort port];
    self.myPort.delegate = self;
    [[NSRunLoop currentRunLoop] addPort:self.myPort forMode:NSDefaultRunLoopMode];
    [NSThread detachNewThreadSelector:@selector(personLaunchThreadWithPort:) toTarget:self.person withObject:self.myPort];
    
}


- (void)handlePortMessage:(id)message {
    NSLog(@"person:handlePortMessage  == %@",[NSThread currentThread]);
    NSLog(@"从person 传过来一些信息:");
    
    
    NSLog(@"components == %@", [message valueForKey:@"components"]);
    NSLog(@"receivePort == %@", [message valueForKey:@"receivePort"]);
    NSLog(@"sendPort == %@", [message valueForKey:@"sendPort"]);
    NSLog(@"msgid == %@", [message valueForKey:@"msgid"]);
    
    NSPort *receivePort = [message valueForKey:@"receivePort"];
    NSPort *sendPort = [message valueForKey:@"sendPort"];
    [[NSRunLoop currentRunLoop] addPort:sendPort forMode:NSDefaultRunLoopMode];
    
    NSData *data1 = [@"Hello world" dataUsingEncoding:NSUTF8StringEncoding];
    
    [sendPort sendBeforeDate:[NSDate date] msgid:10010 components:[@[data1] mutableCopy] from:self.myPort reserved:0];
}


@end
