//
//  ViewController.m
//  00_AFN
//
//  Created by yidai on 2020/9/17.
//  Copyright © 2020 yidai. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self get];
}

- (void)get {
//    NSString *urlStr = @"https://movie.douban.com/top250";
//    NSDictionary *params = @{
//        @"filter": @"",
//        @"start": @20
//    };
//    NSDictionary *headers = @{
//        @"Referer": @"https://book.douban.com/tag/%E5%B0%8F%E8%AF%B4",
//        @"User-Agent": @"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.94 Safari/537.36"
//    };
    NSString *urlStr = @"http://c.m.163.com/nc/article/headline/T1348647853363/0-40.html";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    manager.requestSerializer.timeoutInterval = 5;
    [manager GET:urlStr parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Success");
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failed");
        NSLog(@"%@", error.localizedDescription);
    }];
}


@end
