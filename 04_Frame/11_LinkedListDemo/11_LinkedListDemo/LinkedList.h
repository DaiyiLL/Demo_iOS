//
//  LinkedList.h
//  11_LinkedListDemo
//
//  Created by Daiyi on 2021/2/26.
//

#import <Foundation/Foundation.h>
#import "Node.h"

NS_ASSUME_NONNULL_BEGIN

@interface LinkedList : NSObject

/// 头结点
@property (nonatomic, strong) Node *headNode;

/// 节点数量
@property (nonatomic, assign) NSInteger size;

/// 添加节点
/// @param data 数据
- (void)addData: (id)data;

@end

NS_ASSUME_NONNULL_END
