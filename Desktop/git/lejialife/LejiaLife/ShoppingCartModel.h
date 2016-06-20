//
//  ShoppingCartModel.h
//  LejiaLife
//
//  Created by 张强 on 16/4/27.
//  Copyright © 2016年 张强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingCartModel : NSObject

@property(nonatomic,copy)NSString *detailId;
@property(nonatomic,copy)NSString *productSpecId;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *imageurl;
@property(nonatomic,copy)NSString *Description;
@property(nonatomic,copy)NSString *numbers;
@property(nonatomic,copy)NSString *price;
@property(nonatomic)BOOL modelRememberFlag;
@property(nonatomic,copy)NSString *productSpecsId;
+ (NSMutableArray*)parseResponsData:(NSArray*)arr;
@end
