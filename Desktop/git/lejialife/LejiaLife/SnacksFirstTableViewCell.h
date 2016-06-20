//
//  SnacksFirstTableViewCell.h
//  LejiaLife
//
//  Created by 张强 on 16/6/3.
//  Copyright © 2016年 张强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SnacksFirstTableViewCell : UITableViewCell
@property(nonatomic)UIImageView *PopWindowImagV;
@property(nonatomic)UILabel *PopWindowNameLabel;
@property(nonatomic)UILabel *PopWindowPriceLabel;
@property(nonatomic)UILabel *spaceFicationLabe;
-(instancetype)initWithdatasouceArr:(NSMutableArray*)arr;
@end
