//
//  typeSpaceModel.h
//  LejiaLife
//
//  Created by 张强 on 16/5/9.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "BaseModel.h"

@interface typeSpaceModel : BaseModel
@property(nonatomic,copy)NSString *typePicture;
@property(nonatomic,copy)NSString *typeprice;
@property(nonatomic,copy)NSString *typeId;
@property(nonatomic,copy)NSString *typeRepository;
@property(nonatomic,copy)NSString *typeSpecDetail;
@property(nonatomic)BOOL btnSelecd;
@property(nonatomic,copy)NSString *typeIntegral;
+ (NSMutableArray*)parseResponsData:(NSArray*)arr;
@end
