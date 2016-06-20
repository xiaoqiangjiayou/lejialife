//
//  StoreModel.m
//  LejiaLife
//
//  Created by 张强 on 16/3/31.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "StoreModel.h"

@implementation StoreModel
+ (NSMutableArray*)parseResponsData:(NSArray*)arr{
    NSMutableArray *modelArray=[NSMutableArray array];
    for (NSDictionary *dic1 in arr) {
        StoreModel *storemodel=[[StoreModel alloc]init];
        storemodel.detailId=[dic1 objectForKey:@"id"];
        storemodel.name= [dic1 objectForKey:@"name"];;
        storemodel.storedescription= [dic1 objectForKey:@"description"];
        storemodel.pictureurl=[dic1 objectForKey:@"picture"];
        storemodel.price=[NSString stringWithFormat:@"%d.00",[[dic1 objectForKey:@"price"] intValue]/100];
        [modelArray addObject:storemodel];
    }
    return modelArray;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}
@end
