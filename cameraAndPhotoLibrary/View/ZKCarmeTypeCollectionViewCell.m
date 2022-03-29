//
//  SSCarmeTypeCollectionViewCell.m
//  SSAI
//
//  Created by zhangkeqin on 2021/11/13.
//  Copyright © 2021 ZK. All rights reserved.
//

#import "ZKCarmeTypeCollectionViewCell.h"

@implementation ZKCarmeTypeCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        [self configUI];
    }
    return self;
}

-(void)configUI{
    [self.contentView addSubview:self.typeImage];
    [self.typeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.contentView);
    }];
}

-(UIImageView *)typeImage{
    if(!_typeImage){
        _typeImage = [[UIImageView alloc]init];
    }
    return _typeImage;
}

@end
