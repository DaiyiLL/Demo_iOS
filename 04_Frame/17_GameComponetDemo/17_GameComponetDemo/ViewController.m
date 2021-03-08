//
//  ViewController.m
//  17_GameComponetDemo
//
//  Created by Daiyi on 2021/3/8.
//

#import "ViewController.h"
#import "GameDecortor.h"
#import "GameLol.h"

#import "CheatGameDecortor.h"
#import "GameLol+Cheat.h"
#import "GameLol+Coin.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    GameLol *lol = [[GameLol alloc] init];
    GameDecortor *decortor = [[GameDecortor alloc] initWithGame:lol];
//    [decortor up];
//    [decortor down];
//
//    CheatGameDecortor *cheat = [[CheatGameDecortor alloc] initWithGame:lol];
//    [cheat cheat];
    
    [lol cheat];
    lol.coin = 10;
    NSLog(@"%ld", (long)lol.coin);
    
}


@end
