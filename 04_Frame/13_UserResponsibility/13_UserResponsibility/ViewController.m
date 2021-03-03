//
//  ViewController.m
//  13_UserResponsibility
//
//  Created by Daiyi on 2021/3/3.
//

#import "ViewController.h"
#import <RegExCategories/RegExCategories.h>

#import "HandlerChain.h"
#import "PhoneNumCheck.h"
#import "EmailCheck.h"
#import "UserNameCheck.h"
/**
   正则表达式 [string isMatch:RX(rxSrtring)]

   1. 判断是不是电话号码(手机号以13， 15，18开头，八个 \d 数字字符)
   RX(@"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$")
 
   2. 判断是不是邮箱
   RX(@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}")
 
   3. 判断是不是用户名(用户名长度为6-20位之间,大小写字母或者数字均可)
   RX(@"^[A-Za-z0-9]{6,20}+$")
 
 */

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    BOOL isMathch = [@"18721938339" isMatch:RX(@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}")];
//    NSLog(@"%d", isMathch);
    
    // 1. 创建责任链
    HandlerChain *handler = [[HandlerChain alloc] init];
    UserNameCheck *username = [[UserNameCheck alloc] init];
    PhoneNumCheck *phone = [[PhoneNumCheck alloc] init];
    EmailCheck *email = [[EmailCheck alloc] init];
    
    // 2. 链接责任链对象
    handler.successor = phone;
    phone.successor = email;
    email.successor = username;
    
    // 3. 处理请求
    [handler handlerRequest:@"18721938339"];
    [handler handlerRequest:@"18721938339@163.com"];
    [handler handlerRequest:@"DaiyiLL"];
}


@end
