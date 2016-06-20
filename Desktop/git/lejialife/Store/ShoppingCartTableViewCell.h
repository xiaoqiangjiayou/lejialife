//
//  ShoppingCartTableViewCell.h
//  LejiaLife
//
//  Created by 张强 on 16/4/18.
//  Copyright © 2016年 张强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCartTableViewCell : UITableViewCell
@property(nonatomic)UIButton *rememberBtn;
@property(nonatomic)UIImageView *imagV;
@property(nonatomic)UILabel *nameLabel;
@property(nonatomic)UILabel *descriptionLabel;
@property(nonatomic)UIButton *reduceBtn;
@property(nonatomic)UIButton *addBtn;
@property(nonatomic)UILabel *numberLabel;
@property(nonatomic)UILabel *priceLabel;
-(instancetype)initWithIndexPath:(NSIndexPath *)myIndexPath;
@end
