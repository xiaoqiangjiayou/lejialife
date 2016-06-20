//
//  LoginModel.m
//  LejiaLife
//
//  Created by 张强 on 16/5/12.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel
+ (NSDictionary*)parseResponsData:(NSDictionary*)dic{
    //NSMutableArray *modelDic=[[NSMutableDictionary alloc]init];
    LoginModel *model=[[LoginModel alloc]init];
    model.LoginToken=dic[@"token"];
    model.userOneBarCode=dic[@"userOneBarCode"];
    model.headImageUrl=dic[@"headImageUrl"];
    NSDictionary *modelDic=@{@"LoginToken":model.LoginToken,@"userOneBarCode":model.userOneBarCode,@"headImageUrl":model.headImageUrl};
    return modelDic;
}
@end
