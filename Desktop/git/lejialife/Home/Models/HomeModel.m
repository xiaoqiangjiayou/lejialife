//
//  HomeModel.m
//  LejiaLife
//
//  Created by 张强 on 16/3/21.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel
+ (NSMutableArray*)parseResponsData:(NSDictionary*)dic{
    NSMutableArray *modelarr=[NSMutableArray array];
    NSArray *arr=dic[@"data"];
    NSArray *arr2=[arr objectAtIndex:0];
        for (NSDictionary *dic2 in arr2) {
            HomeModel *model=[[HomeModel alloc]init];
            model.iid=[NSString stringWithFormat:@"%@",dic2[@"id"]];
            model.location=dic2[@"location"];
            model.name=dic2[@"name"];
            NSString *str=[NSString stringWithFormat:@"%@",dic2[@"picture"]];
            if ([str isEqual:@"<null>"]) {
                str=nil;
            }else{
            model.picture=dic2[@"picture"];
            }
            NSString *rebate=[NSString stringWithFormat:@"%@", dic2[@"rebate"] ];
            if ([rebate isEqual:@"<null>"]) {
                rebate=@"0";
            }
            model.rebate=[NSString stringWithFormat:@"消费额的百分之%@将返到您的乐+账户",rebate];
            model.distance=[NSString stringWithFormat:@"%dkm",(int)dic2[@"distance"]/1000];
            [modelarr addObject:model];
        
    }
    return modelarr;
}
@end
