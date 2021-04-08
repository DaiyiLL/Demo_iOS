//
//  TimerWraper.h
//  Performance004
//
//  Created by Daiyi on 2021/4/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimerWraper : NSObject

- (instancetype)initWithTmerInterval:(NSTimeInterval)interval target: (id)target selector: (SEL)selector;

- (void)stop;

@end

NS_ASSUME_NONNULL_END
