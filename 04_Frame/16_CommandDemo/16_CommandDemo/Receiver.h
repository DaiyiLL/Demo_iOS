//
//  Receiver.h
//  16_CommandDemo
//
//  Created by Daiyi on 2021/3/7.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Receiver : NSObject
/// 接收者的view
@property (nonatomic,   weak) UIView *receiverView;
// 变暗的接口
- (void)makeDart: (CGFloat)parameter;
// 变量的接口
- (void)makeLighter: (CGFloat)parameter;



@end

NS_ASSUME_NONNULL_END
