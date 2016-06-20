//
//  NetDataEngin.m
//  LejiaLife
//
//  Created by 张强 on 16/3/21.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "NetDataEngin.h"
#import "AFNetworking.h"
#import "Netinterface.h"
@interface NetDataEngin ()
//网络请求类
@property(nonatomic)AFHTTPSessionManager *httpManager;
@end
@implementation NetDataEngin
+(instancetype)sharedInstance{
    static NetDataEngin *s_instance=nil;
    static dispatch_once_t oneceToken;
    dispatch_once(&oneceToken,^{
        s_instance=[[NetDataEngin alloc]init];
    });
    return s_instance;
}
-(instancetype)init{
    if (self=[super init]) {
        _httpManager=[[AFHTTPSessionManager alloc]init];
        AFSecurityPolicy *security = [AFSecurityPolicy defaultPolicy];
        security.allowInvalidCertificates = YES;
        _httpManager.securityPolicy = security;
    }
    return self;
}
//无参数
-(void)GET:(NSString*)url success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock{
    _httpManager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/html", nil];
    [_httpManager GET:(NSString *)url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failedBlock) {
            failedBlock(error);
            NSLog(@"%@",error);
        }
    }];
}
//商品列表
-(void)requestremenAtpage:(NSInteger)currentPage WithURL:(NSString *)url success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock{
    NSString *URL=[NSString stringWithFormat:url,currentPage];
    [self GET:URL success:successBlock failed:failedBlock];
}

//有参数
-(void)POST:(NSString*)url paramter:(NSDictionary*)paramter success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock{
    _httpManager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/html", nil];
    [_httpManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    _httpManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [_httpManager POST:(NSString *)url parameters:paramter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failedBlock) {
            failedBlock(error);
            NSLog(@"%@",error);
        }
    }];
}
//address post
-(void)requestHomeParamter:(NSDictionary *)paramter Atpage:(NSString*)currentPage WithURL:(NSString *)url success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock{
    NSString *URL=[NSString stringWithFormat:url,currentPage];
    [self POST:URL paramter:paramter success:successBlock failed:failedBlock];
}
//下订单
-(void)creatOrderParamter:(NSDictionary *)paramter WithURL:(NSString *)url success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock{
    [self POST:url paramter:paramter success:successBlock failed:failedBlock];
}





//首页
-(void)requestHomeMerchantParamter:(NSDictionary *)paramter Atpage:(NSString*)currentPage WithURL:(NSString *)url success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock{
    NSString *URL=[NSString stringWithFormat:url,currentPage];
    [self MerchantPOST:URL paramter:paramter success:successBlock failed:failedBlock];
}
-(void)MerchantPOST:(NSString*)url paramter:(NSDictionary*)paramter success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock{
    _httpManager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/html", nil];
    [_httpManager.requestSerializer setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    [_httpManager POST:(NSString *)url parameters:paramter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failedBlock) {
            failedBlock(error);
            NSLog(@"%@",error);
        }
    }];
}




//周边商家
-(void)requestMerchantParamter:(NSDictionary *)paramter Atpage:(NSString*)currentPage WithURL:(NSString *)url success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock{
    NSString *URL=[NSString stringWithFormat:url,currentPage];
    [self POST:URL paramter:paramter success:successBlock failed:failedBlock];
}
-(void)PermentMerchantPOST:(NSString*)url paramter:(NSDictionary*)paramter success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock{
    _httpManager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/html", nil];
    _httpManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [_httpManager POST:(NSString *)url parameters:paramter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failedBlock) {
            failedBlock(error);
            NSLog(@"%@",error);
        }
    }];
}


@end
