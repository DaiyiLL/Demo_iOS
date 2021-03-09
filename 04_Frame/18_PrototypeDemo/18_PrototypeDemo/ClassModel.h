//
//  ClassModel.h
//  18_PrototypeDemo
//
//  Created by Daiyi on 2021/3/9.
//

#import <Foundation/Foundation.h>
#import "BaseCopyObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface ClassModel : BaseCopyObject

@property (nonatomic,   copy) NSString *className;
@property (nonatomic, strong) NSArray  *students;

@end

NS_ASSUME_NONNULL_END
