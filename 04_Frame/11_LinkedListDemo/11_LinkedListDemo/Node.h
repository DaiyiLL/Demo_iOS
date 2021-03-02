//
//  Node.h
//  11_LinkedListDemo
//
//  Created by Daiyi on 2021/2/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Node : NSObject

// 指向下一个节点(链表中的指针)
@property (nonatomic, strong) id data;
// 指向下一个节点(链表中的指针)
@property (nonatomic, strong) Node *nextNdoe;

// 节点数据
+ (instancetype)nodeData: (id)data;

@end

NS_ASSUME_NONNULL_END
