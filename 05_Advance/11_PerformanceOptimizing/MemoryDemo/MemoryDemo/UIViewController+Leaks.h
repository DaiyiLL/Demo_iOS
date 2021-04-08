//
//  UIViewController+Leaks.h
//  MemoryDemo
//
//  Created by Daiyi on 2021/4/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Leaks)

- (void) dy_viewWillAppear: (BOOL)animated;

- (void) dy_viewDidDisappear: (BOOL)animated;

@end

NS_ASSUME_NONNULL_END
