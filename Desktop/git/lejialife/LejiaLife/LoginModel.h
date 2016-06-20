//
//  LoginModel.h
//  LejiaLife
//
//  Created by 张强 on 16/5/12.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "BaseModel.h"

@interface LoginModel : BaseModel
@property(nonatomic,copy)NSString *LoginToken;
@property(nonatomic,copy)NSString *userOneBarCode;
@property(nonatomic,copy)NSString *headImageUrl;
+ (NSDictionary*)parseResponsData:(NSDictionary*)dic;
@end
