//
//  LeftViewController.m
//  LejiaLife
//
//  Created by 张强 on 16/4/13.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "LeftViewController.h"
#import "LoginViewController.h"
#import "SetViewController.h"
#import "OrderViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "OrderViewController.h"
#import "AddressViewController.h"
#import "SetViewController.h"
#import "AddressViewController.h"
@interface LeftViewController ()
@property(nonatomic)UIImageView *imagV;
@property(nonatomic)UILabel *numberLabel;
@property(nonatomic)UILabel *buttomLabel;
@property(nonatomic,copy)NSString *telephoneNumber;
@property(nonatomic,copy)NSString *imageUrl;

@property(nonatomic)UIButton *btn1;
@property(nonatomic)UIButton *btn2;
@property(nonatomic)UIButton *btn3;
@property(nonatomic)UILabel *label1;
@property(nonatomic)UILabel *label2;
@property(nonatomic)UILabel *label3;
@end

@implementation LeftViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shuaxin) name:@"Login" object:@"success"];//监听一个通知
    [MobClick beginLogPageView:@"LeftController"];
}
#pragma mark - tabbar还原
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];//移除通知
    [MobClick endLogPageView:@"LeftController"];
}
-(void)shuaxin{
    self.numberLabel.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"PhoneNumber"];
    self.imagV.image=[UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"headImageUrl"]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetch];
    [self creatViews];
    [self creatBtns];
}
-(void)fetch{
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {
            self.telephoneNumber=nil;
        }else{
        self.telephoneNumber=[[NSUserDefaults standardUserDefaults] objectForKey:@"PhoneNumber"];
        }
}
-(void)creatViews{
    UIImage *image=[UIImage imageNamed:@"side background(1)"];
    self.view.backgroundColor= [UIColor colorWithPatternImage:image];
    self.buttomLabel=[[UILabel alloc]initWithFrame:CGRectMake(60, SCREEN_HEIGHT-45, 250, 20)];
    self.buttomLabel.text=@"客服电话：17839980365";
    self.buttomLabel.textColor=[UIColor colorWithRed:140.0/250.0 green:140.0/250.0 blue:140.0/250.0 alpha:1];
    self.buttomLabel.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:self.buttomLabel];
    UIView *roundView=[[UIView alloc]initWithFrame:CGRectMake(80, 75, 96, 96)];
    roundView.backgroundColor=[UIColor clearColor];
    roundView.layer.cornerRadius=48;
    roundView.clipsToBounds=YES;
    [roundView.layer setBorderWidth:2];
    [roundView.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.view addSubview:roundView];
    self.imagV=[[UIImageView alloc]initWithFrame:CGRectMake(6, 6, 84, 84)];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {
        self.imagV.image=[UIImage imageNamed:@"touxiang"];
    }else{
        self.imagV.image=[UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"headImageUrl"]];
    }
    [roundView addSubview:self.imagV];
    self.numberLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 181, 120, 25)];
    self.numberLabel.text=self.telephoneNumber;
    self.numberLabel.font=[UIFont systemFontOfSize:16.0];
    self.numberLabel.textColor=[UIColor whiteColor];
    [self.view addSubview:self.numberLabel];
}
-(void)creatBtns{
    NSArray *arr=@[@"order_icon",@"receipt address_icon",@"account settings_icon"];
    self.btn1=[[UIButton alloc]initWithFrame:CGRectMake(0, 240, SCREEN_WIDTH, 50)];
    [self.view addSubview:self.btn1];
    UIImageView *imagV=[[UIImageView alloc]initWithFrame:CGRectMake(40, 10, 18, 20)];
    imagV.image=[UIImage imageNamed:[arr objectAtIndex:0]];
    [_btn1 addSubview:imagV];
    UILabel *textLabel1=[[UILabel alloc]initWithFrame:CGRectMake(78, 10, 150, 20)];
    textLabel1.text=@"我的订单";
    textLabel1.textColor=[UIColor whiteColor];
    [_btn1 addSubview:textLabel1];
    _label1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10, 50)];
    _label1.backgroundColor=[UIColor clearColor];
    [_btn1 addSubview:_label1];
    [_btn1 addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn2=[[UIButton alloc]initWithFrame:CGRectMake(0, 240+50, SCREEN_WIDTH, 50)];
    [self.view addSubview:self.btn2];
    UIImageView *imagV2=[[UIImageView alloc]initWithFrame:CGRectMake(40, 10, 18, 20)];
    imagV2.image=[UIImage imageNamed:[arr objectAtIndex:1]];
    [_btn2 addSubview:imagV2];
    UILabel *textLabel2=[[UILabel alloc]initWithFrame:CGRectMake(78, 10, 150, 20)];
    textLabel2.text=@"收货地址";
    textLabel2.textColor=[UIColor whiteColor];
    [_btn2 addSubview:textLabel2];
    _label2=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10, 50)];
    _label2.backgroundColor=[UIColor clearColor];
    [_btn2 addSubview:_label2];
    [_btn2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn3=[[UIButton alloc]initWithFrame:CGRectMake(0, 240+50*2, SCREEN_WIDTH, 50)];
    [self.view addSubview:self.btn3];
    UIImageView *imagV3=[[UIImageView alloc]initWithFrame:CGRectMake(40, 10, 18, 20)];
    imagV3.image=[UIImage imageNamed:[arr objectAtIndex:2]];
    [_btn3 addSubview:imagV3];
    UILabel *textLabel3=[[UILabel alloc]initWithFrame:CGRectMake(78, 10, 150, 20)];
    textLabel3.text=@"账户设置";
    textLabel3.textColor=[UIColor whiteColor];
    [_btn3 addSubview:textLabel3];
    _label3=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10, 50)];
    _label3.backgroundColor=[UIColor clearColor];
    [_btn3 addSubview:_label3];
    [_btn3 addTarget:self action:@selector(btn3Click) forControlEvents:UIControlEventTouchUpInside];
}
-(void)btn1Click{
    AppDelegate *tempApplication =(AppDelegate*)[[UIApplication sharedApplication]delegate];
    _btn3.backgroundColor=[UIColor clearColor];
    _btn2.backgroundColor=[UIColor clearColor];
    _btn1.backgroundColor=[UIColor blackColor];
    _label3.backgroundColor=[UIColor clearColor];
    _label2.backgroundColor=[UIColor clearColor];
    _label1.backgroundColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {//如果未登录
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.navigationController.navigationBarHidden=YES;
        [tempApplication.nav pushViewController:loginVC animated:YES];
        loginVC.loginBlock = ^{
            
            [tempApplication.leftSlide closeLeftView];
            OrderViewController *Order=[[OrderViewController alloc]init];
            Order.isLoginPush=YES;
            [tempApplication.nav pushViewController:Order animated:YES];
        };
        loginVC.notLoginBlock = ^{
            [tempApplication.nav popViewControllerAnimated:NO];
        };
        //[self.navigationController pushViewController:loginVC animated:YES];
        //未登录直接return,不在进行任何其他操作
        return;
    }else{
        [tempApplication.leftSlide closeLeftView];
        OrderViewController *Order=[[OrderViewController alloc]init];
        Order.isLoginPush=NO;
        [tempApplication.nav pushViewController:Order animated:YES];
    }
}
-(void)btn2Click{
    AppDelegate *tempApplication =(AppDelegate*)[[UIApplication sharedApplication]delegate];
    _btn3.backgroundColor=[UIColor clearColor];
    _btn2.backgroundColor=[UIColor blackColor];
    _btn1.backgroundColor=[UIColor clearColor];
    _label3.backgroundColor=[UIColor clearColor];
    _label2.backgroundColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    _label1.backgroundColor=[UIColor clearColor];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {//如果未登录
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.navigationController.navigationBarHidden=YES;
        [tempApplication.nav pushViewController:loginVC animated:YES];
        loginVC.loginBlock = ^{
            [tempApplication.leftSlide closeLeftView];
            AddressViewController *address=[[AddressViewController alloc]init];
            [tempApplication.nav pushViewController:address animated:YES];
            
        };
        loginVC.notLoginBlock = ^{
            [tempApplication.nav popViewControllerAnimated:NO];
        };
        //[self.navigationController pushViewController:loginVC animated:YES];
        
        //未登录直接return,不在进行任何其他操作
        return;
    }else{
        [tempApplication.leftSlide closeLeftView];
        AddressViewController *address=[[AddressViewController alloc]init];
        address.isGoshoppingPush=NO;
        [tempApplication.nav pushViewController:address animated:YES];
    }
    
}
-(void)btn3Click{
    AppDelegate *tempApplication =(AppDelegate*)[[UIApplication sharedApplication]delegate];
    _btn3.backgroundColor=[UIColor blackColor];
    _btn2.backgroundColor=[UIColor clearColor];
    _btn1.backgroundColor=[UIColor clearColor];
    _label3.backgroundColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    _label2.backgroundColor=[UIColor clearColor];
    _label1.backgroundColor=[UIColor clearColor];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {//如果未登录
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.navigationController.navigationBarHidden=YES;
        [tempApplication.nav pushViewController:loginVC animated:YES];
        loginVC.loginBlock = ^{
            [tempApplication.leftSlide closeLeftView];
            SetViewController *setVC=[[SetViewController alloc]init];
            [tempApplication.nav pushViewController:setVC animated:YES];
        };
        loginVC.notLoginBlock = ^{
            [tempApplication.nav popViewControllerAnimated:NO];
        };
        //[self.navigationController pushViewController:loginVC animated:YES];
        
        //未登录直接return,不在进行任何其他操作
        return;
    }else{
        [tempApplication.leftSlide closeLeftView];
        SetViewController *setVC=[[SetViewController alloc]init];
        [tempApplication.nav pushViewController:setVC animated:YES];
    }
    
    
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
