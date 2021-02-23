//
//  AbstractProxy.h
//  06_NXProxy
//
//  Created by Daiyi on 2021/2/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AbstractProxy : NSProxy

@property (nonatomic,   weak) id delegate;

@end

NS_ASSUME_NONNULL_END
