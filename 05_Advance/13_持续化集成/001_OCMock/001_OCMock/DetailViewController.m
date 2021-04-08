//
//  DetailViewController.m
//  001_OCMock
//
//  Created by Daiyi on 2021/4/8.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (nonatomic, strong) UILabel *detailDescriptionLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    _detailDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, UIScreen.mainScreen.bounds.size.width - 40, 88)];
    _detailDescriptionLabel.textColor = UIColor.greenColor;
    _detailDescriptionLabel.numberOfLines = 0;
    _detailDescriptionLabel.backgroundColor = UIColor.lightGrayColor;
    [self.view addSubview:_detailDescriptionLabel];
    
    _detailDescriptionLabel.text = [self.objStr description];
}



@end
