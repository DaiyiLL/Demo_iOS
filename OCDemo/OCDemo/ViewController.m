//
//  ViewController.m
//  OCDemo
//
//  Created by yidai on 2020/10/10.
//

#import "ViewController.h"
@import SocketIO;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    SocketManager *manager = [[SocketManager alloc] initWithSocketURL:[NSURL URLWithString:@""] config:nil];
}


@end
