//
//  DYNode.h
//  12_CompositeDemo
//
//  Created by Daiyi on 2021/3/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DYNode : NSObject

@property (nonatomic, strong) id data;
@property (nonatomic, strong) NSMutableArray<DYNode *> *childNodes;

+ (instancetype)nodeWithData: (id)data;

// 添加子节点
- (void)addNode:(DYNode *)node;

// 删除子节点
- (void)removeNode:(DYNode *)node;

- (DYNode *)nodeAtIndex: (NSInteger)index;

// 打印
- (void)logAllInfo;

@end

NS_ASSUME_NONNULL_END
