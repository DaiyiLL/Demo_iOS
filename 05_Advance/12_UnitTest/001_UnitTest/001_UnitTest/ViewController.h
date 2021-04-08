//
//  ViewController.h
//  001_UnitTest
//
//  Created by Daiyi on 2021/4/7.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (int)getPlus: (int)num1 num2: (int)num2;
- (void)loadData: (void (^)(id data))dataBlock;

- (void)openCamera;


@end

