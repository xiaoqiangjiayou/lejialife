//
//  SnacksThirdTableViewCell.h
//  LejiaLife
//
//  Created by 张强 on 16/6/3.
//  Copyright © 2016年 张强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SnacksThirdTableViewCell : UITableViewCell
@property(nonatomic)UILabel *PopWindowInventoryLabel;
@property(nonatomic)UILabel *PopWindowNumberLabel;
@property(nonatomic)UIButton *reducebtn;
@property(nonatomic)UIButton *addbtn;
@property(nonatomic)UILabel *PopLittleLabel;
-(instancetype)initWithdatasouceArr:(NSMutableArray*)arr;
@end
