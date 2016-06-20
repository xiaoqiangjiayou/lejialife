//
//  HomeCollectionViewCell.m
//  LejiaLife
//
//  Created by 张强 on 16/4/13.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@implementation HomeCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        //实例化
        self.imgV=[[UIImageView alloc]initWithFrame:self.frame];
        [self setBackgroundView:self.imgV];
        UILabel *backLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 50, self.frame.size.width-100, 50)];
        backLabel.layer.borderWidth=1.5;
        backLabel.layer.borderColor=[UIColor whiteColor].CGColor;
        _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width-100, 30)];
        _nameLabel.textAlignment=NSTextAlignmentCenter;
        _nameLabel.font=[UIFont systemFontOfSize:14];
        _nameLabel.textColor=[UIColor whiteColor];
        [backLabel addSubview:_nameLabel];
        _littleDescriptionLabel=[[UILabel alloc]initWithFrame:CGRectMake(0 , 30 , self.frame.size.width-100 , 20) ];
        _littleDescriptionLabel.textAlignment=NSTextAlignmentCenter;
        _littleDescriptionLabel.font=[UIFont systemFontOfSize:13];
        _littleDescriptionLabel.textColor=[UIColor whiteColor];
        [backLabel addSubview:_littleDescriptionLabel];
        [_imgV addSubview:backLabel];
        _priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width-70, self.imgV.frame.size.height-25, 60, 16)];
        _priceLabel.font=[UIFont systemFontOfSize:13];
        _priceLabel.textColor=[UIColor whiteColor];
        [_imgV addSubview:_priceLabel];
    }
    return self;
}
@end
