//
//  Node.m
//  11_LinkedListDemo
//
//  Created by Daiyi on 2021/2/26.
//

#import "Node.h"

@implementation Node

+ (instancetype)nodeData:(id)data {
    Node *node = [[self alloc] init];
    node.data = data;
    return node;
}

@end
