//
//  FileViewController.h
//  文件组合
//
//  Created by James on 2017/12/18.
//  Copyright © 2017年 TZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "File.h"

@interface FileViewController : UIViewController
// 跟节点
@property (nonatomic, strong) File *rootFile;

@end
