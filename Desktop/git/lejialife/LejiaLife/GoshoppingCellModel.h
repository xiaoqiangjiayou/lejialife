//
//  GoshoppingCellModel.h
//  LejiaLife
//
//  Created by 张强 on 16/5/26.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "BaseModel.h"

@interface GoshoppingCellModel : BaseModel
@property(nonatomic,copy)NSString *imageUrl;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *number;
@property(nonatomic,copy)NSString *space;
+ (NSMutableArray*)parseResponsData:(NSDictionary*)dic;
@end
