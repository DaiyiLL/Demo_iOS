//
//  ViewController.m
//  09_BuilderView
//
//  Created by Daiyi on 2021/2/25.
//

#import "ViewController.h"
#import "DrawSubBuilder.h"
#import "DrawSubBuilderTwo.h"
#import "Director.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (IBAction)btnClick:(id)sender {
    // 创建者
//    DrawBuilder *builder = [[DrawSubBuilder alloc] init];
    DrawBuilder *builder = [[DrawSubBuilderTwo alloc] init];
    // 组装
    DrawView *drawView = [Director createView:builder];
    drawView.center = self.view.center;
    
    [self.view addSubview:drawView];
}



@end
