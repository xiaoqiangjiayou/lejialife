//
//  OrderDetailsModel.m
//  LejiaLife
//
//  Created by 张强 on 16/5/18.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "OrderDetailsModel.h"

@implementation OrderDetailsModel
+ (NSMutableArray*)parseResponsSectionData:(NSArray*)arr{
    NSMutableArray *modelarr=[NSMutableArray array];
    for (NSDictionary *dic in arr) {
        OrderDetailsModel *model=[[OrderDetailsModel alloc]init];
        model.oneid=[dic[@"productSpec"][@"id"] stringValue];
        model.repository=[dic[@"productSpec"][@"repository"] stringValue];
        model.version=[dic[@"productSpec"][@"version"] stringValue];
        model.specDetail=dic[@"productSpec"][@"specDetail"];
        model.picture=dic[@"productSpec"][@"picture"];
        model.productNumber=[NSString stringWithFormat:@"%@", dic[@"productNumber"] ];
        model.name=dic[@"product"][@"name"];
        model.price=[dic[@"productSpec"][@"price"] stringValue];
        model.minPrice=[dic[@"productSpec"][@"minPrice"] stringValue];
        [modelarr addObject:model];
    }
    return modelarr;
}
@end
