//
//  ViewController.m
//  001_NetworkDemo
//
//  Created by Daiyi on 2021/4/21.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WKWebView *webview = [[WKWebView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [self.view addSubview:webview];
    
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com.cn/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@ ---- %@", response, data);
    }];
    [task resume];
    
}


@end
