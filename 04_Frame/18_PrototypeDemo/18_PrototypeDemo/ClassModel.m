//
//  ClassModel.m
//  18_PrototypeDemo
//
//  Created by Daiyi on 2021/3/9.
//

#import "ClassModel.h"

@implementation ClassModel

- (void)copyOperationForObject:(id)object {
    ClassModel *obj = (ClassModel *)object;
    obj.className = self.className;
    obj.students = [[NSArray alloc] initWithArray:self.students copyItems:true];
}

@end
