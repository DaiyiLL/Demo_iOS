//
//  ViewController.m
//  14_GameDemo
//
//  Created by Daiyi on 2021/3/3.
//

#import "ViewController.h"
#import "FootBall.h"
#import "BasketBall.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Game *footballGame = [[FootBall alloc] initGame];
    Game *basketballGame = [[BasketBall alloc] initGame];
    
    [footballGame startPlay];
    [footballGame pauseGame];
    [footballGame saveGame];
    [footballGame exitGame];
    
    [basketballGame startPlay];
    [basketballGame pauseGame];
    [basketballGame saveGame];
    [basketballGame exitGame];
    
}


@end
