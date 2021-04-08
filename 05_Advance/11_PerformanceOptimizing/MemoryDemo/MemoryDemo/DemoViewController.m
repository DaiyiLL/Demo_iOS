//
//  DemoViewController.m
//  MemoryDemo
//
//  Created by Daiyi on 2021/4/5.
//

#import "DemoViewController.h"

typedef void (^Block)(void);

@interface DemoViewController ()

@property (nonatomic, copy) Block block;
@property (nonatomic, strong) NSString* name;

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.block = ^{
        self.name = @"Tom";
    };
}

- (void)dealloc {
    NSLog(@"DemoViewController dealloc");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
