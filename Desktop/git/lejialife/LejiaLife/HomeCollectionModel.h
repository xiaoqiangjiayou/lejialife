//
//  HomeCollectionModel.h
//  LejiaLife
//
//  Created by 张强 on 16/5/17.
//  Copyright © 2016年 张强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeCollectionModel : NSObject
@property(nonatomic,copy)NSString *iid;
@property(nonatomic,copy)NSString *sid;
@property(nonatomic,copy)NSString *picture;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *ddescription;
@property(nonatomic,copy)NSString *minPrice;
+ (NSMutableArray*)parseResponsData:(NSArray*)arr;
@end
