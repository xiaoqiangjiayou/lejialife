//
//  AddressTableViewCell.m
//  LejiaLife
//
//  Created by 张强 on 16/5/5.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "AddressTableViewCell.h"

@implementation AddressTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)init{
    if (self=[super init]) {
        [self creatCell];
    }
    return self;
}
-(void)creatCell{
    self.backgroundColor=[UIColor colorWithRed:232.0/250.0 green:232.0/250.0 blue:232.0/250.0 alpha:1];
    UIView *backV=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130)];
    backV.backgroundColor=[UIColor whiteColor];
    [self addSubview:backV];
    self.nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 18, 40, 16)];
    self.nameLabel.font=[UIFont systemFontOfSize:14];
    [backV addSubview:self.nameLabel];
    self.phoneNumberLabel=[[UILabel alloc]initWithFrame:CGRectMake(110, 18, 120, 16)];
    self.phoneNumberLabel.font=[UIFont systemFontOfSize:14];
    [backV addSubview:self.phoneNumberLabel];
    self.locationLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 50, SCREEN_WIDTH-30, 14)];
    [backV addSubview:self.locationLabel];
    UILabel *lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 1)];
    lineLabel.backgroundColor=[UIColor colorWithRed:232.0/250.0 green:232.0/250.0 blue:232.0/250.0 alpha:1];
    [backV addSubview:lineLabel];
    _rememberBtn=[[UIButton alloc]initWithFrame:CGRectMake(30, 95, 20, 20)];
    _rememberBtn.layer.cornerRadius=10;
    _rememberBtn.clipsToBounds=YES;
    [backV addSubview:_rememberBtn];
    UILabel *morenLabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 98, 60, 14)];
    morenLabel.font=[UIFont systemFontOfSize:14];
    morenLabel.text=@"默认地址";
    morenLabel.textColor=[UIColor colorWithRed:140.0/250.0 green:140.0/250.0 blue:140.0/250.0 alpha:1];
    [backV addSubview:morenLabel];
    self.editBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-160, 95, 60, 20)];
    [self.editBtn setImage:[UIImage imageNamed:@"edit_icon"] forState:UIControlStateNormal];
    [self.editBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [backV addSubview:self.editBtn];
    [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    self.editBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.editBtn setTitleColor:[UIColor colorWithRed:140.0/250.0 green:140.0/250.0 blue:140.0/250.0 alpha:1] forState:UIControlStateNormal];
    self.deleteBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-80, 95, 60, 20)];
    [self.deleteBtn setImage:[UIImage imageNamed:@"delete_icon"] forState:UIControlStateNormal];
    [self.deleteBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [backV addSubview:self.deleteBtn];
    [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    self.deleteBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.deleteBtn setTitleColor:[UIColor colorWithRed:140.0/250.0 green:140.0/250.0 blue:140.0/250.0 alpha:1] forState:UIControlStateNormal];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
