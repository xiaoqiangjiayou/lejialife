//
//  PerimeterTableViewCell.m
//  LejiaLife
//
//  Created by 张强 on 16/4/20.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "PerimeterTableViewCell.h"

@implementation PerimeterTableViewCell

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
    self.backgroundColor=[UIColor colorWithRed:222.0/250.0 green:222.0/250.0 blue:222.0/250.0 alpha:1];
    UIView *myView=[[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 130)];
    myView.backgroundColor=[UIColor whiteColor];
    [self addSubview:myView];
    self.imagV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 110, 100)];
    [myView addSubview:self.imagV];
    self.nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(140, 25, SCREEN_WIDTH-140, 17)];
    self.nameLabel.font=[UIFont systemFontOfSize:15];
    [myView addSubview:self.nameLabel];
    UIImageView *littleImagV=[[UIImageView alloc]initWithFrame:CGRectMake(140, 60, 10, 15)];
    littleImagV.image=[UIImage imageNamed:@"location@2x_icon"];
    [myView addSubview:littleImagV];
    self.adressLabel=[[UILabel alloc]initWithFrame:CGRectMake(155, 45, (SCREEN_WIDTH-140)/2+50*SCREEN_WIDTHSCALE, 20)];
    self.adressLabel.font=[UIFont systemFontOfSize:12];
    self.adressLabel.numberOfLines=0;
    [myView addSubview:self.adressLabel];
    self.distanceLabel=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60, 60, 100, 13)];
    self.distanceLabel.font=[UIFont systemFontOfSize:10];
    self.distanceLabel.textColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    [myView addSubview:self.distanceLabel];
    UILabel *lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(140, 92, SCREEN_WIDTH-140, 1)];
    lineLabel.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [myView addSubview:lineLabel];
    UIImageView *buttomImagV=[[UIImageView alloc]initWithFrame:CGRectMake(140, 140-40, 20, 20)];
    buttomImagV.image=[UIImage imageNamed:@"rebate@2x_icon"];
    [myView addSubview:buttomImagV];
    self.accountLabel=[[UILabel alloc]initWithFrame:CGRectMake(165, 106, SCREEN_WIDTH-165, 15)];
    self.accountLabel.font=[UIFont systemFontOfSize:12];
    [myView addSubview:self.accountLabel];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
