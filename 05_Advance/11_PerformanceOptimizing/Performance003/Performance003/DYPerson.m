//
//  DYPerson.m
//  Performance003
//
//  Created by Daiyi on 2021/3/31.
//

#import "DYPerson.h"

#define kDirectionFrontMask (1 << 0)
#define kDirectionBackMask  (1 << 1)
#define kDirectionLeftMask  (1 << 2)
#define kDirectionRightMask (1 << 3)
 
@interface DYPerson() {
    union {
        //
        char bits; // 0b 0011 1111 // 00 bottom up right left back front
        // struct 与bits同占一个内存，但是下结构体只是bit的后面6位，前面两位为0
        struct {
            char front : 1;
            char back : 1;
            char left : 1;
            char right : 1;
            char up: 1;
            char bottom: 1;
        };
    } _direction;
}

@end

@implementation DYPerson

- (instancetype)init
{
    self = [super init];
    if (self) {
        _direction.bits = 0b00000000;
    }
    return self;
}


- (void) setFront: (BOOL)isFront {
//    if (isFront) {
//        _direction.bits |= kDirectionFrontMask;
//    } else {
//        _direction.bits &= ~kDirectionFrontMask;
//    }
    _direction.front = isFront;
}
- (BOOL) isFront {
//    return _direction.bits & kDirectionFrontMask;
    return _direction.front;
}

- (void) setBack: (BOOL)isBack {
//    if (isBack) {
//        _direction.bits |= kDirectionBackMask;
//    } else {
//        _direction.bits &= ~kDirectionBackMask;
//    }
    _direction.back = isBack;
}
- (BOOL) isBack {
//    return _direction.bits & kDirectionBackMask;
    return _direction.back;
}

- (void) setLeft:(BOOL)isLeft {
    if (isLeft) {
        _direction.bits |= kDirectionLeftMask;
    } else {
        _direction.bits &= ~kDirectionLeftMask;
    }
}

- (BOOL)isLeft {
    return _direction.bits & kDirectionLeftMask;
}

- (void)setRight:(BOOL)isRight {
    if (isRight) {
        _direction.bits |= kDirectionRightMask;
    } else {
        _direction.bits &= ~kDirectionRightMask;
    }
}

- (BOOL)isRight {
    return _direction.bits & kDirectionRightMask;
}

@end
