//
//  NSObject+KVC.h
//  02_KVC00
//
//  Created by Daiyi on 2021/3/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KVC)

- (void)dy_setValue:(id)value forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
