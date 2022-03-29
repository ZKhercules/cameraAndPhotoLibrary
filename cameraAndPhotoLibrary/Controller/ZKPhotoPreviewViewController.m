//
//  ZKPhotoPreviewViewController.m
//
//  Created by Jason on 11/1/16.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "ZKPhotoPreviewViewController.h"
@interface ZKPhotoPreviewViewController ()

@property (nonatomic, strong) UIView *navView;

@property (nonatomic, strong) UIButton *backButton;//返回按钮

@property (nonatomic, strong) UIView *middleView;//中间view

@property (nonatomic, strong) UIView *bottomView;//底部view

@property (nonatomic, strong) UIImageView *imageView;//展示图

@property (nonatomic, strong) UIButton *reTakeButton;//重拍

@property (nonatomic, strong) UIButton *chooseButton;//选择

@end

@implementation ZKPhotoPreviewViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configUI];

}

-(void)configUI{
    [self.view addSubview:self.navView];
    [self.navView addSubview:self.backButton];
    [self.view addSubview:self.middleView];
    [self.middleView addSubview:self.imageView];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.reTakeButton];
    [self.bottomView addSubview:self.chooseButton];
    
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(navHeight);
    }];
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        if(iPhoneX){
            make.top.mas_equalTo(pixelValue(75));
        }else{
            make.top.mas_equalTo(pixelValue(35));
        }
        make.left.mas_equalTo(pixelValue(30));
        make.width.height.mas_equalTo(pixelValue(78));
    }];
    
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(screenH - navHeight - pixelValue(220));
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.middleView);
        make.left.mas_equalTo(self.imageFrame.origin.x);
        make.width.mas_equalTo(self.imageFrame.size.width);
        make.height.mas_equalTo(self.imageFrame.size.height);
    }];
    
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.middleView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(pixelValue(220));
    }];
    
    [self.reTakeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-pixelValue(78));
        make.right.mas_equalTo(self.bottomView.mas_centerX).offset(-pixelValue(18));
        make.width.mas_equalTo(pixelValue(326));
        make.height.mas_equalTo(pixelValue(90));
    }];
    
    [self.chooseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-pixelValue(78));
        make.left.mas_equalTo(self.bottomView.mas_centerX).offset(pixelValue(18));
        make.width.mas_equalTo(pixelValue(326));
        make.height.mas_equalTo(pixelValue(90));
    }];
    
    

}



-(UIView *)navView{
    if(!_navView){
        _navView = [[UIView alloc]init];
        _navView.backgroundColor = [UIColor whiteColor];
    }
    return _navView;
}
//返回按钮
-(UIButton *)backButton{
    if(!_backButton){
        _backButton = [[UIButton alloc]init];
        [_backButton setBackgroundImage:[UIImage imageNamed:@"back_arrow"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(click_reTakeButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

//中间view
-(UIView *)middleView{
    if(!_middleView){
        _middleView = [[UIView alloc]init];
        _middleView.backgroundColor = [UIColor whiteColor];
    }
    return _middleView;
}
//底部view
-(UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}
//展示图
-(UIImageView *)imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc]init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.image = self.image;
    }
    return _imageView;
}

//重拍
-(UIButton *)reTakeButton{
    if(!_reTakeButton){
        _reTakeButton = [[UIButton alloc]init];
        [_reTakeButton setTitle:self.reTakeName forState:UIControlStateNormal];
        [_reTakeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _reTakeButton.backgroundColor = [UIColor whiteColor];
        _reTakeButton.layer.borderColor = [UIColor colorWithHexString:@"#C8C9CA"].CGColor;
        _reTakeButton.layer.borderWidth = 1;
        _reTakeButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:pixelValue(31)];
        _reTakeButton.layer.cornerRadius = pixelValue(45);
        _reTakeButton.layer.masksToBounds = YES;
        [_reTakeButton addTarget:self action:@selector(click_reTakeButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reTakeButton;
}
//选择
-(UIButton *)chooseButton{
    if(!_chooseButton){
        _chooseButton = [[UIButton alloc]init];
        [_chooseButton setTitle:@"确定" forState:UIControlStateNormal];
        [_chooseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _chooseButton.backgroundColor = [UIColor colorWithHexString:@"#4390F4"];
        _chooseButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:pixelValue(31)];
        _chooseButton.layer.cornerRadius = pixelValue(45);
        _chooseButton.layer.masksToBounds = YES;
        [_chooseButton addTarget:self action:@selector(click_chooseButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chooseButton;
}


#pragma mark - 重拍
-(void)click_reTakeButton{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 确定
-(void)click_chooseButton{
    //可根据获得的image 进行接下来的操作
    UIImage *image = self.image;
    
}



@end
