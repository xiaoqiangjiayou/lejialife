//
//  GoshoppingModel.h
//  LejiaLife
//
//  Created by 张强 on 16/4/26.
//  Copyright © 2016年 张强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface GoshoppingModel : BaseModel
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *location;
@property(nonatomic,copy)NSString *phoneNumber;
@property(nonatomic,copy)NSString *province;
@property(nonatomic,copy)NSString *city;
@property(nonatomic,copy)NSString *country;
@property(nonatomic,copy)NSString *scoreB;
@property(nonatomic,copy)NSString *totalPrice;
@property(nonatomic,copy)NSString *totalScore;
@property(nonatomic,copy)NSString *truePrice;
@property(nonatomic,copy)NSString *freightPrice;
@property(nonatomic,copy)NSString *orderid;
@property(nonatomic,copy)NSString *createDate;
@property(nonatomic,copy)NSString *orderSid;
+ (NSMutableArray*)parseResponsData:(NSDictionary*)dic;
@end
