//
//  TESSSView.m
//  SSAI
//
//  Created by zhangkeqin on 2022/3/24.
//  Copyright © 2022 ZK. All rights reserved.
//

#import "ZKPhotoLibraryView.h"
#import "ZKPhotoLibraryCollectionViewCell.h"
#import "ZKPhotoPreviewViewController.h"
@interface ZKPhotoLibraryView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIButton *backButton;

@end

@implementation ZKPhotoLibraryView

-(NSMutableArray *)allPhotoArray{
    if(!_allPhotoArray){
        _allPhotoArray = [[NSMutableArray alloc]init];
    }
    return _allPhotoArray;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        [self getPhoto];
        [self configUI];
    }
    return self;
}

-(void)configUI{
    [self addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(pixelValue(34));
        make.top.mas_equalTo((navHeight - pixelValue(70)) / 2);
        make.width.height.mas_equalTo(pixelValue(70));
    }];
    
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(navHeight);
        make.left.right.bottom.mas_equalTo(0);
    }];
}

-(UIButton *)backButton{
    if(!_backButton){
        _backButton = [[UIButton alloc]init];
        [_backButton setBackgroundImage:[UIImage imageNamed:@"home_camera_back"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(click_backButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

-(UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, navHeight, screenW, screenH - navHeight) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[ZKPhotoLibraryCollectionViewCell class] forCellWithReuseIdentifier:@"ZKPhotoLibraryCollectionViewCell"];
    }
    return _collectionView;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.allPhotoArray.count;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZKPhotoLibraryCollectionViewCell *cell = (ZKPhotoLibraryCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ZKPhotoLibraryCollectionViewCell" forIndexPath:indexPath];
    PHAsset *asset = self.allPhotoArray[indexPath.row];

    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize cellSize = cell.frame.size;
    CGSize AssetGridThumbnailSize = CGSizeMake(cellSize.width * scale, cellSize.height * scale);
    
    [[PHImageManager defaultManager] requestImageForAsset:asset
                             targetSize:AssetGridThumbnailSize
                            contentMode:PHImageContentModeDefault
                                options:nil
                          resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                cell.photoView.image = result;
                          }];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PHAsset *asset = self.allPhotoArray[indexPath.row];
    
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage *resultImage, NSDictionary *info) {
        if ([[info valueForKey:@"PHImageResultIsDegradedKey"]integerValue] == 0){
            
            ZKPhotoPreviewViewController *photoPreviewViewController = [[ZKPhotoPreviewViewController alloc]init];
            photoPreviewViewController.reTakeName = @"重选";
            CGFloat showHeight = screenH - navHeight - pixelValue(220);
            CGFloat scaleW = screenW / resultImage.size.width;
            CGFloat scaleH = showHeight / resultImage.size.height;
            
            if(resultImage.size.height * scaleW > showHeight){
                photoPreviewViewController.imageFrame = CGRectMake((screenW - resultImage.size.width * scaleH) / 2, 0, resultImage.size.width * scaleH, showHeight);
            }else{
                photoPreviewViewController.imageFrame = CGRectMake(0, 0, screenW, resultImage.size.height * scaleW);
            }
            
            photoPreviewViewController.image = resultImage;
            [self.viewController.navigationController pushViewController:photoPreviewViewController animated:YES];
        }
    }];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((screenW - 6) / 3, (screenW - 6) / 3);
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 3;//列间距
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 3;//行间距
}

-(void)getPhoto{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusDenied) {
            NSLog(@"用户拒绝当前应用访问相册,我们需要提醒用户打开访问开关");
        }else if (status == PHAuthorizationStatusRestricted){
            NSLog(@"家长控制,不允许访问");
        }else if (status == PHAuthorizationStatusNotDetermined){
            NSLog(@"用户还没有做出选择");
        }else if (status == PHAuthorizationStatusAuthorized){
            NSLog(@"用户允许当前应用访问相册");
            dispatch_async(dispatch_get_main_queue(), ^{
                // 列出所有相册智能相册
                PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
                if (smartAlbums.count != 0) {
                    //获取资源时的参数
                    PHFetchOptions *allPhotosOptions = [[PHFetchOptions alloc] init];
                    //按时间排序
                    allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
                    //所有照片 装载数组
                    PHFetchResult *allPhotos = [PHAsset fetchAssetsWithOptions:allPhotosOptions];
                    for (NSInteger i = 0; i < allPhotos.count; i++) {
                        PHAsset *asset = allPhotos[i];
                        if (asset.mediaType == PHAssetMediaTypeImage) {
                            [self.allPhotoArray addObject:asset];
                        }
                        
                    }
                    //数组反序，把最新的照片放最上边
                    NSArray *tempArray = [self.allPhotoArray copy];
                    tempArray = [[tempArray reverseObjectEnumerator] allObjects];
                    self.allPhotoArray = [tempArray mutableCopy];
                    [self.collectionView reloadData];
                }
            });
        }
    }];
}


-(void)click_backButton{
    [self.viewController.navigationController popViewControllerAnimated:YES];
}
@end
