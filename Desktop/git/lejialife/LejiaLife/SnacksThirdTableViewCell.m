//
//  SnacksThirdTableViewCell.m
//  LejiaLife
//
//  Created by 张强 on 16/6/3.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "SnacksThirdTableViewCell.h"

@implementation SnacksThirdTableViewCell

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
    UILabel *NumberLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 20, 40, 20)];
    NumberLabel.text=@"数量:";
    NumberLabel.font=[UIFont systemFontOfSize:17.0f];
    [self addSubview:NumberLabel];
    self.reducebtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.reducebtn.frame=CGRectMake(20, 55, 45, 30);
    [self.reducebtn setTitle:@"-" forState:UIControlStateNormal];
    [self.reducebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.reducebtn.layer setBorderWidth:1];
    self.reducebtn.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
    [self addSubview:self.reducebtn];
    self.addbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.addbtn.frame=CGRectMake(135, 55, 45, 30);
    [self.addbtn.layer setBorderWidth:1];
    [self.addbtn setTitle:@"+" forState:UIControlStateNormal];
    [self.addbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.addbtn];
    self.PopWindowNumberLabel=[[UILabel alloc]initWithFrame:CGRectMake(65-1, 55, 70+1+1, 30)];
    self.PopWindowNumberLabel.textAlignment=NSTextAlignmentCenter;
    self.PopWindowNumberLabel.layer.borderWidth=1.0f;
    self.PopWindowNumberLabel.layer.borderColor=[UIColor blackColor].CGColor;
    [self addSubview:self.PopWindowNumberLabel];
    
    self.PopWindowInventoryLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 85, 115, 20)];
    self.PopWindowInventoryLabel.font=[UIFont systemFontOfSize:13.0f];
    self.PopWindowInventoryLabel.textColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    [self addSubview:self.PopWindowInventoryLabel];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
