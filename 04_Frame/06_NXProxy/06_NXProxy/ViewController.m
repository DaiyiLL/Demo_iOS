//
//  ViewController.m
//  06_NXProxy
//
//  Created by Daiyi on 2021/2/22.
//

#import "ViewController.h"
#import "ContentProxy.h"

@interface ViewController () <MessagesProtocol>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ContentProxy *proxy = [ContentProxy alloc];
//    proxy.delegate = self;
    
    [proxy helloWorld];
}

- (void)helloWorld {
    NSLog(@"有消息处理");
}

@end
