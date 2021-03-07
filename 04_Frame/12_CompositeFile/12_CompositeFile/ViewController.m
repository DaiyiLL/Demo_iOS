//
//  ViewController.m
//  12_CompositeFile
//
//  Created by Daiyi on 2021/3/3.
//

#import "ViewController.h"
#import "FileCell.h"
#import "File.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) File *root;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Root";
    
    // 1.创建根节点
    self.root = [File fileWithType:kFolder name:@"root"];
    
    // 2.创建第一级文件
    File *folder_A_1 = [File fileWithType:kFolder name:@"Folder_A_1"];
    File *file_A_1 = [File fileWithType:kFile name:@"File_A_1"];
    File *file_A_2 = [File fileWithType:kFile name:@"File_A_2"];
    File *file_A_3 = [File fileWithType:kFile name:@"File_A_3"];
    
    
    // 3.创建第二级文件
    File *folder_B_1 = [File fileWithType:kFolder name:@"Folder_B_1"];
    File *file_B_1 = [File fileWithType:kFile name:@"File_B_1"];
    File *file_B_2 = [File fileWithType:kFile name:@"File_B_2"];
    File *folder_B_2 = [File fileWithType:kFolder name:@"Folder_B_2"];
    
    // 4.创建第二级文件
    File *folder_C_1 = [File fileWithType:kFolder name:@"Folder_C_1"];
    File *file_C_1 = [File fileWithType:kFile name:@"File_C_1"];
    File *file_C_2 = [File fileWithType:kFile name:@"File_C_2"];
    
    
    [self.root addFile:folder_A_1];
    [self.root addFile:file_A_1];
    [self.root addFile:file_A_2];
    [self.root addFile:file_A_3];
    
    [folder_A_1 addFile:folder_B_1];
    [folder_A_1 addFile:file_B_1];
    [folder_A_1 addFile:file_B_2];
    [folder_A_1 addFile:folder_B_2];
    
    [folder_B_1 addFile:folder_C_1];
    [folder_B_1 addFile:file_C_1];
    [folder_B_1 addFile:file_C_2];


    [self setTableView];
}

#pragma mark - tableView相关
- (void)setTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    self.tableView.delegate       = self;
    self.tableView.dataSource     = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[FileCell class] forCellReuseIdentifier:@"fileCell"];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.root.childFiles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FileCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"fileCell"];
    cell.indexPath  = indexPath;
    cell.tableView  = tableView;
    cell.controller = self;
    
    // 传入节点File
    cell.data = self.root.childFiles[indexPath.row];
    
    [cell loadContent];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.f;
}


@end
