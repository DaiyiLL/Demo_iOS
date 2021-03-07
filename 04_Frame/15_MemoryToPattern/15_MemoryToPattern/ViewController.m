//
//  ViewController.m
//  15_MemoryToPattern
//
//  Created by Daiyi on 2021/3/4.
//

#import "ViewController.h"
#import "MemenToCenter.h"
#import "Apple.h"

#import "NSObject+MementoCenter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    Apple *apple = [[Apple alloc] init];
//    apple.name = @"富士苹果";
//    apple.age = 10;
//    apple.size = 20;
    
//    [apple saveStateWithKey:@"apple1"];
    // 存储
//    [MemenToCenter saveMementoObject:apple withKey:@"apple"];
    
    Apple *app = [[Apple alloc] init];
//    // 取
//    [app recoverFromState:[MemenToCenter mementoObjForKey:@"apple"]];
    [app recoverStateForKey:@"apple1"];
    NSLog(@"%@ - %d - %f", app.name, app.age, app.size);
    
}


@end
