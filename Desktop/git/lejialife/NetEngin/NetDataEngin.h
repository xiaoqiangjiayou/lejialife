//
//  NetDataEngin.h
//  LejiaLife
//
//  Created by 张强 on 16/3/21.
//  Copyright © 2016年 张强. All rights reserved.
//

#import <Foundation/Foundation.h>
//定义block类型，用于网络请求结果的传递
typedef void(^SuccessBlockType) (id responsData);
typedef void(^FailedBlockType) (NSError *error);

@interface NetDataEngin : NSObject

//单例
+ (instancetype)sharedInstance;
//下订单
-(void)creatOrderParamter:(NSDictionary *)paramter WithURL:(NSString *)url success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock;


-(void)requestremenAtpage:(NSInteger)currentPage WithURL:(NSString *)url success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock;
//address post
-(void)requestHomeParamter:(NSDictionary *)paramter Atpage:(NSString*)currentPage WithURL:(NSString *)url success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock;
//首页
-(void)requestHomeMerchantParamter:(NSDictionary *)paramter Atpage:(NSString*)currentPage WithURL:(NSString *)url success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock;
//周边商家
-(void)requestMerchantParamter:(NSDictionary *)paramter Atpage:(NSString*)currentPage WithURL:(NSString *)url success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock;

@end
