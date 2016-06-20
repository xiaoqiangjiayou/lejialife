//
//  AddressTableViewCell.h
//  LejiaLife
//
//  Created by 张强 on 16/5/5.
//  Copyright © 2016年 张强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressTableViewCell : UITableViewCell
@property(nonatomic)UIButton *rememberBtn;
@property(nonatomic)UIButton *deleteBtn;
@property(nonatomic)UIButton *editBtn;
@property(nonatomic)UILabel *phoneNumberLabel;
@property(nonatomic)UILabel *locationLabel;
@property(nonatomic)UILabel *nameLabel;
@end
