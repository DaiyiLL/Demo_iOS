//
//  ViewController.m
//  13_GameDemo
//
//  Created by Daiyi on 2021/3/2.
//

#import "ViewController.h"
#import "Fangyu.h"
#import "Kuijia.h"
#import "Mokang.h"
#import "Person.h"

#import "Gongji.h"
#import "Wuqi.h"
#import "Mofa.h"
#import "Zhenshang.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 1. 创建人物
    Fangyu *person = [[Person alloc] init];
    
    // 2. 增加魔法盾牌
    Fangyu *mokang = [[Mokang alloc] init];
    mokang.nextHandler = person;
    
    // 3. 穿盔甲
    Fangyu *kuijia = [[Kuijia alloc] init];
    kuijia.nextHandler = mokang;
    
    
    // 1. 武器攻击
    Gongji *wuqi = [[Wuqi alloc] init];
    [kuijia handlerRequest:wuqi];
    
    // 2. 魔法攻击
    Gongji *mofa = [[Mofa alloc] init];
    [kuijia handlerRequest:mofa];
    
    // 3. 真伤攻击
    Gongji *zhenshang = [[Zhenshang alloc] init];
    [kuijia handlerRequest:zhenshang];
}


@end
