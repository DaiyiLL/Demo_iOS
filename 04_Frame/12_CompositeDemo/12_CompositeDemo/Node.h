//
//  Node.h
//  12_CompositeDemo
//
//  Created by Daiyi on 2021/3/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Node : NSObject

// 当前节点的名字
@property (nonatomic,   copy) NSString *nodeName;

@property (nonatomic, strong) Node *leftNode;
@property (nonatomic, strong) Node *rightNode;

@property (nonatomic, strong) id data;

// 初始化
- (instancetype)initWithData: (id)data;

@end

NS_ASSUME_NONNULL_END
