//
//  TZView.m
//  11_LinkedListDemo
//
//  Created by Daiyi on 2021/3/1.
//

#import "TZView.h"
#import "LinkedList.h"

@interface TZView ()

@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UILabel *lable;
@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) LinkedList *linkedList;
@property (nonatomic, strong) Node       *current;

@end

@implementation TZView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn.frame = self.bounds;
        self.lable = [[UILabel alloc] initWithFrame:self.bounds];
        self.textField = [[UITextField alloc] initWithFrame:self.bounds];
        
        [self addSubview:self.btn];
        [self addSubview:self.lable];
        [self addSubview:self.textField];
        
        self.linkedList = [[LinkedList alloc] init];
        [self.linkedList addData:self.btn];
        [self.linkedList addData:self.lable];
        [self.linkedList addData:self.textField];
        self.current = self.linkedList.headNode;
    }
    return self;
}


- (id)nextObject {
    self.current = self.current.nextNdoe;
    return self.current.data;
}

- (void)resetIterator {
    self.current = self.linkedList.headNode;
}


@end
