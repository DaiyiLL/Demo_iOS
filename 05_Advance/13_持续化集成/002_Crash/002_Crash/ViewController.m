//
//  ViewController.m
//  002_Crash
//
//  Created by Daiyi on 2021/4/8.
//

#import "ViewController.h"
#import <signal.h>
#import "Person.h"

@interface ViewController ()


@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSDictionary *dataDict;
@property (nonatomic, copy) NSString *dataStr;
@property (nonatomic, strong) Person *person;

@end

@implementation ViewController

void dyUncaughtException (NSException *exc) {
//    NSLog(@"*****");
    NSString *excName = [exc name];
    NSString *excReason = [exc reason];
    NSArray *excArray = [exc callStackSymbols];
    
    NSString *crashLog = [NSString stringWithFormat:@"\n错误名字: %@\n错误原因: %@\n错误信息: %@", excName, excReason, excArray];
    NSLog(@"%@", crashLog);
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArray = @[@"天王盖地虎", @"宝塔镇河妖"];
    self.dataDict = @{@"name": @"Dsy", @"age": @28};
    self.dataStr = @"Crash分析";
    self.person = [[Person alloc] init];
    
//    NSSetUncaughtExceptionHandler(&dyUncaughtException);
    
    
//    NSString *test1 = self.dataArray[2];
}
- (IBAction)testArrayBtnClicked:(id)sender {
    NSLog(@"************************************");
    
    NSLog(@"%@",self.dataArray[6]);
}
- (IBAction)testDictBtnClicked:(id)sender {
    
    NSLog(@"************************************");
    
    [self.dataDict[@"age"] isEqualToString:@"18"];
}

- (IBAction)testStrBtnClicked:(id)sender {
    NSLog(@"************************************");
    
    NSLog(@"%@",[self.dataStr substringToIndex:66]);
}


@end
