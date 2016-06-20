//
//  EnvelopTableViewCell.m
//  LejiaLife
//
//  Created by 张强 on 16/5/6.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "EnvelopTableViewCell.h"

@implementation EnvelopTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatCell];
    }
    return self;
}
-(void)creatCell{
    _timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(44*SCREEN_WIDTHSCALE, 10, 50, 11)];
    _timeLabel.font=[UIFont systemFontOfSize:9];
    _timeLabel.textAlignment=NSTextAlignmentLeft;
    _timeLabel.textColor=[UIColor colorWithRed:140.0/250.0 green:140.0/250.0 blue:140.0/250.0 alpha:1];
    [self addSubview:_timeLabel];
    _lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(100*SCREEN_WIDTHSCALE, 0, 1, 73*SCREEN_HEIGHTSCALE)];
    _lineLabel.backgroundColor=[UIColor colorWithRed:232.0/250.0 green:232.0/250.0 blue:232.0/250.0 alpha:1];
    [self addSubview:_lineLabel];
    _littleImagV=[[UIImageView alloc]initWithFrame:CGRectMake(100*SCREEN_WIDTHSCALE-5.5, 8, 11, 11)];
    [self addSubview:self.littleImagV];
    _bigImagV=[[UIImageView alloc]initWithFrame:CGRectMake(100*SCREEN_WIDTHSCALE+5.5+15, 0, SCREEN_WIDTH-(100*SCREEN_WIDTHSCALE+5.5+15)-10, 73*SCREEN_HEIGHTSCALE-5)];
    [self addSubview:_bigImagV];
    _numberLabel=[[UILabel alloc]initWithFrame:CGRectMake(47*SCREEN_WIDTHSCALE, 17, 100*SCREEN_WIDTHSCALE, 30)];
    _numberLabel.font=[UIFont systemFontOfSize:15];
    _numberLabel.textColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    [_bigImagV addSubview:_numberLabel];
    _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(47*SCREEN_WIDTHSCALE, 47, 100*SCREEN_WIDTHSCALE, 12)];
    _nameLabel.font=[UIFont systemFontOfSize:12];
    [_bigImagV addSubview:_nameLabel];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
