//
//  ZKCameraViewController.m
//  SSAI
//
//  Created by 风外杏林香 on 2022/3/19.
//  Copyright © 2022 ZK. All rights reserved.
//

#import "ZKCameraViewController.h"
#import "DJCameraManager.h"
#import "ZKCarmeTypeCollectionViewCell.h"
#import "ZKPhotoLibraryViewController.h"
#import "ZKPhotoPreviewViewController.h"
@interface ZKCameraViewController () <DJCameraManagerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UIView *navView;//假导航栏

@property (nonatomic, strong) UIView *topView;//上部分view

@property (nonatomic, strong) UIView *bottomView;//下部分view

@property (nonatomic, strong) UIButton *cancleButton;//取消按钮

@property (nonatomic, strong) UIButton *photoLibraryButton;//相册

@property (nonatomic,strong)DJCameraManager *manager;

@property (nonatomic, strong) UIView *pickView;

@property (nonatomic, strong) UIButton *takingButton;//拍照按钮

@property (nonatomic, strong) ZKPhotoLibraryViewController *photoLibraryViewController;//相册控制器

@property (nonatomic, strong)UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UICollectionView *collectionView;//取景比例选择

@property (nonatomic, strong) ZKCarmeTypeCollectionViewCell *carmeTypeCollectionViewCell;

@property (nonatomic, strong) NSMutableArray *typeSelectedArray;//相机比例选择数组

@property (nonatomic, assign) NSInteger  currentScale;//当前比例是多少

@property (nonatomic, strong) UIImageView *scaleAnimationView;//比例选择时做动画用的view

@property (nonatomic, strong) ZKPhotoPreviewViewController *photoPreviewViewController;//拍照预览界面
@end

@implementation ZKCameraViewController

-(NSMutableArray *)typeSelectedArray{
    if(!_typeSelectedArray){
        _typeSelectedArray = [[NSMutableArray alloc]init];
    }
    return _typeSelectedArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始默认9：16
    self.currentScale = 916;
    [self.typeSelectedArray addObject:@"0"];
    [self.typeSelectedArray addObject:@"1"];
    [self.typeSelectedArray addObject:@"0"];

    [self configUI];
}

-(void)configUI{
    [self.view addSubview:self.navView];
    [self.navView addSubview:self.cancleButton];
    [self.view addSubview:self.topView];
    
    
    [self.topView addSubview:self.pickView];
    
    
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.takingButton];
    [self.bottomView addSubview:self.photoLibraryButton];
    [self.bottomView addSubview:self.collectionView];
    
    
    //创建初始比例动画视图
    self.scaleAnimationView.frame = CGRectMake((self.collectionView.frame.size.width - pixelValue(145)) / 2, (self.collectionView.frame.size.height - pixelValue(72)) / 2,pixelValue(145) , pixelValue(72));
    self.scaleAnimationView.image = [UIImage imageNamed:@"home_camera_9_16_selected"];
    
    [self.collectionView addSubview:self.scaleAnimationView];

    
}

-(UIView *)navView{
    if(!_navView){
        _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenW, navHeight)];
        _navView.backgroundColor = [UIColor whiteColor];
    }
    return _navView;
}
//上部分view
-(UIView *)topView{
    if(!_topView){
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame), screenW, screenH - pixelValue(362) - navHeight)];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}
//下部分view
-(UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), screenW, pixelValue(362))];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}

-(UIView *)pickView{
    if(!_pickView){
        _pickView = [[UIView alloc]init];
        int scaleWidth = 0;//相机比例宽
        int scaleHeight = 0;//相机比例高
        if(self.currentScale == 916){
            scaleWidth = 9;
            scaleHeight = 16;
        }else if(self.currentScale == 169){
            scaleWidth = 16;
            scaleHeight = 9;
        }else if(self.currentScale == 34){
            scaleWidth = 3;
            scaleHeight = 4;
        }
        
        //初始设置比例为 9 ： 16
        CGFloat width = 0;
        CGFloat height = 0;
        //首先设定宽度为屏幕的宽
        width = screenW;
        //根据屏幕的宽度及9 ： 16的比例算出高度
        height = width * scaleHeight / scaleWidth;
        //如果高度大于装载摄像view的高度，则按照这个view的最大高度来定宽度
        if(height > self.topView.frame.size.height){
            height = self.topView.frame.size.height;
            width = height * scaleWidth / scaleHeight;
        }
        _pickView.frame = CGRectMake((screenW - width) / 2, (self.topView.frame.size.height - height) / 2, width, height);
        _pickView.backgroundColor = [UIColor clearColor];
    }
    return _pickView;
}

-(DJCameraManager *)manager{
    if(!_manager){
        _manager = [[DJCameraManager alloc] initWithParentView:self.topView pickView:self.pickView];
        _manager.delegate = self;
        _manager.canFaceRecognition = NO;
    }
    return _manager;
}


-(UIButton *)takingButton{
    if(!_takingButton){
        _takingButton = [[UIButton alloc]initWithFrame:CGRectMake((screenW - pixelValue(174)) / 2, (self.bottomView.frame.size.height - pixelValue(200)), pixelValue(174), pixelValue(174))];
        [_takingButton setBackgroundImage:[UIImage imageNamed:@"home_carme_take_button"] forState:UIControlStateNormal];
        [_takingButton addTarget:self action:@selector(click_takingButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _takingButton;
}


-(UIButton *)cancleButton{
    if(!_cancleButton){
        _cancleButton = [[UIButton alloc]init];
        if(iPhoneX){
            _cancleButton.frame = CGRectMake(pixelValue(30),pixelValue(75), pixelValue(78), pixelValue(78));
        }else{
            _cancleButton.frame = CGRectMake(pixelValue(30),pixelValue(35), pixelValue(78), pixelValue(78));
        }
        [_cancleButton setImage:[UIImage imageNamed:@"home_camera_back"] forState:UIControlStateNormal];
        [_cancleButton setImage:[UIImage imageNamed:@"home_camera_back"] forState:UIControlStateHighlighted];
        [_cancleButton addTarget:self action:@selector(click_cancleButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}


-(UIButton *)photoLibraryButton{
    if(!_photoLibraryButton){
        _photoLibraryButton = [[UIButton alloc]initWithFrame:CGRectMake(30, CGRectGetMinY(self.takingButton.frame) + pixelValue(29), pixelValue(116), pixelValue(116))];
        [_photoLibraryButton setImage:[UIImage imageNamed:@"home_camera_photo"] forState:UIControlStateNormal];
        [_photoLibraryButton setImage:[UIImage imageNamed:@"home_camera_photo"] forState:UIControlStateHighlighted];
        [_photoLibraryButton addTarget:self action:@selector(click_photoLibraryButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _photoLibraryButton;
}
//比例选择时做动画用的view
-(UIImageView *)scaleAnimationView{
    if(!_scaleAnimationView){
        _scaleAnimationView = [[UIImageView alloc]init];
    }
    return _scaleAnimationView;
}

- (UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return _flowLayout;
}


- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake((screenW - pixelValue(489)) / 2,CGRectGetMinY(self.takingButton.frame) - pixelValue(130),pixelValue(489),pixelValue(90)) collectionViewLayout:self.flowLayout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
        _collectionView.alwaysBounceHorizontal = YES;
        [_collectionView registerClass:[ZKCarmeTypeCollectionViewCell class] forCellWithReuseIdentifier:@"ZKCarmeTypeCollectionViewCell"];
        _collectionView.scrollEnabled = NO;
        _collectionView.layer.cornerRadius = pixelValue(45);
    }
    return _collectionView;
}

#pragma mark - UICollectionDelegate & dataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    _carmeTypeCollectionViewCell = [[ZKCarmeTypeCollectionViewCell alloc]init];
    _carmeTypeCollectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZKCarmeTypeCollectionViewCell" forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
            _carmeTypeCollectionViewCell.typeImage.image = [UIImage imageNamed:@"home_camera_3_4_normal"];
            break;
        case 1:
            _carmeTypeCollectionViewCell.typeImage.image = [UIImage imageNamed:@"home_camera_9_16_normal"];
            break;
        case 2:
            _carmeTypeCollectionViewCell.typeImage.image = [UIImage imageNamed:@"home_camera_16_9_normal"];
            break;
        default:
            break;
    }
    return _carmeTypeCollectionViewCell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    for (int i = 0; i < self.typeSelectedArray.count; i++) {
        if(i == indexPath.row){
            [self.typeSelectedArray replaceObjectAtIndex:indexPath.row withObject:@"1"];
        }else{
            [self.typeSelectedArray replaceObjectAtIndex:i withObject:@"0"];
        }
    }
    switch (indexPath.row) {
        case 0:
            [self changeCameraScaleWithScaleWidth:3 andScaleHeight:4];
            break;
        case 1:
            [self changeCameraScaleWithScaleWidth:9 andScaleHeight:16];
            break;
        case 2:
            [self changeCameraScaleWithScaleWidth:16 andScaleHeight:9];
            break;
        default:
            break;
    }
    
    [self viewAnimation];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(pixelValue(163) , pixelValue(72));
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;//行间距
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;//列间距
}


#pragma mark - 根据比例修改相机取景范围
-(void)changeCameraScaleWithScaleWidth:(CGFloat)scaleWidth andScaleHeight:(CGFloat)scaleHeight{
    //测评拍照页点击模式切换
    self.currentScale = [[NSString stringWithFormat:@"%.f%.f",scaleWidth,scaleHeight] integerValue];
    
    
    CGFloat width = 0;
    CGFloat height = 0;
    //首先设定宽度为屏幕的宽
    width = screenW;
    //根据屏幕的宽度及比例算出高度
    height = width * scaleHeight / scaleWidth;
    //如果高度大于装载摄像view的高度，则按照这个view的最大高度来定宽度
    if(height > self.topView.frame.size.height){
        height = self.topView.frame.size.height;
        width = height * scaleWidth / scaleHeight;
    }

    
    [UIView animateWithDuration:0.25 animations:^{
        self.pickView.frame = CGRectMake((screenW - width) / 2, (self.topView.frame.size.height - height) / 2, width, height);
        self.manager.previewLayer.frame = self.pickView.frame;

    }];
}


#pragma mark - cell移动动画
-(void)viewAnimation{
    if(self.currentScale == 916){
        [UIView animateWithDuration:0.25 animations:^{
            self.scaleAnimationView.frame = CGRectMake((self.collectionView.frame.size.width - pixelValue(145)) / 2, (self.collectionView.frame.size.height - pixelValue(72)) / 2,pixelValue(145) , pixelValue(72));
        }];
        self.scaleAnimationView.image = [UIImage imageNamed:@"home_camera_9_16_selected"];
    }else if(self.currentScale == 169){
        [UIView animateWithDuration:0.25 animations:^{
            self.scaleAnimationView.frame = CGRectMake((self.collectionView.frame.size.width - pixelValue(155)), (self.collectionView.frame.size.height - pixelValue(72)) / 2,pixelValue(145) , pixelValue(72));
        }];
        self.scaleAnimationView.image = [UIImage imageNamed:@"home_camera_16_9_selected"];
    }else if(self.currentScale ==34){
        [UIView animateWithDuration:0.25 animations:^{
            self.scaleAnimationView.frame = CGRectMake(pixelValue(10), (self.collectionView.frame.size.height - pixelValue(72)) / 2,pixelValue(145) , pixelValue(72));
        }];
        self.scaleAnimationView.image = [UIImage imageNamed:@"home_camera_3_4_selected"];
    }
}




#pragma mark - 拍照按钮点击
-(void)click_takingButton{
    //测评拍照页点击拍照
    [self.manager takePhotoWithImageBlock:^(UIImage *originImage, UIImage *scaledImage, UIImage *croppedImage) {
        if (croppedImage) {
            self.photoPreviewViewController = [ZKPhotoPreviewViewController new];
            self.photoPreviewViewController.reTakeName = @"重拍";
            self.photoPreviewViewController.modalPresentationStyle = UIModalPresentationFullScreen;
            CGFloat showHeight = screenH - navHeight - pixelValue(220);
            CGFloat scaleW = screenW / croppedImage.size.width;
            CGFloat scaleH = showHeight / croppedImage.size.height;
            
            if(croppedImage.size.height * scaleW > showHeight){
                self.photoPreviewViewController.imageFrame = CGRectMake((screenW - croppedImage.size.width * scaleH) / 2, 0, croppedImage.size.width * scaleH, showHeight);
            }else{
                self.photoPreviewViewController.imageFrame = CGRectMake(0, 0, screenW, croppedImage.size.height * scaleW);
            }
            self.photoPreviewViewController.image = croppedImage;
            [self.navigationController pushViewController:self.photoPreviewViewController  animated:YES];
        }
    }];
}


#pragma mark - 取消按钮点击
-(void)click_cancleButton{
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark - 相册点击
-(void)click_photoLibraryButton{
    // 从相册中选取
    if ([self isPhotoLibraryAvailable]) {
        self.photoLibraryViewController = [[ZKPhotoLibraryViewController alloc] init];
        [self.navigationController pushViewController:self.photoLibraryViewController animated:YES];
        
    }
}


#pragma mark - 判断相册是否可用
- (BOOL)isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary];
}




//点击对焦
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    [self.manager focusInPoint:point];
}



#pragma -mark DJCameraDelegate
- (void)cameraDidFinishFocus{
    NSLog(@"对焦结束了");
}
- (void)cameraDidStareFocus{
    NSLog(@"开始对焦");
}


//在页面结束或出现记得开启／停止摄像
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    if (![self.manager.session isRunning]) {
        [self.manager.session startRunning];
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
    if ([self.manager.session isRunning]) {
        [self.manager.session stopRunning];
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)dealloc
{
    NSLog(@"照相机释放了");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
