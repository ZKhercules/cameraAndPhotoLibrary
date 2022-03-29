//
//  PhotoViewController.h
//  照相机demo
//
//  Created by Jason on 11/1/16.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKPhotoPreviewViewController : UIViewController

@property (nonatomic, copy) NSString *reTakeName;//重拍或重选

@property (nonatomic,strong) UIImage *image;

@property (nonatomic, assign) CGRect imageFrame;
@end
