//
//  LiteratorProtocol.h
//  11_LinkedListDemo
//
//  Created by Daiyi on 2021/3/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IteratorProtocol <NSObject>

// 下一个对象
- (id)nextObject;

// 充值迭代器指针
- (void)resetIterator;

@end

NS_ASSUME_NONNULL_END
