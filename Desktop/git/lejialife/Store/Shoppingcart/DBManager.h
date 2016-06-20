//
//  DBManager.h
//  LejiaLife
//
//  Created by 张强 on 16/4/15.
//  Copyright © 2016年 张强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsModel.h"
@interface DBManager : NSObject
//单例
+ (instancetype)manager;

//读取所有的商品
- (NSArray*)readAllGoods;

//添加一个商品
- (void)addGoods:(GoodsModel*)goods;

//跟新一个商品
- (void)updateGoods:(GoodsModel*)goods;

//删除一个商品
- (void)deleteGoods:(GoodsModel*)Goods;

//查看商品是否存在
- (BOOL)isGoodsExists:(GoodsModel*)Goods;

//-(void)insertManyPerson:(BOOL)isFlag;
@end
