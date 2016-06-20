//
//  GoshoppingTableViewCell.m
//  LejiaLife
//
//  Created by 张强 on 16/4/20.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "GoshoppingTableViewCell.h"

@implementation GoshoppingTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatCell];
    }
    return self;
}
-(void)creatCell{
    UIView *backGroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 115)];
    backGroundView.backgroundColor=[UIColor whiteColor];
    [self addSubview:backGroundView];
    _imagV=[[UIImageView alloc]initWithFrame:CGRectMake(20, 25, 81, 65)];
    [backGroundView addSubview:_imagV];
    _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(121, 25, 200, 15)];
    _nameLabel.font=[UIFont systemFontOfSize:13];
    _nameLabel.text=@"甜丫头 桂花黑糖";
    [backGroundView addSubview:_nameLabel];
    _testLabel=[[UILabel alloc]initWithFrame:CGRectMake(121, 50, 200, 13)];
    _testLabel.font=[UIFont systemFontOfSize:10.0];
    _testLabel.textColor=[UIColor colorWithRed:140.0/250.0 green:140.0/250.0 blue:140.0/250.0 alpha:1];
    _testLabel.text=@"口味：桂花";
    [backGroundView addSubview:_testLabel];
    _numberLabe=[[UILabel alloc]initWithFrame:CGRectMake(121, 75, 200, 13)];
    _numberLabe.font=[UIFont systemFontOfSize:10.0];
    _numberLabe.textColor=[UIColor colorWithRed:140.0/250.0 green:140.0/250.0 blue:140.0/250.0 alpha:1];
    _numberLabe.text=@"数量：3件";
    [backGroundView addSubview:_numberLabe];
    _priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(300, 75, SCREEN_WIDTH-300, 13)];
    _priceLabel.font=[UIFont systemFontOfSize:15.0];
//    _priceLabel.textColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    _priceLabel.textAlignment=NSTextAlignmentLeft;
    _priceLabel.text=@"￥68.00";
    [backGroundView addSubview:_priceLabel];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
