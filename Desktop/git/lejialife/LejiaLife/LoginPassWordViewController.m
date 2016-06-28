//
//  LoginPassWordViewController.m
//  LejiaLife
//
//  Created by 张强 on 16/4/29.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "LoginPassWordViewController.h"
#import "VerificationViewController.h"
#import "LoginViewController.h"
@interface LoginPassWordViewController ()<UITextFieldDelegate>
@property(nonatomic,copy)NSString *passWord;
@property(nonatomic)UITextField *passWordTextField;
@end

@implementation LoginPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self creatTitleView];
    [self creatViews];
}
//导航栏视图
-(void)creatTitleView{
    self.navigationController.navigationBarHidden=YES;
    UIView *TitleVIew=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    TitleVIew.backgroundColor=[UIColor whiteColor];
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
    UIButton *closeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame=CGRectMake(SCREEN_WIDTH-60, 30, 40, 20) ;
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    closeBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [closeBtn setTitleColor:[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1] forState:UIControlStateNormal];
    [TitleVIew addSubview:closeBtn];
    [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
}
-(void)Btnreturn{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)close{
    LoginViewController *login=[[LoginViewController alloc]init];
    [self.navigationController pushViewController:login animated:YES];
}
-(void)creatViews{
    _passWordTextField=[[UITextField alloc]initWithFrame:CGRectMake(20, 114, SCREEN_WIDTH-40, 50*SCREEN_HEIGHTSCALE)];
    [_passWordTextField.layer setBorderWidth:1.5];
    _passWordTextField.layer.cornerRadius=5;
    [_passWordTextField.layer setBorderColor:[UIColor groupTableViewBackgroundColor].CGColor];
    _passWordTextField.font=[UIFont systemFontOfSize:16];
    _passWordTextField.placeholder=@"请输入不少于6位数字的登录密码";
    _passWordTextField.textAlignment=NSTextAlignmentCenter;
    UIButton * btn=[UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame=CGRectMake(0, 0, 60, 50);
    UILabel *lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, 1.5, 30)];
    lineLabel.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [btn addSubview:lineLabel];
    [btn setTitle:@"显示" forState:0];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(accordingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _passWordTextField.rightView=btn;
    _passWordTextField.rightViewMode=UITextFieldViewModeAlways;
    //设置开始编辑时候，提供清空按钮
    _passWordTextField.clearsOnBeginEditing=YES;
    _passWordTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    _passWordTextField.delegate=self;
    [self.view addSubview:_passWordTextField];
    UIButton *confirmBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, 224, SCREEN_WIDTH-40, 50)];
    confirmBtn.backgroundColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    confirmBtn.layer.cornerRadius=5;
    [confirmBtn setTitle:@"确认注册" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
}
-(void)confirmBtnClick{
    if (self.passWordTextField.text.length>=6) {
        NSDictionary *senddic=@{@"phoneNumber":self.phoneNumber,@"pwd":self.passWordTextField.text,@"type":@"1"};
        [[NetDataEngin sharedInstance]requestHomeParamter: senddic Atpage:nil WithURL:SETPASSWORD success:^(id responsData) {
            NSDictionary *dic=responsData;
            NSInteger status=[dic[@"status"] integerValue];
            if (status==200) {
                LoginViewController *LoginV=[[LoginViewController alloc]init];
                self.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:LoginV animated:YES];
                self.hidesBottomBarWhenPushed=NO;
            }else{
                [MBHelper showHUDViewWithTextForFooterView:dic[@"msg"] withHUDColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.36]withDur:1.0];
            }
        } failed:^(NSError *error) {
            
        }];
    }
    
}
-(void)accordingBtnClick{
    
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
