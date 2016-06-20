//
//  TabbarModel.h
//  LejiaLife
//
//  Created by 张强 on 16/3/21.
//  Copyright © 2016年 张强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TabbarModel : NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *imageName;
@property(nonatomic,copy)NSString *className;

//初始化 modle的类方法
+ (instancetype)modelWithTitle:(NSString*)title imageName:(NSString*)imageName className:(NSString*)className;

//初始化modle的实例方法
- (id)initWithTitle:(NSString*)title imageName:(NSString*)imageName className:(NSString*)className;

//获取正常状态下的图片
- (UIImage*)normalImage;
@end
