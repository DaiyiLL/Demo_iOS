//
//  LinkedIterator.m
//  11_LinkedListDemo
//
//  Created by Daiyi on 2021/3/1.
//

#import "LinkedIterator.h"

@interface LinkedIterator()

@property (nonatomic, strong) LinkedList *linkedList;
@property (nonatomic, strong) Node       *current;

@end

@implementation LinkedIterator

+ (instancetype)linkeObjectIterator:(LinkedList *)linkedList {
    // 1. 初始化迭代器
    LinkedIterator *linkedIterator = [[LinkedIterator alloc] init];
    // 2. 保存链表数据
    linkedIterator.linkedList = linkedList;
    linkedIterator.current = linkedList.headNode;
    
    return linkedIterator;
}

- (id)nextObject {
    self.current = self.current.nextNdoe;
    return self.current.data;
}

- (void)resetIterator {
    self.current = self.linkedList.headNode;
}

@end
