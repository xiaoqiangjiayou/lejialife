//
//  MBHelper.h
//  GeneralProjectTemplate
//
//  Created by SKY on 16/3/11.
//  Copyright © 2016年 刘强. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MBProgressHUD.h>

@interface MBHelper : NSObject

/**
 *  下面显示提示文本
 *
 *  @param text        文本内容
 *  @param customColor 背景色
 *  @param time        显示时间
 */
+ (void)showHUDViewWithTextForFooterView:(NSString *)text
               withHUDColor:(UIColor *)customColor
                    withDur:(CGFloat)time;


/**
 *  带图片的提示视图
 *
 *  @param text        文本内容
 *  @param imageName   图片名称
 *  @param customColor 背景色
 *  @param time        显示时间
 */
+ (void)showHUDViewCustomView:(NSString *)text
                withImageName:(NSString *)imageName
                 withHUDColor:(UIColor *)customColor
                      withDur:(CGFloat)time;

/**
 *  居中显示提示文本
 *
 *  @param text        文本内容
 *  @param time        显示时间
 *  @param customColor 背景色
 */
+ (void)showHUDViewWithTextForCenterView:(NSString *)text
                    withDur:(CGFloat)time
               withHUDColor:(UIColor *)customColor ;

/**
 *  自定义的提示视图
 *
 *  @param view        自定义视图
 *  @param text        文本内容
 *  @param animated    是否显示
 *  @param customColor 背景色
 *
 *  @return 提示视图
 */
+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view
                         withText:(NSString*)text
                         animated:(BOOL)animated
                     withHUDColor:(UIColor *)customColor ;

/**
 *  带按钮的提示视图
 *
 *  @param view        视图
 *  @param text        文本
 *  @param title       按钮标题
 *  @param target      按钮协议
 *  @param sel         按钮行为事件
 *  @param customColor 提示视图背景色
 *
 *  @return 提示视图
 */
+ (MBProgressHUD *)showProgressHUDAddedTo:(UIView *)view
                                 withText:(NSString *)text
                          withButtonTitle:(NSString *)title
                                   target:(id)target
                                   action:(SEL)sel
                             withHUDColor:(UIColor *)customColor ;

/**
 *  隐藏HUB提示视图
 */
+ (void)hideHUDView;

@end
