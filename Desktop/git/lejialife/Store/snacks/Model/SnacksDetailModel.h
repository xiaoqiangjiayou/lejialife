//
//  SnacksDetailModel.h
//  LejiaLife
//
//  Created by 张强 on 16/4/6.
//  Copyright © 2016年 张强. All rights reserved.
//
#import "BaseModel.h"

@interface SnacksDetailModel : BaseModel

@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString *productId;
@property(nonatomic,copy)NSString *detailDescription;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,retain)NSMutableArray *littleScrollowDatasouceArray;
@property(nonatomic,retain)NSMutableArray *detailDatasouceArray;
@property(nonatomic,copy)NSString *PopImag;
@property(nonatomic,retain)NSMutableArray *scrollowHighArr;
@property(nonatomic,copy)NSString *scrollowHigh;
@property(nonatomic,retain)NSMutableArray *typeArray;
@property(nonatomic,copy)NSString * cellNumber;
+ (NSMutableDictionary*)parseResponsData:(NSDictionary*)dic;
@end
