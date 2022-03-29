//
//  TESSSViewController.h
//  SSAI
//
//  Created by zhangkeqin on 2022/3/24.
//  Copyright © 2022 ZK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZKPhotoLibraryViewController : UIViewController

@property (nonatomic, copy) NSString *reTakeName;//重拍或重选

@property (nonatomic,strong) UIImage *image;

@property (nonatomic, assign) CGRect imageFrame;

@end

NS_ASSUME_NONNULL_END
