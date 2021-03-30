//
//  DYPerson.m
//  03_KVCDict
//
//  Created by Daiyi on 2021/3/28.
//

#import "DYPerson.h"

@implementation DYPerson

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"key == %@ 不存在", key);
}

- (NSUInteger) countOfBooks {
    return self.count;
}

- (id)objectInBooksAtIndex: (NSUInteger)index {
    return [NSString stringWithFormat:@"book %lu", index];
}


// 个数
- (NSUInteger) countOfPens {
    return [self.penArr count];
}

// 是否包含这个成员对象
- (id)memberOfPens: (id)object {
    return [self.penArr containsObject:object] ? object : nil;
}

// 迭代器
- (id) enumeratorOfPens {
//    return [self.penArr reverseObjectEnumerator];
    return [self.penArr objectEnumerator];
}

@end
