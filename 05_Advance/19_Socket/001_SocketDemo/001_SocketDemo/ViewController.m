//
//  ViewController.m
//  001_SocketDemo
//
//  Created by Daiyi on 2021/4/22.
//

#import "ViewController.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>

//htons : 将一个无符号短整型的主机数值转换为网络字节顺序，不同cpu 是不同的顺序 (big-endian大尾顺序 , little-endian小尾顺序)
#define SocketPort htons(8040)
//inet_addr是一个计算机函数，功能是将一个点分十进制的IP转换成一个长整数型数
#define SocketIP   inet_addr("127.0.0.1")

@interface ViewController ()

@property (atomic, assign) int clinenId;
@property (weak, nonatomic) IBOutlet UITextField *sendMsgTF;
@property (weak, nonatomic) IBOutlet UITextView *allMsgTV;
@property (nonatomic, strong) NSMutableAttributedString *totalAttributeStr;
@property (nonatomic, copy) NSString *recoderTime;

@property (nonatomic, assign) int index;
@property (atomic, assign) BOOL isConnected;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.allMsgTV.editable = false;
    self.totalAttributeStr = [[NSMutableAttributedString alloc] init];
    self.clinenId = -1;
}
- (IBAction)scoketConnectAction:(id)sender {
    /**
     1: 创建socket
     参数
     domain：协议域，又称协议族（family）。常用的协议族有AF_INET、AF_INET6、AF_LOCAL（或称AF_UNIX，Unix域Socket）、AF_ROUTE等。协议族决定了socket的地址类型，在通信中必须采用对应的地址，如AF_INET决定了要用ipv4地址（32位的）与端口号（16位的）的组合、AF_UNIX决定了要用一个绝对路径名作为地址。
     type：指定Socket类型。常用的socket类型有SOCK_STREAM、SOCK_DGRAM、SOCK_RAW、SOCK_PACKET、SOCK_SEQPACKET等。流式Socket（SOCK_STREAM）是一种面向连接的Socket，针对于面向连接的TCP服务应用。数据报式Socket（SOCK_DGRAM）是一种无连接的Socket，对应于无连接的UDP服务应用。
     protocol：指定协议。常用协议有IPPROTO_TCP、IPPROTO_UDP、IPPROTO_STCP、IPPROTO_TIPC等，分别对应TCP传输协议、UDP传输协议、STCP传输协议、TIPC传输协议。
     注意：1.type和protocol不可以随意组合，如SOCK_STREAM不可以跟IPPROTO_UDP组合。当第三个参数为0时，会自动选择第二个参数类型对应的默认协议。
     返回值:
     如果调用成功就返回新创建的套接字的描述符，如果失败就返回INVALID_SOCKET（Linux下失败返回-1）
     */
    int socketId = socket(AF_INET, SOCK_STREAM, 0);
    if (socketId == -1) {
        NSLog(@"创建失败.......");
        return;
    }
    self.clinenId = socketId;
    /**
     __uint8_t    sin_len;          假如没有这个成员，其所占的一个字节被并入到sin_family成员中
     sa_family_t    sin_family;     一般来说AF_INET（地址族）PF_INET（协议族）
     in_port_t    sin_port;         // 端口
     struct    in_addr sin_addr;    // ip
     char        sin_zero[8];       没有实际意义,只是为了　跟SOCKADDR结构在内存中对齐
     */
    struct sockaddr_in socketAdd;
    socketAdd.sin_family = AF_INET;
    socketAdd.sin_port = SocketPort;
    struct in_addr socket_idAdd;
    socket_idAdd.s_addr = SocketIP;
    socketAdd.sin_addr = socket_idAdd;
    
    //
    /**
     参数
     参数一：套接字描述符
     参数二：指向数据结构sockaddr的指针，其中包括目的端口和IP地址
     参数三：参数二sockaddr的长度，可以通过sizeof（struct sockaddr）获得
     返回值
     成功则返回0，失败返回非0，错误码GetLastError()。
     */
    
    // 管子
    int result = connect(socketId, (const struct sockaddr *)&socketAdd, sizeof(socketAdd));
    if (result != 0) {
        NSLog(@"连接失败...");
        return;
    }
    // 接受消息
    NSLog(@"连接成功...");
    // 接受消息
    self.index = 0;
    self.isConnected = true;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self recvMsg];
    });
}
- (IBAction)sendMsgAction:(id)sender {
    if (self.sendMsgTF.text.length == 0) {
        NSLog(@"消息为空，无法发送");
        return;
    }
    const char *msg = self.sendMsgTF.text.UTF8String;
    // 监控发送数据长度
    ssize_t sendLen = send(self.clinenId, msg, strlen(msg), 0);
    [self showMsg:self.sendMsgTF.text msgType:0];
    NSLog(@"发送了 %ld 长度", sendLen);
    self.sendMsgTF.text = @"";
}

- (void)recvMsg {
    // 4. 接收数据
    /**
     参数
     1> 客户端socket
     2> 接收内容缓冲区地址
     3> 接收内容缓存区长度
     4> 接收方式，0表示阻塞，必须等待服务器返回数据
     
     返回值
     如果成功，则返回读入的字节数，失败则返回SOCKET_ERROR
     */
    while (self.clinenId != -1) {
        uint8_t buffer[1024];
        ssize_t recLen = recv(self.clinenId, buffer, sizeof(buffer), 0);
        NSLog(@"接受了%ld 字节", recLen);
        if (recLen == 0) {
            self.index ++;
            if (self.index > 5) {
                  
                return ;
            }
        }
        
        if (recLen > 0) {
            self.index = 0;
            NSData *data = [NSData dataWithBytes:buffer length:recLen];
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showMsg:str msgType:1];
            });
        }
    }
}

#pragma mark - 接收信息和发送信息格式处理
- (void)showMsg:(NSString *)msg msgType:(int)msgType{
    // 时间处理
    NSString *showTimeStr = [self getCurrentTime];
    if (showTimeStr) {
        NSMutableAttributedString *dateAttributedString = [[NSMutableAttributedString alloc] initWithString:showTimeStr];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        // 对齐方式
        paragraphStyle.alignment = NSTextAlignmentCenter;
        [dateAttributedString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor blackColor],NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, showTimeStr.length)];
        [self.totalAttributeStr appendAttributedString:dateAttributedString];
        [self.totalAttributeStr appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\n"]];
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.headIndent = 20.f;
    NSMutableAttributedString *attributedString;
    if (msgType == 0) { // 我发送的
        attributedString = [[NSMutableAttributedString alloc] initWithString:msg];

        paragraphStyle.alignment = NSTextAlignmentRight;
        [attributedString addAttributes:@{
                                          NSFontAttributeName:[UIFont systemFontOfSize:15],
                                          NSForegroundColorAttributeName:[UIColor whiteColor],
                                          NSBackgroundColorAttributeName:[UIColor blueColor],
                                          NSParagraphStyleAttributeName:paragraphStyle
                                          }
                                  range:NSMakeRange(0, msg.length)];
    }else{
        msg = [msg substringToIndex:msg.length-1];
        attributedString = [[NSMutableAttributedString alloc] initWithString:msg];

        [attributedString addAttributes:@{
                                          NSFontAttributeName:[UIFont systemFontOfSize:15],
                                          NSForegroundColorAttributeName:[UIColor blackColor],
                                          NSBackgroundColorAttributeName:[UIColor whiteColor],
                                          NSParagraphStyleAttributeName:paragraphStyle
                                          }
                                  range:NSMakeRange(0, msg.length)];
    }
    [self.totalAttributeStr appendAttributedString:attributedString];
    [self.totalAttributeStr appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\n"]];

    self.allMsgTV.attributedText = self.totalAttributeStr;
    if(self.totalAttributeStr.string.length > 0 ) {
        NSRange bottom = NSMakeRange(self.totalAttributeStr.string.length -1, 1);
        [self.allMsgTV scrollRangeToVisible:bottom];
    }
}

#pragma mark - 显示时间逻辑
- (NSString *)getCurrentTime{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *dateStr = [dateFormatter stringFromDate:date];
    if (!self.recoderTime || self.recoderTime.length == 0) {
        self.recoderTime = dateStr;
        return dateStr;
    }
    NSDate *recoderDate = [dateFormatter dateFromString:self.recoderTime];
    self.recoderTime = dateStr;
    NSTimeInterval timeInter = [date timeIntervalSinceDate:recoderDate];
    NSLog(@"%@--%@ -- %f",date,recoderDate,timeInter);
    if (timeInter<6) {
        return @" ";
    }
    return dateStr;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.clinenId > 0) {
        self.isConnected = false;
        close(self.clinenId);
        self.clinenId = -1;
    }
}

@end
