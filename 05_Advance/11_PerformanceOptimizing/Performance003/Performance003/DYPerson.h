//
//  DYPerson.h
//  Performance003
//
//  Created by Daiyi on 2021/3/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DYPerson : NSObject

- (void) setFront: (BOOL)isFront;
- (BOOL) isFront;

- (void) setBack: (BOOL)isBack;
- (BOOL) isBack;

- (void) setLeft: (BOOL)isLeft;
- (BOOL) isLeft;

- (void) setRight: (BOOL)isRight;
- (BOOL) isRight;

@end

NS_ASSUME_NONNULL_END
