//
//  LinkedList.m
//  11_LinkedListDemo
//
//  Created by Daiyi on 2021/2/26.
//

#import "LinkedList.h"

@interface LinkedList()

@end

@implementation LinkedList

- (Node *)headNode {
    if (!_headNode) {
        _headNode = [[Node alloc] init];
    }
    return _headNode;
}

- (void)addData:(id)data {
    Node *node = [Node nodeData:data];
//    if (self.headNode == nil) {
//        // 1. 头节点为空, 添加
//        self.headNode = node;
//    } else {
//        // 2. 有头结点，找到尾结点，添加
//        [self addNode: node forNode:self.headNode];
//    }
    // 2. 有头结点，找到尾结点，添加
    [self addNode: node forNode:self.headNode];
    self.size += 1;
}

- (void)addNode: (Node *)node forNode: (Node *)lastNode {
    if (lastNode.nextNdoe == nil) {
        lastNode.nextNdoe = node;
    } else {
        while (lastNode.nextNdoe != nil) {
            lastNode = lastNode.nextNdoe;
        }
        lastNode.nextNdoe = node;
    }
}

@end
