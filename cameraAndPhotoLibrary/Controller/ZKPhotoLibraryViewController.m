//
//  ZKPhotoLibraryViewController.m
//  SSAI
//
//  Created by zhangkeqin on 2022/3/24.
//  Copyright © 2022 ZK. All rights reserved.
//

#import "ZKPhotoLibraryViewController.h"
#import "ZKPhotoLibraryView.h"
@interface ZKPhotoLibraryViewController ()

@property (nonatomic, strong) ZKPhotoLibraryView *photoLibraryView;

@end

@implementation ZKPhotoLibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self cinfigUI];
}

-(void)cinfigUI{
    [self.view addSubview:self.photoLibraryView];
    [self.photoLibraryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

-(ZKPhotoLibraryView *)photoLibraryView{
    if(!_photoLibraryView){
        _photoLibraryView = [[ZKPhotoLibraryView alloc]init];
        _photoLibraryView.reTakeName = self.reTakeName;
    }
    return _photoLibraryView;
}

@end
