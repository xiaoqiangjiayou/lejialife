//
//  typeSpaceModel.m
//  LejiaLife
//
//  Created by 张强 on 16/5/9.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "typeSpaceModel.h"

@implementation typeSpaceModel
+ (NSMutableArray*)parseResponsData:(NSArray*)arr{
    NSMutableArray *modelArray=[NSMutableArray array];
    for(NSDictionary *dic in arr){
        typeSpaceModel *model=[[typeSpaceModel alloc]init];
        NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
        model.typeRepository=[numberFormatter stringFromNumber:dic[@"repository"]];
        model.typeId=[NSString stringWithFormat:@"%@",dic[@"id"] ];
        model.typeSpecDetail=dic[@"specDetail"];
        float typeIntegral;
        typeIntegral=[dic[@"price"] floatValue]/100- [dic[@"minPrice"] floatValue]/100;
        model.typeIntegral=[NSString stringWithFormat:@"%.2f",typeIntegral];
        model.typeprice=[NSString stringWithFormat:@"%.2f", [dic[@"price"] floatValue]/100];
        model.btnSelecd=NO;
        model.typePicture=dic[@"picture"];
        [modelArray addObject:model];
    }
    return modelArray;
}

@end
