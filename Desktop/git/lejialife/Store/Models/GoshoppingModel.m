//
//  GoshoppingModel.m
//  LejiaLife
//
//  Created by 张强 on 16/4/26.
//  Copyright © 2016年 张强. All rights reserved.
//
/*

 */
#import "GoshoppingModel.h"

@implementation GoshoppingModel
+ (NSMutableArray*)parseResponsData:(NSDictionary*)dic{
    NSMutableArray *modelarr=[NSMutableArray array];
    NSDictionary *dic2=dic[@"data"];
    GoshoppingModel *model=[[GoshoppingModel alloc]init];
    NSString *str=[NSString stringWithFormat:@"%@",dic2[@"address"]];
    if ([str isEqual:@"<null>"]) {
        model.name=nil;
        model.location=@"请填写收货地址";
        model.phoneNumber=@"";
        model.province=@"";
        model.city=@"";
        model.country=@"";
    }else{
        model.name=[dic2[@"address"] objectForKey:@"name"];
        model.location=[dic2[@"address"] objectForKey:@"location"];
        model.phoneNumber=[dic2[@"address"] objectForKey:@"phoneNumber"];
        model.province=[dic2[@"address"] objectForKey:@"province"];
        model.city=[dic2[@"address"] objectForKey:@"city"];
        model.country=[dic2[@"address"] objectForKey:@"county"];
    }
    model.scoreB=[NSString stringWithFormat:@"%@", dic2[@"scoreB"] ];
    model.totalPrice=[NSString stringWithFormat:@"%@", dic2[@"totalPrice"] ];
    model.totalScore=[NSString stringWithFormat:@"%@", dic2[@"totalScore"] ];
    model.truePrice=[NSString stringWithFormat:@"%@", dic2[@"truePrice"] ];
    model.orderid=[NSString stringWithFormat:@"%@", dic2[@"id"] ];
    model.freightPrice=[NSString stringWithFormat:@"%@", dic2[@"freightPrice"] ];
    model.createDate=[NSString stringWithFormat:@"%@", dic2[@"createDate"] ];
    model.orderSid= dic2[@"orderSid"];
    [modelarr addObject:model];
    return modelarr;
}
@end
