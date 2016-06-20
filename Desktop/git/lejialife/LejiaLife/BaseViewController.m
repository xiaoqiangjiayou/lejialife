//
//  BaseViewController.m
//  LejiaLife
//
//  Created by 张强 on 16/3/22.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
@implementation BaseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor redColor];
    [self addleftBtn];
}
-(void)addleftBtn{
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 25, 25);
        [button setBackgroundImage:[UIImage imageNamed:@"hamburg navigation_icon"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(drawer) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    
}
-(void)drawer{
    AppDelegate *tempApplication =(AppDelegate*)[[UIApplication sharedApplication]delegate];
    if (tempApplication.leftSlide.closed) {
        //打开左视图
        [tempApplication.leftSlide openLeftView];
    }else{
        //关闭左视图
        [tempApplication.leftSlide closeLeftView];
    }
}

@end
