//
//  TestTableViewCell.h
//  LejiaLife
//
//  Created by 张强 on 16/3/28.
//  Copyright © 2016年 张强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreModel.h"
@interface TestTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *StoreTestImageView;
@property (weak, nonatomic) IBOutlet UILabel *StoreTestLabel1;
@property (weak, nonatomic) IBOutlet UILabel *StoreTestLabel2;
@property (weak, nonatomic) IBOutlet UILabel *StoreLabel3;
-(void)updateWith:(StoreModel*)model;
@end
