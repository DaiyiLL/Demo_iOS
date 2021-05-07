//
//  ViewController.m
//  002_GCDAsyncSocket
//
//  Created by Daiyi on 2021/4/22.
//

#import "ViewController.h"
#import <GCDAsyncSocket.h>

@interface ViewController ()<GCDAsyncSocketDelegate>
@property (weak, nonatomic) IBOutlet UITextField *sendMsgTF;
@property (nonatomic, strong) GCDAsyncSocket *socket;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)didClickConnectSocket:(id)sender {
    // 1: 创建socekt --id -->
    if (self.socket == nil) {
        self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
    }
    
    // 2: 连接socket
    if (!self.socket.isConnected) {
        NSError *error;
        BOOL result = [self.socket connectToHost:@"127.0.0.1" onPort:8090 error:&error];
        if (result == false || error != nil) {
            NSLog(@"连接错误");
        }
    }
}
- (IBAction)didClickSendAction:(id)sender {
    if (self.sendMsgTF.text.length == 0) {
        return;
    }
    NSData *data = [self.sendMsgTF.text dataUsingEncoding:NSUTF8StringEncoding];
    [self.socket writeData:data withTimeout:-1 tag:10086];
    
}
- (IBAction)didClickReconnectAction:(id)sender {
    // 1: 创建socekt --id -->
    if (self.socket == nil) {
        self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
    }
    
    // 2: 连接socket
    if (!self.socket.isConnected) {
        NSError *error;
        BOOL result = [self.socket connectToHost:@"127.0.0.1" onPort:8090 error:&error];
        if (result == false || error != nil) {
            NSLog(@"连接错误");
        }
    }
}

- (IBAction)didClickCloseAction:(id)sender {
    [self.socket disconnect];
    self.socket = nil;
}


#pragma mark - GCDAsyncSocketDelegate

//已经连接到服务器
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(nonnull NSString *)host port:(uint16_t)port{
    
    NSLog(@"连接成功 : %@---%d",host,port);
    
    [self.socket readDataWithTimeout:-1 tag:10086];
}

// 连接断开
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    NSLog(@"断开 socket连接 原因:%@",err);
}

//已经接收服务器返回来的数据
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSLog(@"接收到tag = %ld : %ld 长度的数据",tag,data.length);
   
    [self.socket readDataWithTimeout:-1 tag:10086];
}

//消息发送成功 代理函数 向服务器 发送消息
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    NSLog(@"%ld 发送数据成功",tag);
}


@end
