//
//  ButtonView.h
//  04_MobileFrame
//
//  Created by Daiyi on 2021/2/9.
//

#import <UIKit/UIKit.h>
#import "SecondView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ButtonView : UIView

@property (nonatomic, strong) SecondView *secondView;

- (void)changeBtnFrame: (CGRect)frame backgroundImage: (UIImage *)image;

@end

NS_ASSUME_NONNULL_END
