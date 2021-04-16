//
//  ViewController.m
//  025_GPUImageDemo
//
//  Created by Daiyi on 2021/4/14.
//

#import "ViewController.h"
#import <GPUImage/GPUImage.h>
#import "CameraViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) GPUImageSaturationFilter *disFilter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"第一个";
    
    // 1. 获取图片
    _image = [UIImage imageNamed:@"kunkun1.jpeg"];
    
    
}

- (IBAction)saturationChange:(UISlider *)sender {
    // 1。 关于滤镜的处理
    if (_disFilter == nil) {
        _disFilter = [[GPUImageSaturationFilter alloc] init];
    }
    _disFilter.saturation = 1.0;
    [_disFilter forceProcessingAtSize: _image.size];
    [_disFilter useNextFrameForImageCapture];
    // 根据slider来调整饱和度值
    _disFilter.saturation = sender.value * 2;
    // 2. 数据来源
    GPUImagePicture *stillImageSourcer = [[GPUImagePicture alloc] initWithImage:_image];
    
    // 为这个图片添加一个滤镜
    [stillImageSourcer addTarget:_disFilter];
    
    // 处理图片
    [stillImageSourcer processImage];
    
    // 3. 处理完毕输出图片
    UIImage *newImage = [_disFilter imageFromCurrentFramebuffer];
    // 4. 显示图片
    _imageView.image = newImage;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CameraViewController *cameraVC = [[CameraViewController alloc] init];
    cameraVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:cameraVC animated:true completion:nil];
}


@end
