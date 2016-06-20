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
    model.detailId=[NSString stringWithFormat:@"%@", dic2[@"id"]];
    model.detailSid=[NSString stringWithFormat:@"%@", dic2[@"sid"]];
    model.location=dic2[@"location"];
    model.phoneNumber=dic2[@"phoneNumber"];
    model.picture=dic2[@"picture"];
    model.name=dic2[@"name"];
    model.lat=[NSString stringWithFormat:@"%@",dic2[@"lat"]];
    model.lng=[NSString stringWithFormat:@"%@",dic2[@"lng"]];
    model.rebate=[NSString stringWithFormat:@"%@",dic2[@"rebate"]];
    model.distance=[NSString stringWithFormat:@"%@",dic2[@"distance"]];
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
