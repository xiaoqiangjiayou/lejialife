//
//  EnvelopHeaderView.m
//  LejiaLife
//
//  Created by 张强 on 16/5/13.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "EnvelopHeaderView.h"

@implementation EnvelopHeaderView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self creatHeaderView];
    }
    return self;
}
-(void)creatHeaderView{
    _labelImagV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100*SCREEN_WIDTHSCALE-22, 30)];
    [self.contentView addSubview:_labelImagV];
    _timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100*SCREEN_WIDTHSCALE-7, 30)];
    _timeLabel.font=[UIFont systemFontOfSize:12];
    _timeLabel.textColor=[UIColor whiteColor];
    [self.labelImagV addSubview:_timeLabel];
    _lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(100*SCREEN_WIDTHSCALE, 0, 1, 50*SCREEN_HEIGHTSCALE)];
    _lineLabel.backgroundColor=[UIColor colorWithRed:232.0/250.0 green:232.0/250.0 blue:232.0/250.0 alpha:1];
    [self.contentView addSubview:_lineLabel];
    _littleImagV=[[UIImageView alloc]initWithFrame:CGRectMake(100*SCREEN_WIDTHSCALE-10, 15, 20, 20)];
    [self.contentView addSubview:self.littleImagV];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
