//
//  File.h
//  12_CompositeFile
//
//  Created by Daiyi on 2021/3/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    kFile,
    kFolder
} EFile;

@interface File : NSObject

// 文件夹或者文件名
@property (nonatomic,   copy) NSString *name;
@property (nonatomic, assign) EFile fileType;
@property (nonatomic, strong) NSMutableArray<File *> *childFiles;

- (void)addFile: (File *)file;
- (void)removeFile: (File *)file;

+ (instancetype)fileWithType: (EFile)fileType name: (NSString *)fileName;

@end

NS_ASSUME_NONNULL_END
