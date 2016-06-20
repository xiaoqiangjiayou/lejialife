//
//  TestTableViewCell.m
//  LejiaLife
//
//  Created by 张强 on 16/3/28.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "TestTableViewCell.h"

@implementation TestTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateWith:(StoreModel*)model{
    [self.StoreTestImageView sd_setImageWithURL:[NSURL URLWithString:model.pictureurl] placeholderImage:nil];
    self.StoreTestLabel1.text=model.name;
    self.StoreTestLabel2.text=model.storedescription;
    NSString *str=[[NSString alloc]init];
    str=[NSString stringWithFormat:@"￥%@",model.price];
    self.StoreLabel3.text=str;
}
@end
