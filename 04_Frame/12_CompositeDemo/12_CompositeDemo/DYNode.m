//
//  DYNode.m
//  12_CompositeDemo
//
//  Created by Daiyi on 2021/3/2.
//

#import "DYNode.h"

@interface DYNode()

@end

@implementation DYNode

- (NSMutableArray<DYNode *> *)childNodes {
    if (!_childNodes) {
        _childNodes = [NSMutableArray arrayWithCapacity:10];
    }
    return _childNodes;
}

+ (instancetype)nodeWithData: (id)data {
    DYNode *node = [[self alloc] init];
    node.data = data;
    return node;
}

- (void)addNode:(DYNode *)node {
    [self.childNodes addObject:node];
}

- (void)removeNode:(DYNode *)node {
    [self.childNodes removeObject:node];
}

- (DYNode *)nodeAtIndex:(NSInteger)index {
    if (index >= self.childNodes.count) {
        return nil;
    }
    return self.childNodes[index];
}

- (void)logAllInfo {
    NSLog(@"data = %@", self.data);
}

- (NSString *)description {
    return [NSString stringWithFormat:@"node - %@", self.data];
}

@end
