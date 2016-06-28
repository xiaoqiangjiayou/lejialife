//
//  SetViewController.m
//  LejiaLife
//
//  Created by 张强 on 16/4/29.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "SetViewController.h"
#import "HomeViewController.h"
#import "AppDelegate.h"
#import "LoginPassWordViewController.h"
#import "ChangePassWordViewController.h"
@interface SetViewController ()

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self creatTitleView];
    [self creatViews];
}
//导航栏视图
-(void)creatTitleView{
    self.navigationController.navigationBarHidden=YES;
    UIView *TitleVIew=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    TitleVIew.backgroundColor=[UIColor whiteColor];
    UILabel *lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 63, SCREEN_WIDTH, 1)];
    lineLabel.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [TitleVIew addSubview:lineLabel];
    [self.view addSubview:TitleVIew];
    UIButton *returnBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 74)];
    [returnBtn setImage:[UIImage imageNamed:@"return_icon"] forState:UIControlStateNormal];
    [returnBtn setImageEdgeInsets:UIEdgeInsetsMake(15, -30, 5, 15)];
    [returnBtn addTarget:self action:@selector(Btnreturn) forControlEvents:UIControlEventTouchUpInside];
    [TitleVIew addSubview:returnBtn];
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 30, 100, 20)];
    titleLabel.text=self.titleStr;
    titleLabel.font=[UIFont systemFontOfSize:20.0f];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.textColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    [TitleVIew addSubview:titleLabel];
}
-(void)Btnreturn{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
-(void)creatViews{
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 40)];
    [self.view addSubview:btn];
    btn.backgroundColor=[UIColor whiteColor];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"修改密码" forState:UIControlStateNormal];
    btn.titleEdgeInsets=UIEdgeInsetsMake(0, -SCREEN_WIDTH/2-60, 0, 0);
    [btn addTarget:self action:@selector(BtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *imagV=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-25, 10, 10, 15)];
    imagV.image=[UIImage imageNamed:@"choice_iconn.png"];
    imagV.userInteractionEnabled=YES;
    [btn addSubview:imagV];
    UIButton *btn2=[[UIButton alloc]initWithFrame:CGRectMake(20, 64+100, SCREEN_WIDTH-40, 40)];
    [self.view addSubview:btn2];
    btn2.backgroundColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn2.layer.cornerRadius=5;
    [btn2 setTitle:@"退出登录" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(Btn2Click) forControlEvents:UIControlEventTouchUpInside];
}
-(void)BtnClick{
    
    ChangePassWordViewController *changePassWord=[[ChangePassWordViewController alloc]init];
    [self.navigationController pushViewController:changePassWord animated:NO];
}
-(void)Btn2Click{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LoginToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userOneBarCode"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"scoreA"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"scoreB"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLogin"];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
//    AppDelegate *tempApplication =(AppDelegate*)[[UIApplication sharedApplication]delegate];
//    [tempApplication.leftSlide closeLeftView];
//   // HomeViewController *home=[[HomeViewController alloc]init];
//    [self.navigationController pushViewController:tempApplication animated:YES];
    if (self.ExitUpdateBlock) {
        self.ExitUpdateBlock();
    }
    
}
+ (BOOL)validateMobile:(NSString *)mobile
{
    if (mobile.length != 11) {
        return NO;
    }
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^1[3|4|5|6|7|8|9][0-9]\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //注销成为第一响应者；键盘就会消失
    //    [textField resignFirstResponder];
    //这种方式也可以让键盘消失。
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
