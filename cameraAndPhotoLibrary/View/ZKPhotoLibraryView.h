//
//  TESSSView.h
//  SSAI
//
//  Created by zhangkeqin on 2022/3/24.
//  Copyright © 2022 ZK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKPhotoLibraryView : UIView

//显示照片
@property (nonatomic, strong) UICollectionView *collectionView;

//所有照片组内的url数组（内部是最大的相册的照片url，这个相册一般名字是 所有照片或All Photos）
@property (nonatomic, strong) NSMutableArray *allPhotoArray;


@property (nonatomic, copy) NSString *reTakeName;//重拍或重选


@end


