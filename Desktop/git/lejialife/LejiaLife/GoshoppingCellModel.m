//
//  GoshoppingCellModel.m
//  LejiaLife
//
//  Created by 张强 on 16/5/26.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "GoshoppingCellModel.h"

@implementation GoshoppingCellModel
+ (NSMutableArray*)parseResponsData:(NSDictionary*)dic{
    NSMutableArray *modelarr=[NSMutableArray array];
    NSDictionary *dic2=dic[@"data"];
    NSArray *arr=dic2[@"orderDetails"];
    for (NSDictionary *dic3 in arr) {
        GoshoppingCellModel *model=[[GoshoppingCellModel alloc]init];
        model.name=dic3[@"product"][@"name"];
        model.number=[NSString stringWithFormat:@"%@", dic3[@"productNumber"]];
        model.space=dic3[@"productSpec"][@"specDetail"];
        model.imageUrl=dic3[@"productSpec"][@"picture"];
        model.price=[NSString stringWithFormat:@"%d",[dic3[@"productSpec"][@"price"] intValue]*[model.number intValue]];
        [modelarr addObject:model];
    }
    return modelarr;
}
@end
