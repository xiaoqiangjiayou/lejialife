//
//  AddressModel.h
//  LejiaLife
//
//  Created by 张强 on 16/5/16.
//  Copyright © 2016年 张强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject
@property(nonatomic,copy)NSString *addressId;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *location;
@property(nonatomic,copy)NSString *phoneNumber;
@property(nonatomic,copy)NSString *province;
@property(nonatomic,copy)NSString *city;
@property(nonatomic,copy)NSString *county;
@property(nonatomic)int state;
+ (NSMutableArray*)parseResponsData:(NSDictionary*)dic;
@end
