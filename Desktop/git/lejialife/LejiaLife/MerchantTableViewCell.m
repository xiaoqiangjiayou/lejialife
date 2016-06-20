//
//  MerchantTableViewCell.m
//  LejiaLife
//
//  Created by 张强 on 16/4/27.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "MerchantTableViewCell.h"

@implementation MerchantTableViewCell

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
    for (int i=0; i<2; i++) {
        UILabel *lineLabel1=[[UILabel alloc]initWithFrame:CGRectMake(0, i*44, SCREEN_WIDTH, 1.5)];
        lineLabel1.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [self addSubview:lineLabel1];
    }
    self.imagBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, 15, 15, 15)];
    [self addSubview:self.imagBtn];
    self.label=[[UILabel alloc]initWithFrame:CGRectMake(46, 15, SCREEN_WIDTH-46-20, 14)];
    self.label.textColor=[UIColor blackColor];
    self.label.font=[UIFont systemFontOfSize:14];
    [self addSubview:self.label];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
