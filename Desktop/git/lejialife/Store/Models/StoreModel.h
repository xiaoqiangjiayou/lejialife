//
//  StoreModel.h
//  LejiaLife
//
//  Created by 张强 on 16/3/31.
//  Copyright © 2016年 张强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface StoreModel : NSObject
@property(nonatomic,copy)NSNumber *detailId;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *pictureurl;
@property(nonatomic,copy)NSString *storedescription;
@property(nonatomic,copy)NSString *price;
+ (NSMutableArray*)parseResponsData:(NSArray*)arr;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
- (id)valueForUndefinedKey:(NSString *)key;
@end
