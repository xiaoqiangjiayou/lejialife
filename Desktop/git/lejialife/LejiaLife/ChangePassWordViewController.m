//
//  ChangePassWordViewController.m
//  LejiaLife
//
//  Created by 张强 on 16/5/13.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "ChangePassWordViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "MBHelper.h"
@interface ChangePassWordViewController ()<UITextFieldDelegate>
@property(nonatomic)UITextField *passWordTextField;
@property(nonatomic)UITextField *NewPassWordTextField;
@property(nonatomic)UILabel *promptLabel;
@end

@implementation ChangePassWordViewController

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
    TitleVIew.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.view addSubview:TitleVIew];
    UIButton *returnBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 74)];
    [returnBtn setImage:[UIImage imageNamed:@"return_icon"] forState:UIControlStateNormal];
    [returnBtn setImageEdgeInsets:UIEdgeInsetsMake(15, -30, 5, 15)];
    [returnBtn addTarget:self action:@selector(Btnreturn) forControlEvents:UIControlEventTouchUpInside];
    [TitleVIew addSubview:returnBtn];
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 30, 100, 20)];
    titleLabel.text=@"修改密码";
    titleLabel.font=[UIFont systemFontOfSize:20.0f];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.textColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    [TitleVIew addSubview:titleLabel];
}
-(void)Btnreturn{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)creatViews{
    _passWordTextField=[[UITextField alloc]initWithFrame:CGRectMake(20, 114, SCREEN_WIDTH-40, 50*SCREEN_HEIGHTSCALE)];
    [_passWordTextField.layer setBorderWidth:1.5];
    _passWordTextField.layer.cornerRadius=5;
    [_passWordTextField.layer setBorderColor:[UIColor groupTableViewBackgroundColor].CGColor];
    _passWordTextField.font=[UIFont systemFontOfSize:16];
    _passWordTextField.placeholder=@"请输入旧密码";
    _passWordTextField.textAlignment=NSTextAlignmentLeft;
    [_passWordTextField setSecureTextEntry:YES];
    UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 60, 50);
    UILabel *lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, 1.5, 30)];
    lineLabel.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [btn addSubview:lineLabel];
    [btn setTitle:@"显示" forState:0];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.selected=YES;
    [btn addTarget:self action:@selector(accordingBtn1Click:) forControlEvents:UIControlEventTouchUpInside];
    _passWordTextField.rightView=btn;
    _passWordTextField.rightViewMode=UITextFieldViewModeAlways;
    //设置开始编辑时候，提供清空按钮
    _passWordTextField.clearsOnBeginEditing=YES;
    _passWordTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    _passWordTextField.delegate=self;
    [self.view addSubview:_passWordTextField];
    
    _NewPassWordTextField=[[UITextField alloc]initWithFrame:CGRectMake(20, 200, SCREEN_WIDTH-40, 50*SCREEN_HEIGHTSCALE)];
    [_NewPassWordTextField.layer setBorderWidth:1.5];
    _NewPassWordTextField.layer.cornerRadius=5;
    [_NewPassWordTextField.layer setBorderColor:[UIColor groupTableViewBackgroundColor].CGColor];
    _NewPassWordTextField.font=[UIFont systemFontOfSize:16];
    _NewPassWordTextField.placeholder=@"请输入不少于6位数字的新密码";
    _NewPassWordTextField.textAlignment=NSTextAlignmentLeft;
    UIButton * btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame=CGRectMake(0, 0, 60, 50);
    UILabel *lineLabel2=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, 1.5, 30)];
    lineLabel2.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [btn2 addSubview:lineLabel2];
    [btn2 setTitle:@"显示" forState:0];
    [btn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn2.selected=YES;
    [btn2 addTarget:self action:@selector(accordingBtn2Click:) forControlEvents:UIControlEventTouchUpInside];
    _NewPassWordTextField.rightView=btn2;
    _NewPassWordTextField.rightViewMode=UITextFieldViewModeAlways;
    //设置开始编辑时候，提供清空按钮
    _NewPassWordTextField.clearsOnBeginEditing=YES;
    _NewPassWordTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    _NewPassWordTextField.delegate=self;
    [self.view addSubview:_NewPassWordTextField];
    UIButton *confirmBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, 290, SCREEN_WIDTH-40, 50)];
    confirmBtn.backgroundColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    confirmBtn.layer.cornerRadius=5;
    [confirmBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
    UIButton *btn3=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, 380*SCREEN_HEIGHTSCALE, 200, 16)];
    [btn3 setTitle:@"忘记密码?" forState:UIControlStateNormal];
    btn3.titleLabel.font=[UIFont systemFontOfSize:16];
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(Btn3Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
}
-(void)confirmBtnClick{
    //这种方式也可以让键盘消失。
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    if (self.passWordTextField.text==nil||self.NewPassWordTextField.text==nil) {
        [MBHelper showHUDViewWithTextForFooterView:@"请填写密码"withHUDColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.36]withDur:1.0];
    }else if (self.passWordTextField.text==nil){
    [MBHelper showHUDViewWithTextForFooterView:@"请填写旧密码"withHUDColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.36]withDur:1.0];
    }else{
    [MBHelper showHUDViewWithTextForFooterView:@"请填写新密码"withHUDColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.36]withDur:1.0];
        if (self.NewPassWordTextField.text.length<6) {
            [MBHelper showHUDViewWithTextForFooterView:@"请输入不少于6位数字的新密码"withHUDColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.36]withDur:1.0];
        }
    }
    NSString *phoneNumber=[[NSUserDefaults standardUserDefaults]objectForKey:@"PhoneNumber"];
    NSDictionary *dic=@{@"phoneNumber":phoneNumber,@"oldPwd":self.passWordTextField.text,@"pwd":self.NewPassWordTextField.text,@"type":@"2"};
        [[NetDataEngin sharedInstance]requestHomeParamter: dic Atpage:nil WithURL:SETPASSWORD success:^(id responsData) {
            NSDictionary *dic=responsData;
            NSInteger status=[dic[@"status"] integerValue];
            if (status==200) {
                [MBHelper showHUDViewWithTextForFooterView:@"修改密码成功"withHUDColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.36]withDur:1.0];
//                LoginViewController *login=[[LoginViewController alloc]init];
//                [self.navigationController pushViewController:login animated:YES];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else if (status==204){
                _promptLabel=[[UILabel alloc]initWithFrame:CGRectMake(35, 174, SCREEN_WIDTH-70, 16)];
                _promptLabel.font=[UIFont systemFontOfSize:16];
                _promptLabel.textColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
                _promptLabel.text=@"您输入的旧密码不正确";
            }else{
            [MBHelper showHUDViewWithTextForFooterView:@"修改密码失败"withHUDColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.36]withDur:1.0];
            }
            
        } failed:^(NSError *error) {
    [MBHelper showHUDViewWithTextForFooterView:@"修改密码失败"withHUDColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.36]withDur:1.0];
        }];
    
}
-(void)accordingBtn1Click:(UIButton *)sender{
    if (sender.selected==YES) {
        sender.selected=NO;
        [_passWordTextField setSecureTextEntry:NO];
    }else{
        sender.selected=YES;
    [_passWordTextField setSecureTextEntry:YES];
    }
}
-(void)accordingBtn2Click:(UIButton *)sender{
    if (sender.selected==YES) {
        sender.selected=NO;
        [_NewPassWordTextField setSecureTextEntry:NO];
    }else{
        sender.selected=YES;
        [_NewPassWordTextField setSecureTextEntry:YES];
    }
}
-(void)Btn3Click{
    RegisterViewController *registerVC=[[RegisterViewController alloc]init];
    registerVC.titleStr=@"找回密码";
    registerVC.typeId=@"2";
    [self.navigationController pushViewController:registerVC animated:YES];
    
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
