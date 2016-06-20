//
//  SnacksTableViewCell.m
//  LejiaLife
//
//  Created by 张强 on 16/3/24.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "SnacksTableViewCell.h"
#import "typeSpaceModel.h"
@implementation SnacksTableViewCell

- (void)awakeFromNib {
    self.backgroundColor=[UIColor redColor];
}
-(instancetype)initWithdatasouceArr:(NSMutableArray*)arr{
    if (self=[super init]) {
        [self crearCellWithdatasouceArr:arr];
    }
        return self;
}
-(void)crearCellWithdatasouceArr:arr{
    UILabel *styleLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 25, 40, 20)];
    styleLabel.text=@"款式:";
    styleLabel.font=[UIFont systemFontOfSize:17.0f];
    [self addSubview:styleLabel];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
