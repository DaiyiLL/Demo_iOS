//
//  ViewController.m
//  07_BuildOne
//
//  Created by Daiyi on 2021/2/24.
//

#import "ViewController.h"
#import "Director.h"
#import "ConcreateBuilder.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 1，创建生成者，知道要做的产品
    ConcreateBuilder *builder = [[ConcreateBuilder alloc] init];
    // 2. 创建承包商(制造者)
    Director *director = [[Director alloc] initWithBuilder:builder];
    // 3. 交付产品
    NSLog(@"%@", [director construct]);
}


@end
