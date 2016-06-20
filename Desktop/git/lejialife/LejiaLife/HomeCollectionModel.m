//
//  HomeCollectionModel.m
//  LejiaLife
//
//  Created by 张强 on 16/5/17.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "HomeCollectionModel.h"

@implementation HomeCollectionModel
+ (NSMutableArray*)parseResponsData:(NSArray*)arr{
    NSMutableArray *modelarr=[NSMutableArray array];
    for (NSDictionary *dic in arr) {
        HomeCollectionModel *model=[[HomeCollectionModel alloc]init];
        model.iid=[NSString stringWithFormat:@"%@",dic[@"id"]];
        model.sid=[NSString stringWithFormat:@"%@",dic[@"sid"]];
        model.minPrice=[NSString stringWithFormat:@"%.1f",[dic[@"minPrice"] floatValue]/100 ];
        model.picture=dic[@"picture"];
        model.ddescription=dic[@"description"];
        model.title=dic[@"title"];
        [modelarr addObject:model];
    }
    return modelarr;
}
@end
