//
//  OrderModel.m
//  LejiaLife
//
//  Created by 张强 on 16/5/18.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel
+ (NSMutableArray*)parseResponsSectionData:(NSDictionary*)dic{
    NSMutableArray *modelarr=[NSMutableArray array];
    NSArray *arr=dic[@"data"];
    for (NSDictionary *dic2 in arr) {
        OrderModel*model=[[OrderModel alloc]init];
        model.oneId=dic2[@"id"];
        model.orderDetails=dic2[@"orderDetails"];
        model.totalPrice=dic2[@"totalPrice"];
        model.totalScore=dic2[@"totalScore"];
        model.trueScore=dic2[@"trueScore"];
        model.freightPrice=dic2[@"freightPrice"];
        model.createDate=dic2[@"createDate"];
        model.deliveryDate=dic2[@"deliveryDate"];
        model.confirmDate=dic2[@"confirmDate"];
        model.orderSid=dic2[@"orderSid"];
        model.address=dic2[@"address"];
        model.state=[dic2[@"state"] integerValue];
        model.payWay=dic2[@"payWay"] ;
        model.expressNumber=dic2[@"expressNumber"];
        model.expressCompany=dic2[@"expressCompany"];
        [modelarr addObject:model];
    }
    return modelarr;
}
@end
