//
//  CameraViewController.m
//  025_GPUImageDemo
//
//  Created by Daiyi on 2021/4/15.
//

#import "CameraViewController.h"
#import <GPUImage/GPUImage.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

@interface CameraViewController ()

@property (nonatomic, strong) GPUImageVideoCamera *vCamera;
@property (nonatomic, strong) GPUImageStillCamera *mCamera;
@property (nonatomic, strong) GPUImageSaturationFilter *mFilter;
@property (nonatomic, strong) GPUImageView *mImageView;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 1. 初始化静态的拍照相机
    /*
     1: 相片的尺寸
     2: 前置/后置摄像头
     */
    _mCamera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:(AVCaptureDevicePositionBack)];
    // 2. 拍照的方向
    _mCamera.outputImageOrientation = UIDeviceOrientationPortrait;
    
    // 3. 设置滤镜
    _mFilter = [[GPUImageSaturationFilter alloc] init];
    _mFilter.saturation = 1.5;
    
    // 4. 设置输出
    _mImageView = [[GPUImageView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [self.view addSubview:_mImageView];
    
    // 5. 添加taget
    [_mCamera addTarget:_mFilter];
    [_mFilter addTarget:_mImageView];
    
    // 6. 捕捉
    [_mCamera startCameraCapture];
    
    // 添加拍照按钮
    CGSize screenSize = UIScreen.mainScreen.bounds.size;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((screenSize.width -  80) * 0.5, screenSize.height -  100 - 44, 80, 44)];
    button.backgroundColor = UIColor.redColor;
    [button setTitle:@"拍照" forState:(UIControlStateNormal)];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(takePhoto:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self addCloseBtn];
}


- (void)addCloseBtn {
    UIButton *closeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [closeBtn setTitle:@"关闭" forState:(UIControlStateNormal)];
    [closeBtn setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
    CGFloat width = UIScreen.mainScreen.bounds.size.width;
    UIEdgeInsets safe = UIApplication.sharedApplication.windows.firstObject.safeAreaInsets;
    closeBtn.frame = CGRectMake(width - 88, safe.top, 88, 44);
    [self.view addSubview:closeBtn];
    [closeBtn addTarget:self action:@selector(addCloseBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)addCloseBtnClicked: (UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}


- (void)takePhoto: (UIButton *)sender {
    // 获取图片保存到相册
    __weak CameraViewController *weakSelf = self;
    [_mCamera capturePhotoAsJPEGProcessedUpToFilter:_mFilter withOrientation:(UIImageOrientationDown) withCompletionHandler:^(NSData *processedJPEG, NSError *error) {
//        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
//            //异步执行修改操作
//            [PHAssetChangeRequest creationRequestForAssetFromImage:[UIImage imageWithData:processedJPEG]];
//        } completionHandler:^(BOOL success, NSError * _Nullable error) {
//            if (error) {
//                NSLog(@"%@",@"保存失败");
//            } else {
//                NSLog(@"%@",@"保存成功");
//            }
//        }];
        [[[ALAssetsLibrary alloc] init] writeImageDataToSavedPhotosAlbum:processedJPEG metadata:_mCamera.currentCaptureMetadata completionBlock:^(NSURL *assetURL, NSError *error) {
            if (error == nil) {
                NSLog(@"保存相册成功");
            }
        }];
        
    }];
}


@end
