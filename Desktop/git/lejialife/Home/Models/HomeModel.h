//
//  HomeModel.h
//  LejiaLife
//
//  Created by 张强 on 16/3/21.
//  Copyright © 2016年 张强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface HomeModel : BaseModel
@property(nonatomic,copy)NSString *iid;
@property(nonatomic,copy)NSString *location;
@property(nonatomic,copy)NSString *picture;
@property(nonatomic,copy)NSString *rebate;
@property(nonatomic,copy)NSString *distance;
@property(nonatomic,copy)NSString *name;
+ (NSMutableArray*)parseResponsData:(NSDictionary*)dic;
@end
