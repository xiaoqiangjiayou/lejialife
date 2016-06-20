//
//  WelcomeViewController.m
//  LejiaLife
//
//  Created by 张强 on 16/3/21.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "WelcomeViewController.h"
#import "LejiaLifeTabbarViewController.h"
#import "LeftSlideViewController.h"
#import "LeftViewController.h"
#import "AppDelegate.h"
@implementation WelcomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createWelcomPages];
}
- (void)createWelcomPages
{
    //可以得到屏幕的大小
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:SCREEN_RECT];
    
    scrollView.pagingEnabled = YES;
    //scrollView.backgroundColor=[UIColor cyanColor];
    [self.view addSubview:scrollView];
    
    //在scrollView上添加欢迎页面
    for (int index = 1; index <= 5; index++) {
//        NSString *helpImageName = [NSString stringWithFormat:@"help%d.png",index];
//        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:helpImageName]];
        UIImageView *imageView=[[UIImageView alloc]init];
        imageView.backgroundColor=[UIColor cyanColor];
        imageView.frame = CGRectMake((index-1)*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        if (index == 5) {
            imageView.userInteractionEnabled = YES;
            [self addTapGestureRecognizerOnView:imageView];
        }
        [scrollView addSubview:imageView];
    }
    
    //设置scrollView的contentSize大小
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*5, SCREEN_HEIGHT);
}
- (void)addTapGestureRecognizerOnView:(UIView*)view{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGersture:)];
    [view addGestureRecognizer:tapGesture];
}

- (void)handleTapGersture:(UIGestureRecognizer*)tap
{
//    //切换应用程序的window的根视图控制器
//    LejiaLifeTabbarViewController *tabBarController = [[LejiaLifeTabbarViewController alloc]init];
//    LeftViewController *leftvc=[[LeftViewController alloc]init];
//    LeftSlideViewController *leftSlideViewController=[[LeftSlideViewController alloc]initWithLeftView:leftvc andMainView:tabBarController];
//    //得到应用程序的窗口
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    window.rootViewController = leftSlideViewController;
    //注释掉以前的切换方法,直接再次调用AppDelegate构建RootVC的方法
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    [app creatRootVC];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"WelcomeController"];//("PageOne"为页面名称，可自定义)
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"WelcomeController"];
}
@end
