//
//  RegisterViewController.m
//  LejiaLife
//
//  Created by 张强 on 16/4/28.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "NetDataEngin.h"
#import "VerificationViewController.h"
@interface RegisterViewController ()<UITextFieldDelegate>
@property(nonatomic)UITextField *phoneNumberTextField;
@property(nonatomic)UIButton *obtainBtn;
@end

@implementation RegisterViewController

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
//    [self dismissViewControllerAnimated:YES completion:nil];
//    LoginViewController *login=[[LoginViewController alloc]init];
//    [self.navigationController pushViewController:login animated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)creatViews{
    _phoneNumberTextField=[[UITextField alloc]initWithFrame:CGRectMake(20, 114, SCREEN_WIDTH-40, 50*SCREEN_HEIGHTSCALE)];
    [self.view addSubview:_phoneNumberTextField];
    [_phoneNumberTextField.layer setBorderWidth:1.5];
    _phoneNumberTextField.layer.cornerRadius=5;
    [_phoneNumberTextField.layer setBorderColor:[UIColor groupTableViewBackgroundColor].CGColor];
    _phoneNumberTextField.font=[UIFont systemFontOfSize:16];
    _phoneNumberTextField.placeholder=@"请输入您的手机号码";
    _phoneNumberTextField.textAlignment=NSTextAlignmentLeft;
    //设置开始编辑时候，提供清空按钮
    _phoneNumberTextField.clearsOnBeginEditing=YES;
    _phoneNumberTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    _phoneNumberTextField.keyboardType=UIKeyboardTypePhonePad;
    _phoneNumberTextField.delegate=self;
    _obtainBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, 134+50*SCREEN_HEIGHTSCALE, SCREEN_WIDTH-40, 50*SCREEN_HEIGHTSCALE)];
    [self.view addSubview:_obtainBtn];
    _obtainBtn.backgroundColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    [_obtainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _obtainBtn.layer.cornerRadius=5;
    
    [_obtainBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_obtainBtn addTarget:self action:@selector(obtainBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)obtainBtnClick{
    if (self.phoneNumberTextField.text.length==11) {
        NSDictionary *dic=@{@"phoneNumber":self.phoneNumberTextField.text,@"type":self.typeId};
        [[NetDataEngin sharedInstance]requestHomeParamter: dic Atpage:nil WithURL:SENDPHONENUMBER success:^(id responsData) {
            NSDictionary *dic=responsData;
            NSInteger status=[dic[@"status"] integerValue];
            if (status==200) {
                NSLog(@"验证码已发送");
                VerificationViewController *verification=[[VerificationViewController alloc]init];
                verification.titleStr=self.titleStr;
                verification.typeId=self.typeId;
                verification.phoneNumber=self.phoneNumberTextField.text;
                self.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:verification animated:YES];
                self.hidesBottomBarWhenPushed=NO;
            }else {
                [MBHelper showHUDViewWithTextForFooterView:dic[@"msg"] withHUDColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.36]withDur:1.0];
            }
            
        } failed:^(NSError *error) {
            
        }];
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
}- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
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
