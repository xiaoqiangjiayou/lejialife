//
//  EnveLopeModel.m
//  LejiaLife
//
//  Created by 张强 on 16/5/18.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "EnveLopeModel.h"

@implementation EnveLopeModel
+ (NSMutableArray*)parseResponsSectionData:(NSDictionary*)dic{
    NSMutableArray *modelarr=[NSMutableArray array];
    NSArray *arr=dic[@"data"];
    NSString *str=[NSString stringWithFormat:@"%@", dic[@"data"] ];
    if ([str isEqual:@"<null>"]) {
        return nil;
    }else{
        for (NSDictionary *dic2 in arr) {
            EnveLopeModel*model=[[EnveLopeModel alloc]init];
            model.listArray=dic2[@"list"];
            model.createDate=dic2[@"createDate"];
            [modelarr addObject:model];
        }
        return modelarr;
    }
    
}
@end
