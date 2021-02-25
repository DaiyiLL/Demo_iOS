//
//  MacComputerProtocol.h
//  08_Builder_Mac
//
//  Created by Daiyi on 2021/2/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MacComputerProtocol <NSObject>

- (void)CPU:(nonnull NSString *)cpu;

- (void)Display:(nonnull NSString *)display;

- (void)Mainboard:(nonnull NSString *)mainboard;

- (void)SystemOS:(nonnull NSString *)os;

@end

NS_ASSUME_NONNULL_END
