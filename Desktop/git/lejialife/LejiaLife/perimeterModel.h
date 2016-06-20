//
//  perimeterModel.h
//  LejiaLife
//
//  Created by 张强 on 16/5/4.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "BaseModel.h"

@interface perimeterModel : BaseModel
@property(nonatomic,copy)NSString *picture;
@property(nonatomic,copy)NSString *iid;
@property(nonatomic,copy)NSString *location;
@property(nonatomic,copy)NSString *rebate;
@property(nonatomic,copy)NSString *distance;
@property(nonatomic,copy)NSString *name;
+ (NSMutableArray*)parseResponsData:(NSArray*)arr;
@end
