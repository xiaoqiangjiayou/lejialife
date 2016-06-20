//
//  OrderDetailsModel.h
//  LejiaLife
//
//  Created by 张强 on 16/5/18.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "BaseModel.h"

@interface OrderDetailsModel : BaseModel
@property(nonatomic,copy)NSString *oneid;
@property(nonatomic,copy)NSString *repository;
@property(nonatomic,copy)NSString *version;
@property(nonatomic,copy)NSString *specDetail;
@property(nonatomic,copy)NSString *picture;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *minPrice;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *productNumber;
+ (NSMutableArray*)parseResponsSectionData:(NSArray*)arr;
@end
