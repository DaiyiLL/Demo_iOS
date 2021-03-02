//
//  LinkedIterator.h
//  11_LinkedListDemo
//
//  Created by Daiyi on 2021/3/1.
//

#import <Foundation/Foundation.h>
#import "LinkedList.h"
#import "IteratorProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface LinkedIterator : NSObject <IteratorProtocol>

+ (instancetype)linkeObjectIterator: (LinkedList *)linkedList;

@end

NS_ASSUME_NONNULL_END
