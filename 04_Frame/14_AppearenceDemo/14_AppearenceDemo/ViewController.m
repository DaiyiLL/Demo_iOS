//
//  ViewController.m
//  14_AppearenceDemo
//
//  Created by Daiyi on 2021/3/4.
//

#import "ViewController.h"

#import "CarDriver.h"
#import "CoachDriver.h"

#import "Drive.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [CarDriver driveToLocation:@"遵义"];
    
    [CoachDriver driveToLocation:@"背景"];
}


@end
