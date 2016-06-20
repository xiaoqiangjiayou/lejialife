//
//  EnveLopeModel.h
//  LejiaLife
//
//  Created by 张强 on 16/5/18.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "BaseModel.h"

@interface EnveLopeModel : BaseModel
@property(nonatomic,copy)NSString *createDate;
@property(nonatomic,copy)NSString *dateCreated;
@property(nonatomic,copy)NSString *number;
@property(nonatomic,copy)NSString *operate;
@property(nonatomic,copy)NSString *origin;
@property(nonatomic,copy)NSString *orderSid;
@property(nonatomic,retain)NSArray *listArray;
+ (NSMutableArray*)parseResponsSectionData:(NSDictionary*)dic;
@end
