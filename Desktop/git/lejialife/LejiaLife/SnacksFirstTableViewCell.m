//
//  SnacksFirstTableViewCell.m
//  LejiaLife
//
//  Created by 张强 on 16/6/3.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "SnacksFirstTableViewCell.h"

@implementation SnacksFirstTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithdatasouceArr:(NSMutableArray*)arr{
    if (self=[super init]) {
        [self crearCellWithdatasouceArr:arr];
    }
    return self;
}
-(void)crearCellWithdatasouceArr:arr{
    self.PopWindowImagV=[[UIImageView alloc]initWithFrame:CGRectMake(20, 15, 60, 75)];
    [self addSubview:self.PopWindowImagV];
    self.PopWindowNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(109, 33, 150, 20)];
    self.PopWindowNameLabel.font=[UIFont systemFontOfSize:13.0f];
    [self addSubview:self.PopWindowNameLabel];
    self.PopWindowPriceLabel=[[UILabel alloc]initWithFrame:CGRectMake(109, 60, 200, 20)];
    self.PopWindowPriceLabel.font=[UIFont systemFontOfSize:16.0f];
    self.PopWindowPriceLabel.textColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    [self addSubview:self.PopWindowPriceLabel];
    self.spaceFicationLabe=[[UILabel alloc]initWithFrame:CGRectMake(109, 80, 200, 20)];
    self.spaceFicationLabe.font=[UIFont systemFontOfSize:13.0f];
    self.spaceFicationLabe.textColor=[UIColor colorWithRed:140.0/250.0 green:140.0/250.0 blue:140.0/250.0 alpha:1];
    [self addSubview:self.spaceFicationLabe];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 104, SCREEN_WIDTH, 1.5)];
    label.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self addSubview:label];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
