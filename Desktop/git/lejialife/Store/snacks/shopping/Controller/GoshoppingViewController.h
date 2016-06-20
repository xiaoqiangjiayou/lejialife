//
//  GoshoppingViewController.h
//  LejiaLife
//
//  Created by 张强 on 16/3/30.
//  Copyright © 2016年 张强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoshoppingModel.h"
#import "GoshoppingCellModel.h"
@interface GoshoppingViewController : UIViewController
@property(nonatomic,retain)NSMutableArray <GoshoppingCellModel *>*dataSouceArray;
@property(nonatomic,retain)NSMutableArray < GoshoppingModel*>*HeadFootdataSouceArray;
@property(nonatomic)BOOL isOrderPush;
@end
