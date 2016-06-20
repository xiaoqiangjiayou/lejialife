//
//  MerchantModel.h
//  LejiaLife
//
//  Created by 张强 on 16/4/27.
//  Copyright © 2016年 张强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MerchantModel : NSObject
@property(nonatomic,copy)NSString *detailId;
@property(nonatomic,copy)NSString *detailSid;
@property(nonatomic,copy)NSString *picture;
@property(nonatomic,retain)NSMutableArray *pictureArray;
@property(nonatomic,copy)NSString *location;
@property(nonatomic,copy)NSString *phoneNumber;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *lng;
@property(nonatomic,copy)NSString *lat;
@property(nonatomic,copy)NSString *rebate;
@property(nonatomic,copy)NSString *distance;
+ (NSMutableArray*)parseResponsData:(NSDictionary*)dic;
@end
