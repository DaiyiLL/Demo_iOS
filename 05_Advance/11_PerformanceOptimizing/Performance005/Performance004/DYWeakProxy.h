//
//  DYWeakProxy.h
//  Performance004
//
//  Created by Daiyi on 2021/4/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DYWeakProxy : NSProxy

@property (nonatomic,   weak) id target;

@end

NS_ASSUME_NONNULL_END
