//
//  ViewController.m
//  08_Builder_Mac
//
//  Created by Daiyi on 2021/2/24.
//

#import "ViewController.h"
#import "Director.h"
#import "MacComputerBuilder.h"
/*
 使用构建者模式的需求: 客户要店主一台电脑，电脑有CPU，显卡，主板，系统
 组装者(指导者): 店主(Director)
 构建者: 苹果电脑 (协议)
 生成者: CPU,显卡，主板，系统
 */
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 第一种构建方式
//    id<MacBuilder>build = [[MacComputerBuilder alloc] init];
//    // 构建者
//    Director *director = [[Director alloc] initWithBuilder:build];
//    [director constructCPU:@"Intel i8" display:@"独立显卡" mainboard:@"超级主板" os:@"Mac OS Big sur"];
    
    // 第二种方式
    id<MacBuilder>build = [[MacComputerBuilder alloc] init];
    id<MacComputerProtocol> com = [[[[build buildCPU:@"Intel i8"] buildDisplay:@"独立显卡"] buildMainboard:@"超级主板"] buildSystemOS:@"Mac Big sur"];
    NSLog(@"com = %@", com);
}


@end
