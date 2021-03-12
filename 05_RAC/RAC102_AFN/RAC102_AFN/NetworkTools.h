//
//  NetworkTools.h
//  RAC102_AFN
//
//  Created by Daiyi on 2021/3/11.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkTools : AFHTTPSessionManager

+ (instancetype)shareTools;

- (void)request: (NSString *)urlString parameters: (id)parameters;

- (RACSignal *)racRequest: (NSString *)urlString parameters: (id)parameters;

@end

NS_ASSUME_NONNULL_END
