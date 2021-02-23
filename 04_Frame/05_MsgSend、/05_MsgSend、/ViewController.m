//
//  ViewController.m
//  05_MsgSend、
//
//  Created by Daiyi on 2021/2/21.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Person *per = [Person new];
    Person *p = [Person new];
    p.name = @"代书义";
//    [per run:p];
    [per run];
    
}


@end
