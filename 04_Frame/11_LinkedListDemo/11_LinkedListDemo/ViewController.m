//
//  ViewController.m
//  11_LinkedListDemo
//
//  Created by Daiyi on 2021/2/26.
//

#import "ViewController.h"
#import "LinkedList.h"
#import "LinkedIterator.h"
#import "TZView.h"

@interface ViewController ()

@property (nonatomic, strong) LinkedList *list;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 1. 数组集合
    NSArray *data = @[@"1", @"2", @"3", @"4"];
    
    // 2. 创建迭代器
    NSEnumerator *enumerator = [data objectEnumerator];
    
    // 3. 访问每一个元素
    id obj = nil;
    while (obj = [enumerator nextObject]) {
        NSLog(@"---%@", obj);
    }
    // 1. 创建集合类
    self.list = [[LinkedList alloc] init];
    [self.list addData:@"A"];
    [self.list addData:@"B"];
    [self.list addData:@"C"];
    
    // 2. 迭代器的创建
    LinkedIterator *linkedIterator = [LinkedIterator linkeObjectIterator:self.list];
    id obj2 = nil;
    while (obj2 = [linkedIterator nextObject]) {
        NSLog(@"=== %@", obj2);
    }
    
    TZView *tzView = [[TZView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    UIView *subView = nil;
    while (subView = [tzView nextObject]) {
        NSLog(@"subView = %@", subView);
    }
    
}


@end
