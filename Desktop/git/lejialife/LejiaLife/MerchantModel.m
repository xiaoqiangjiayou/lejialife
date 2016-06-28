//
//  MerchantModel.m
//  LejiaLife
//
//  Created by 张强 on 16/4/27.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "MerchantModel.h"

@implementation MerchantModel
+ (NSMutableArray*)parseResponsData:(NSDictionary*)dic{
    NSMutableArray *modelarr=[NSMutableArray array];
    NSDictionary *dic2=dic[@"data"];
    MerchantModel*model=[[MerchantModel alloc]init];
    NSString *str1=[NSString stringWithFormat:@"%@", dic2[@"id"]];
    if ([str1 isEqual:@"<null>"]) {
        model.detailId=@"1";
    }else{
        model.detailId=str1;
    }
    NSString *str2=[NSString stringWithFormat:@"%@", dic2[@"sid"]];
    if ([str2 isEqual:@"<null>"]) {
        model.detailSid=@"1";
    }else{
        model.detailSid=str2;
    }
    
    
    NSString *str3=[NSString stringWithFormat:@"%@", dic2[@"location"]];
    if ([str2 isEqual:@"<null>"]) {
        model.location=@"1";
    }else{
        model.location=str3;
    }
    NSString *str4=[NSString stringWithFormat:@"%@", dic2[@"phoneNumber"]];
    if ([str2 isEqual:@"<null>"]) {
        model.phoneNumber=@"1";
    }else{
        model.phoneNumber=str4;
    }
    NSString *str5=[NSString stringWithFormat:@"%@", dic2[@"picture"]];
    if ([str2 isEqual:@"<null>"]) {
        model.picture=@"1";
    }else{
        model.picture=str5;
    }
    NSString *str6=[NSString stringWithFormat:@"%@", dic2[@"name"]];
    if ([str2 isEqual:@"<null>"]) {
        model.name=@"1";
    }else{
        model.name=str6;
    }
    NSString *str7=[NSString stringWithFormat:@"%@", dic2[@"lat"]];
    if ([str2 isEqual:@"<null>"]) {
        model.lat=@"1";
    }else{
        model.lat=str7;
    }
    NSString *str8=[NSString stringWithFormat:@"%@", dic2[@"lng"]];
    if ([str2 isEqual:@"<null>"]) {
        model.lng=@"1";
    }else{
        model.lng=str8;
    }
    NSString *str9=[NSString stringWithFormat:@"%@", dic2[@"rebate"]];
    if ([str2 isEqual:@"<null>"]) {
        model.rebate=@"1";
    }else{
        model.rebate=str9;
    }
    NSString *str10=[NSString stringWithFormat:@"%@", dic2[@"distance"]];
    if ([str2 isEqual:@"<null>"]) {
        model.distance=@"1";
    }else{
        model.distance=str10;
    }
    model.pictureArray=[NSMutableArray array];
    NSArray *arr=dic2[@"detailList"];
    for (NSDictionary *dic3 in arr) {
        NSString *picture=dic3[@"picture"];
        [model.pictureArray addObject:picture];
    }
    [modelarr addObject:model];
    return modelarr;
}
@end
