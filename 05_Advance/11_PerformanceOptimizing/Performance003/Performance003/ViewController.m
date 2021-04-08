//
//  ViewController.m
//  Performance003
//
//  Created by Daiyi on 2021/3/31.
//

#import "ViewController.h"
#import "DYPerson.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DYPerson *person = [DYPerson new];
    NSLog(@"%d,  %d", [person isFront], [person isBack]);
    
    [person setFront:true];
    NSLog(@"%d,  %d", [person isFront], [person isBack]);
    
    [person setFront:true];
    [person setBack:false];
    NSLog(@"%d,  %d", [person isFront], [person isBack]);
}


@end
