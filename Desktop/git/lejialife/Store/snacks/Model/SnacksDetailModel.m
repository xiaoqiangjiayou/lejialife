//
//  SnacksDetailModel.m
//  LejiaLife
//
//  Created by 张强 on 16/4/6.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "SnacksDetailModel.h"

@implementation SnacksDetailModel
+ (NSDictionary*)parseResponsData:(NSDictionary*)dic{
    NSDictionary *modelDic=[[NSDictionary alloc]init];
    SnacksDetailModel *snacksDetailmodel=[[SnacksDetailModel alloc]init];
    snacksDetailmodel.littleScrollowDatasouceArray=[[NSMutableArray alloc]init];
    snacksDetailmodel.detailDatasouceArray=[[NSMutableArray alloc]init];
    snacksDetailmodel.scrollowHighArr=[[NSMutableArray alloc]init];
    snacksDetailmodel.typeArray=[[NSMutableArray alloc]init];
    snacksDetailmodel.name=[dic objectForKey:@"name"];
    snacksDetailmodel.productId=[dic objectForKey:@"id"];
    float p=[[dic objectForKey:@"price"] floatValue]/100;
    float mp=[[dic objectForKey:@"minPrice"] floatValue]/100;
    NSString *pricestring=[NSString stringWithFormat:@"￥%.2f  ~  ￥%.2f",mp,p];
    snacksDetailmodel.price=[NSString stringWithFormat:@"%@",pricestring];
    snacksDetailmodel.detailDescription=[dic objectForKey:@"description"];
    snacksDetailmodel.PopImag=[dic objectForKey:@"thumb"];
    snacksDetailmodel.typeArray=dic[@"productSpecs"];
    NSMutableArray *array1=[dic objectForKey:@"scrollPictures"];
    for (NSDictionary *dic1 in array1) {
        NSString *picture1=[[NSString alloc]init];
        picture1=[dic1 objectForKey:@"picture"] ;
        [snacksDetailmodel.littleScrollowDatasouceArray addObject:picture1];
    }
    NSMutableArray *array2=[dic objectForKey:@"productDetails"];
    int HighSum=0;
    for (NSDictionary *dic2 in array2) {
        NSString *picture2=dic2[@"picture"];
        [snacksDetailmodel.detailDatasouceArray addObject:picture2];
        int h=0;
        NSString *str=[NSString stringWithFormat:@"%@", dic2[@"height"] ];
        if ([str isEqual:@"<null>"]) {
            h=0.1;
        }else{
        h =[[dic2 objectForKey:@"height"] intValue]/2;
        }
        HighSum=HighSum+h;
        [snacksDetailmodel.scrollowHighArr addObject:[NSString stringWithFormat:@"%d",h]];
        snacksDetailmodel.scrollowHigh=[NSString stringWithFormat:@"%d",HighSum];
    }
    snacksDetailmodel.cellNumber=@"1";
modelDic=@{@"productId":snacksDetailmodel.productId,@"name":snacksDetailmodel.name,@"price":snacksDetailmodel.price,@"detaildescription":snacksDetailmodel.detailDescription,@"littleScrollowDatasouceArray":snacksDetailmodel.littleScrollowDatasouceArray,@"detailDatasouceArray":snacksDetailmodel.detailDatasouceArray,@"productSpecs":snacksDetailmodel.typeArray,@"thumb":snacksDetailmodel.PopImag,@"scrollowHighArr":snacksDetailmodel.scrollowHighArr,@"scrollowHith":snacksDetailmodel.scrollowHigh,@"cellNumber":snacksDetailmodel.cellNumber};
    return modelDic;
}

@end
