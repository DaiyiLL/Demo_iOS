//
//  ViewController.m
//  10_AbstractMediator
//
//  Created by Daiyi on 2021/2/26.
//

#import "ViewController.h"
#import "TypeOneMediator.h"
#import "Colleague.h"

@interface ViewController ()

@property (nonatomic, strong) TypeOneMediator *mediator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mediator = [TypeOneMediator new];
    Colleague *colleagueA = [[Colleague alloc] init];
    Colleague *colleagueB = [[Colleague alloc] init];
    Colleague *colleagueC = [[Colleague alloc] init];
    
    
    self.mediator.colleagueA = colleagueA;
    self.mediator.colleagueB = colleagueB;
    self.mediator.colleagueC = colleagueC;
    
    colleagueA.delegate = self.mediator;
    colleagueB.delegate = self.mediator;
    colleagueC.delegate = self.mediator;
    [colleagueA changeValue:2.f];
    [colleagueB changeValue:30.f];
    NSLog(@"%@", [self.mediator values]);
}


@end
