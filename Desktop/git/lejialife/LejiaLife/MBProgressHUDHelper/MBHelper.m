//
//  MBHelper.m
//  GeneralProjectTemplate
//
//  Created by SKY on 16/3/11.
//  Copyright © 2016年 刘强. All rights reserved.
//

#import "MBHelper.h"
#import "AppDelegate.h"
//#import "MyHelper.h"

@implementation MBHelper

#pragma mark - 在下面显示提示文本
/**
 *  下面显示提示文本
 *
 *  @param text        提示文本
 *  @param customColor 提示视图背景色
 *  @param time        显示时间
 */
+ (void)showHUDViewWithTextForFooterView:(NSString *)text
               withHUDColor:(UIColor *)customColor
                    withDur:(CGFloat)time{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.color = customColor;
    hud.labelText = text;
    hud.labelFont = [UIFont systemFontOfSize:13.0f];
    hud.margin = 10.0f;
    hud.yOffset = [UIScreen mainScreen].bounds.size.height / 2.0 - 70;
    hud.removeFromSuperViewOnHide = YES;
    if (time != 0) {
        [hud hide:YES afterDelay:time];
    }
}

#pragma mark - 带图片的提示视图
/**
 *  带图片的提示视图
 *
 *  @param text        提示文本
 *  @param imageName   图片名称
 *  @param customColor 提示视图背景色
 *  @param time        显示时间
 */
+ (void)showHUDViewCustomView:(NSString *)text
                withImageName:(NSString *)imageName
                 withHUDColor:(UIColor *)customColor
                      withDur:(CGFloat)time{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = text;
    hud.labelColor = [UIColor blackColor];
    hud.color = customColor;
    hud.backgroundColor = [UIColor colorWithRed:0.39 green:0.39 blue:0.39 alpha:0.7];
    hud.removeFromSuperViewOnHide = YES;
    if (time != 0) {
        [hud hide:YES afterDelay:time];
    }
}

#pragma mark - 居中显示提示文本
/**
 *  居中显示提示文本
 *
 *  @param text        时间
 *  @param time        提示文本
 *  @param customColor 提示视图背景色
 */
+ (void)showHUDViewWithTextForCenterView:(NSString *)text
                    withDur:(CGFloat)time
               withHUDColor:(UIColor *)customColor{
    //只显示文字
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.color = customColor;
    hud.labelText = text;
    hud.labelFont = [UIFont systemFontOfSize:13.0f];
    hud.margin = 10.0f;
    hud.removeFromSuperViewOnHide = YES;
    if (time != 0) {
        [hud hide:YES afterDelay:time];
    }
}

#pragma mark - 自定义的提示视图
/**
 *  自定义的提示视图
 *
 *  @param view        视图
 *  @param text        文本
 *  @param animated    是否显示
 *  @param customColor 提示视图背景色
 *
 *  @return            提示视图
 */
+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view
                         withText:(NSString*)text
                         animated:(BOOL)animated
                     withHUDColor:(UIColor *)customColor{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.removeFromSuperViewOnHide = YES;
    hud.color = customColor;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = text;
    [view addSubview:hud];
    [hud show:animated];
    return hud;
}

#pragma mark - 带按钮的提示视图
/**
 *  带按钮的提示视图
 *
 *  @param view        视图
 *  @param text        文本
 *  @param title       按钮标题
 *  @param target      协议
 *  @param sel         行为事件
 *  @param customColor 提示视图背景色
 *
 *  @return            提示视图
 */
+ (MBProgressHUD *)showProgressHUDAddedTo:(UIView *)view
                                 withText:(NSString *)text
                          withButtonTitle:(NSString *)title
                                   target:(id)target
                                   action:(SEL)sel
                             withHUDColor:(UIColor *)customColor {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.mode = MBProgressHUDModeCustomView;
    hud.color = customColor;
    hud.margin = 0.0f;
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 140, 130)];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 140, 20)];
    titleLabel.text = text;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor whiteColor];
    [backView addSubview:titleLabel];
    
    UIActivityIndicatorView* indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 35, 50, 50)];
    indicator.center = CGPointMake(70, 60);
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [backView addSubview:indicator];
    [indicator startAnimating];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 90, 140, 40);
    btn.center = CGPointMake(70, 110);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    btn.clipsToBounds = YES;
    btn.layer.borderColor = [[UIColor whiteColor]CGColor];
    btn.layer.borderWidth = 0.5;
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:btn];
    
    hud.customView = backView;
    hud.removeFromSuperViewOnHide = YES;
    [view addSubview:hud];
    [hud show:YES];
    return hud;
}

#pragma mark - 隐藏HUB提示视图
/**
 *  隐藏HUB提示视图
 */
+ (void)hideHUDView{
    AppDelegate *ApplicationDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [MBProgressHUD hideAllHUDsForView:ApplicationDelegate.window animated:YES];
}

@end
