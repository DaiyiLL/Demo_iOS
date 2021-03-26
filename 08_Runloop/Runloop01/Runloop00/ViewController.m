//
//  ViewController.m
//  Runloop00
//
//  Created by Daiyi on 2021/3/25.
//

#import "ViewController.h"
#import "DYThread.h"

@interface ViewController () <NSPortDelegate>

@property (nonatomic, assign) BOOL stopping;
@property (nonatomic, strong) NSPort *subThreadPort;
@property (nonatomic, strong) NSPort *mainThreadPort;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mainThreadPort = [NSPort port];
    self.mainThreadPort.delegate = self;
    
    [[NSRunLoop currentRunLoop] addPort:self.mainThreadPort forMode:NSDefaultRunLoopMode];
    
    [self task];
}

- (void)task {
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        self.subThreadPort = [NSPort port];
        self.subThreadPort.delegate = self;
        
        [[NSRunLoop currentRunLoop] addPort:self.subThreadPort forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    }];
    [thread start];
}

- (void)handlePortMessage:(NSPortMessage *)message {
    NSLog(@"%s", __func__);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event


@end
