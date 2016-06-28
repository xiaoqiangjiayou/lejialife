//
//  AppDelegate.m
//  LejiaLife
//
//  Created by 张强 on 16/3/21.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "AppDelegate.h"
#import "LejiaLifeTabbarViewController.h"
#import "WelcomeViewController.h"
#import "LeftViewController.h"
#import "LoginViewController.h"
#define KEY_SHOW_WELCOM  @"kAlreadyShowWelcomPage"

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //把tabBar作为根
    self.window.backgroundColor=[UIColor whiteColor];
    [self creatRootVC];
    [self.window makeKeyAndVisible];
    //微信支付
    [WXApi registerApp:WXAPPID withDescription:@"乐+生活"];
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:WXAPPID appSecret:WXSECRECT url:@"http://www.umeng.com/social"];
    [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToWechatSession  completion:^(UMSocialResponseEntity *response){
        NSLog(@"response is %@",response);
    }];
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline]];
    UMConfigInstance.appKey = YMAPPKEY;
    UMConfigInstance.channelId = @"App Store";
    //UMConfigInstance.eSType = E_UM_GAME; // 仅适用于游戏场景
    [MobClick startWithConfigure:UMConfigInstance];
    return YES;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
//微信代理
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
    return  [WXApi handleOpenURL:url delegate:self];
}
-(void) onResp:(BaseResp*)resp
{
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    //NSString *strTitle;
    if ([resp isKindOfClass:[PayResp class]])
    {
        PayResp *response = (PayResp *)resp;
        switch (response.errCode) {
            case WXSuccess: {
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                NSNotification *notification = [NSNotification notificationWithName:@"ORDER_PAY_NOTIFICATION" object:@"success"];
                NSLog(@"%@",resp);
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                break;
            }
                
            default: {
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                NSNotification *notification = [NSNotification notificationWithName:@"ORDER_PAY_NOTIFICATION" object:@"fail"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                break;
            }
        }
    }
}

- (void)creatRootVC {
    if (self.window.rootViewController)
    {
        [self.window.rootViewController removeFromParentViewController];
        self.window.rootViewController = nil;
    }
    LeftViewController *leftvc=[[LeftViewController alloc]init];
    self.leftSlide=[[LeftSlideViewController alloc]initWithLeftView:leftvc andMainView:[self createRootViewController]];
    _nav=[[UINavigationController alloc]init];
    [_nav pushViewController:self.leftSlide animated:YES];
    _nav.navigationBarHidden=YES;
    self.window.rootViewController = _nav;
}
- (UIViewController*)createRootViewController
{
    
    if (self.window.rootViewController)
    {
        [self.window.rootViewController removeFromParentViewController];
        self.window.rootViewController = nil;
    }
    
//    //使用NSUserDefault来记录程序是否有启动过
//    BOOL alreadShowWelcom = [[NSUserDefaults standardUserDefaults] boolForKey:KEY_SHOW_WELCOM];
//    if (alreadShowWelcom) {
//        //已经显示
//        
        return  [[LejiaLifeTabbarViewController alloc]init];
//    }else{
//        //没有显示过欢迎界面，把欢迎界面实现出来，同时更新本地化存储
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:KEY_SHOW_WELCOM];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        return [[WelcomeViewController alloc]init];
//    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    //登录需要编写
    [UMSocialSnsService applicationDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
