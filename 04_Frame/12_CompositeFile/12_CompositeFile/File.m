//
//  File.m
//  12_CompositeFile
//
//  Created by Daiyi on 2021/3/3.
//

#import "File.h"

@implementation File

- (instancetype)init
{
    self = [super init];
    if (self) {
        _childFiles = [NSMutableArray arrayWithCapacity:20];
    }
    return self;
}

+ (instancetype)fileWithType:(EFile)fileType name:(NSString *)fileName {
    File *file = [[self alloc] init];
    file.fileType = fileType;
    file.name = fileName;
    return file;
}

- (void)addFile:(File *)file {
    [_childFiles addObject:file];
}

- (void)removeFile:(File *)file {
    [_childFiles removeObject:file];
}



@end
