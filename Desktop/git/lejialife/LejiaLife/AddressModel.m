//
//  AddressModel.m
//  LejiaLife
//
//  Created by 张强 on 16/5/16.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel
+ (NSMutableArray*)parseResponsData:(NSDictionary*)dic{
    NSMutableArray *modelArr=[[NSMutableArray alloc]init];
    NSArray *data=dic[@"data"];
    for (NSDictionary *dic2 in  data) {
        AddressModel *model=[[AddressModel alloc]init];
        model.addressId=dic2[@"id" ];
        model.name=dic2[@"name"];
        model.location=dic2[@"location"];
        model.phoneNumber=dic2[@"phoneNumber"];
        model.province=dic2[@"province"];
        model.city=dic2[@"city"];
        model.county=dic2[@"county"];
        model.state=[dic2[@"state"] intValue];
        [modelArr addObject:model];
    }
    return modelArr;
}
@end
