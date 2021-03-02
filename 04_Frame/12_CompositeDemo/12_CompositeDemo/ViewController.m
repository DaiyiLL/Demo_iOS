//
//  ViewController.m
//  12_CompositeDemo
//
//  Created by Daiyi on 2021/3/2.
//

#import "ViewController.h"
#import "Node.h"
#import "DYNode.h"

@interface ViewController ()

@property (nonatomic, strong) Node *rootNode;
@property (nonatomic, strong) DYNode *root;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 创建根节点
    self.root = [DYNode nodeWithData:@"A"];
    // 创建其他子节点
    DYNode *cNode = [DYNode nodeWithData:@"C"];
    [self.root addNode:[DYNode nodeWithData:@"B"]];
    [self.root addNode:cNode];
    [self.root addNode:[DYNode nodeWithData:@"D"]];
    
    [cNode addNode:[DYNode nodeWithData:@"E"]];
    [cNode addNode:[DYNode nodeWithData:@"F"]];
    
    NSLog(@"%@", cNode.childNodes);
    NSLog(@"---%@", self.root.childNodes);
}

- (void)test01 {
    _rootNode = [[Node alloc] initWithData:@"A"];
    // 插入节点
    [self insertNodeTree:_rootNode data:@"B"];
    [self insertNodeTree:_rootNode data:@"C"];
    [self insertNodeTree:_rootNode data:@"D"];
    [self insertNodeTree:_rootNode data:@"E"];
    [self insertNodeTree:_rootNode data:@"F"];
    
    [self traverseNode:_rootNode];
}

// 往根节点插入节点
- (void)insertNodeTree: (Node *)tree data: (id)data {
    // 左边
    if (tree.leftNode == nil) {
        Node *node = [[Node alloc] initWithData:data];
        tree.leftNode = node;
        return;
    }
    // 右边
    if (tree.rightNode == nil) {
        Node *node = [[Node alloc] initWithData:data];
        tree.rightNode = node;
        return;
    }
    [self insertNodeTree:tree.leftNode data:data];
}

- (void)traverseNode: (Node *)node {
    if (node.leftNode) {
        [self traverseNode:node.leftNode];
    }
    NSLog(@"%@", node.data);
    if (node.rightNode) {
        [self traverseNode:node.rightNode];
    }
//    NSLog(@"%@", node.data);
}


@end
