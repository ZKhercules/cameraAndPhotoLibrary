//
//  ZKMainViewController.m
//  cameraAndPhotoLibrary
//
//  Created by zhangkeqin on 2022/3/29.
//

#import "ZKMainViewController.h"
#import "ZKCameraViewController.h"
@interface ZKMainViewController ()

@property (nonatomic, strong) UIButton *takePhotoButton;

@end

@implementation ZKMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    [self configUI];
}

-(void)configUI{
    self.takePhotoButton.frame = CGRectMake((screenW - 100) / 2, (screenH - 50) / 2, 100, 50);
    [self.view addSubview:self.takePhotoButton];
}

-(UIButton *)takePhotoButton{
    if(!_takePhotoButton){
        _takePhotoButton = [[UIButton alloc]init];
        [_takePhotoButton setTitle:@"start" forState:UIControlStateNormal];
        [_takePhotoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _takePhotoButton.layer.borderColor = [UIColor blackColor].CGColor;
        _takePhotoButton.layer.borderWidth = 2;
        [_takePhotoButton addTarget:self action:@selector(click_takePhotoButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _takePhotoButton;
}

#pragma mark - 开始拍照
-(void)click_takePhotoButton{
    ZKCameraViewController *cameraViewController = [[ZKCameraViewController alloc]init];
    [self.navigationController pushViewController:cameraViewController animated:YES];
}
@end
