//
//  ShoppingCartModel.m
//  LejiaLife
//
//  Created by 张强 on 16/4/27.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "ShoppingCartModel.h"
#import "GoodsModel.h"
@implementation ShoppingCartModel
+ (NSMutableArray*)parseResponsData:(NSArray*)arr{
    NSMutableArray *modelArray=[NSMutableArray array];
    GoodsModel *good=[[GoodsModel alloc]init];
    for (good in arr) {
        ShoppingCartModel *Model=[[ShoppingCartModel alloc]init];
        Model.detailId=good.detailId;
        Model.productSpecId=good.productSpecsId;
        Model.name= good.name;
        Model.Description= good.Description;
        Model.imageurl=good.imageurl;
        Model.price=good.price;
        Model.numbers=good.numbers;
        Model.modelRememberFlag=NO;
        Model.productSpecsId=good.productSpecsId;
        [modelArray addObject:Model];
    }
    return modelArray;
}
@end
