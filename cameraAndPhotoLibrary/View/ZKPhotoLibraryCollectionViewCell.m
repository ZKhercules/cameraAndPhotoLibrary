//
//  SSPhotoCollectionViewCell.m
//  SSAI
//
//  Created by zhangkeqin on 2022/3/24.
//  Copyright © 2022 ZK. All rights reserved.
//

#import "ZKPhotoLibraryCollectionViewCell.h"

@implementation ZKPhotoLibraryCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor colorWithHexString:@"#EEF2FB"];
        [self configUI];
    }
    return self;
}

-(void)configUI{
    [self addSubview:self.photoView];
}

-(UIImageView *)photoView{
    if(!_photoView){
        _photoView = [[UIImageView alloc] initWithFrame:self.bounds];
        _photoView.contentMode = UIViewContentModeScaleAspectFill;
        _photoView.layer.masksToBounds = YES;
        [self addSubview:_photoView];
    }
    return _photoView;
}

@end
