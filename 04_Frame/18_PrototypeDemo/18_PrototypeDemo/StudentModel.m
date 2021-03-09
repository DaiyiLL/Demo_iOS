//
//  StudentModel.m
//  18_PrototypeDemo
//
//  Created by Daiyi on 2021/3/8.
//

#import "StudentModel.h"

@implementation StudentModel

- (id)clone {
    StudentModel *stu = [[[self class] alloc] init];
    stu.name = self.name;
    stu.age = self.age;
    stu.address = self.address;
    stu.totalScore = self.totalScore;
    return stu;
}

- (void)copyOperationForObject:(id)object {
    StudentModel *stu = (StudentModel *)object;
    stu.name = self.name;
    stu.age = self.age;
    stu.address = self.address;
    stu.totalScore = self.totalScore;
}

@end
