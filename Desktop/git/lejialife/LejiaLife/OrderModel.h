//
//  OrderModel.h
//  LejiaLife
//
//  Created by 张强 on 16/5/18.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "BaseModel.h"

@interface OrderModel : BaseModel
@property(nonatomic,copy)NSString *oneId;
@property(nonatomic,retain)NSArray *orderDetails;
@property(nonatomic,copy)NSString *totalPrice;
@property(nonatomic,copy)NSString *totalScore;
@property(nonatomic,copy)NSString *trueScore;
@property(nonatomic,copy)NSString *freightPrice;
@property(nonatomic,copy)NSString *createDate;
@property(nonatomic,copy)NSString *deliveryDate;
@property(nonatomic,copy)NSString *confirmDate;
@property(nonatomic,copy)NSString *orderSid;
@property(nonatomic,retain)NSDictionary *address;
@property(nonatomic)NSInteger state;
@property(nonatomic,copy)NSString *payWay;
@property(nonatomic,copy)NSString *expressNumber;
@property(nonatomic,copy)NSString *expressCompany;
+ (NSMutableArray*)parseResponsSectionData:(NSDictionary*)dic;
@end
