//
//  perimeterModel.m
//  LejiaLife
//
//  Created by 张强 on 16/5/4.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "perimeterModel.h"

@implementation perimeterModel
+ (NSMutableArray*)parseResponsData:(NSDictionary*)dic{
    NSMutableArray *modelArray=[NSMutableArray array];
    NSMutableArray *dataArr=dic[@"data"];
    for (NSDictionary *dic2 in dataArr) {
        perimeterModel *model=[[perimeterModel alloc]init];
        model.iid=[NSString stringWithFormat:@"%d",[dic2[@"id"] intValue]];
        model.location=dic2[@"location"];
        model.name=dic2[@"name"];
        model.picture=dic2[@"picture"];
        model.rebate=[NSString stringWithFormat:@"消费额的百分之%@将返到您的乐+账户",dic2[@"rebate"]];
        model.distance=[NSString stringWithFormat:@"%dkm",(int)dic2[@"distance"]/1000];
        [modelArray addObject:model];
    }
    return modelArray;
}
@end
