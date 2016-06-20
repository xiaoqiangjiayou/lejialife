//
//  LoginViewController.m
//  LejiaLife
//
//  Created by 张强 on 16/4/28.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "LejiaLifeTabbarViewController.h"
#import "HomeViewController.h"
#import "LoginModel.h"
#import "MBHelper.h"
@interface LoginViewController ()<UITextFieldDelegate>
@property(nonatomic)UIImageView *imagV;
@property(nonatomic)UITextField *phoneNumberTextField;
@property(nonatomic)UITextField *passWordTextField;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.imagV];
    [self creatViews];
    [self creatBtns];
}
-(UIImageView*)imagV{
    if (_imagV==nil) {
        _imagV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 225*SCREEN_HEIGHTSCALE)];
        _imagV.userInteractionEnabled=YES;
        _imagV.image=[UIImage imageNamed:@"head background"];
        UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame= CGRectMake(20, 20, 60, 54);
        [btn setImage:[UIImage imageNamed:@"close_icon"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(DisBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_imagV addSubview:btn];
    }
    return _imagV;
}
-(void)creatViews{
    //登录框
    UIButton *backGroundBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    UIImageView *imagV1=[[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 20, 20)];
    imagV1.image=[UIImage imageNamed:@"telephone_icon"];
    [backGroundBtn addSubview:imagV1];
    _phoneNumberTextField=[[UITextField alloc]initWithFrame:CGRectMake(20, 235*SCREEN_HEIGHTSCALE, SCREEN_WIDTH-40, 50*SCREEN_HEIGHTSCALE)];
    [_phoneNumberTextField.layer setBorderWidth:1.5];
    _phoneNumberTextField.layer.cornerRadius=5;
    [_phoneNumberTextField.layer setBorderColor:[UIColor groupTableViewBackgroundColor].CGColor];
    _phoneNumberTextField.font=[UIFont systemFontOfSize:16];
    _phoneNumberTextField.placeholder=@"请输入您的手机号码";
    //设置开始编辑时候，提供清空按钮
    _phoneNumberTextField.clearsOnBeginEditing=YES;
    _phoneNumberTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    _phoneNumberTextField.keyboardType=UIKeyboardTypePhonePad;
    _phoneNumberTextField.delegate=self;
    _phoneNumberTextField.leftView=backGroundBtn;
    _phoneNumberTextField.leftViewMode=UITextFieldViewModeAlways;
    [self.view addSubview:self.phoneNumberTextField];
    //密码框
    _passWordTextField=[[UITextField alloc]initWithFrame:CGRectMake(20, 295*SCREEN_HEIGHTSCALE, SCREEN_WIDTH-40, 50*SCREEN_HEIGHTSCALE)];
    [_passWordTextField.layer setBorderWidth:1.5];
    _passWordTextField.layer.cornerRadius=5;
    [_passWordTextField.layer setBorderColor:[UIColor groupTableViewBackgroundColor].CGColor];
    UIButton *backGroundBtn2=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    UIImageView *imagV2=[[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 20, 20)];
    imagV2.image=[UIImage imageNamed:@"password_icon"];
    [backGroundBtn2 addSubview:imagV2];
    _passWordTextField.keyboardType=UIKeyboardTypeDefault;
//    _passWordTextField.keyboardType=UIKeyboardTypeDecimalPad ;
    _passWordTextField.leftView=backGroundBtn2;
    _passWordTextField.leftViewMode=UITextFieldViewModeAlways;
    _passWordTextField.font=[UIFont systemFontOfSize:16];
    _passWordTextField.placeholder=@"请输入您的登录密码";
    //设置开始编辑时候，提供清空按钮
    _passWordTextField.clearsOnBeginEditing=YES;
    _passWordTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    _passWordTextField.delegate=self;
    [self.view addSubview:self.passWordTextField];
}
-(void)creatBtns{
    UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100, 355*SCREEN_HEIGHTSCALE, 80, 16)];
    [btn1 setTitle:@"忘记密码?" forState:UIControlStateNormal];
    btn1.titleLabel.font=[UIFont systemFontOfSize:16];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(Btn1Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    UIButton *Btn2=[[UIButton alloc]initWithFrame:CGRectMake(20, 430*SCREEN_HEIGHTSCALE, SCREEN_WIDTH-40, 50*SCREEN_HEIGHTSCALE)];
    Btn2.layer.cornerRadius=5;
    Btn2.backgroundColor=[UIColor colorWithRed:209.0/250.0 green:50.0/250.0 blue:53.0/250.0 alpha:1];
    [Btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Btn2 setTitle:@"登录" forState:UIControlStateNormal];
    Btn2.titleLabel.font=[UIFont systemFontOfSize:16];
    [Btn2 addTarget:self action:@selector(Btn2Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Btn2];
    
    UIButton *Btn3=[[UIButton alloc]initWithFrame:CGRectMake(20, 500*SCREEN_HEIGHTSCALE, SCREEN_WIDTH-40, 50*SCREEN_HEIGHTSCALE)];
    Btn3.layer.cornerRadius=5;
    [Btn3 setTitleColor:[UIColor colorWithRed:209.0/250.0 green:50.0/250.0 blue:53.0/250.0 alpha:1] forState:UIControlStateNormal];
    [Btn3 setTitle:@"立即注册>>" forState:UIControlStateNormal];
    Btn3.titleLabel.font=[UIFont systemFontOfSize:16];
    [Btn3 addTarget:self action:@selector(Btn3Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Btn3];
}

-(void)Btn1Click{
    RegisterViewController *registerVC=[[RegisterViewController alloc]init];
    registerVC.titleStr=@"找回密码";
    registerVC.typeId=@"2";
    [self.navigationController pushViewController:registerVC animated:YES];
    
}
-(void)Btn2Click{
    NSString *phoneNumber=self.phoneNumberTextField.text;
    NSString *passWord=self.passWordTextField.text;
    NSString *token=@"123";
    NSDictionary *dic=@{@"phoneNumber":phoneNumber,@"pwd":passWord,@"token":token};
    [[NetDataEngin sharedInstance]requestHomeParamter:dic Atpage:nil WithURL:LOGIN success:^(id responsData) {
        NSDictionary *responsDatadic=responsData;
        NSInteger status=[responsDatadic[@"status"] integerValue];
        if (status==200) {
            NSLog(@"登录成功");
            //用户数据
            NSMutableDictionary *data=responsData[@"data"];
            NSString *LoginToken=data[@"token"];
            NSString *userOneBarCode=data[@"userOneBarCode"];
            NSString *scoreA=[NSString stringWithFormat:@"%@",data[@"scoreA"] ];
            NSString *scoreB=[NSString stringWithFormat:@"%@",data[@"scoreB"] ];
            NSString *headImageUrlStr=[NSString stringWithFormat:@"%@",data[@"headImageUrl"]];
            if ([headImageUrlStr isEqual:@"<null>"]) {
                NSData *imageData = UIImagePNGRepresentation([UIImage imageNamed:@"touxiang"]);
                [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"headImageUrl"];
            }else{
                NSString *headImageUrl=data[@"headImageUrl"];
                NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:headImageUrl]];
                [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"headImageUrl"];
            }
            //存储
            [[NSUserDefaults standardUserDefaults] setObject:LoginToken forKey:@"LoginToken"];
                [[NSUserDefaults standardUserDefaults] setObject:phoneNumber forKey:@"PhoneNumber"];
            [[NSUserDefaults standardUserDefaults] setObject:userOneBarCode forKey:@"userOneBarCode"];
            [[NSUserDefaults standardUserDefaults] setObject:scoreA forKey:@"scoreA"];
            [[NSUserDefaults standardUserDefaults] setObject:scoreB forKey:@"scoreB"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogin"];
            if (self.LoginUpdateBlock) {
                self.LoginUpdateBlock();
            }
            if (self.loginBlock) {
                self.loginBlock();
            }else if (self.notLoginBlock){
                self.notLoginBlock();
            }else{
                HomeViewController *home=[[HomeViewController alloc]init];
                [self.navigationController pushViewController:home animated:YES];
            }
            
        }else{
            
            [MBHelper showHUDViewWithTextForFooterView:responsDatadic[@"msg"] withHUDColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.36]withDur:1.0];
        }
    } failed:^(NSError *error) {
        
    }];
    
}
-(void)Btn3Click{
    RegisterViewController *registerVC=[[RegisterViewController alloc]init];
    registerVC.titleStr=@"注册";
    registerVC.typeId=@"1";
    [self.navigationController pushViewController:registerVC animated:YES];
}
-(void)DisBtnClick:(UIButton*)sender{
    if (self.notLoginBlock) {
        self.notLoginBlock();
    }
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *如果是已经登录了
 */
- (void)isLogin
{
    LejiaLifeTabbarViewController *rootVC = [[LejiaLifeTabbarViewController alloc] init];
    [self.navigationController pushViewController:rootVC animated:NO];
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationItem.leftBarButtonItem = nil;
}
/**
 *手机号码验证
 */
- (BOOL)validateMobile:(NSString *)mobile
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
#pragma mark - textField代理方法 -

//即将开始编辑的代理方法。
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}
//即将结束编辑
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSLog(@"ceshi");
    if (textField==self.phoneNumberTextField) {
        if ([self validateMobile:self.phoneNumberTextField.text]==YES) {
            NSLog(@"***************************正确");
        }else{
         [MBHelper showHUDViewWithTextForFooterView:@"请输入正确的手机号码"withHUDColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.36]withDur:1.0];
        }
        
    }
    NSLog(@"textFieldShouldEndEditing");
    return YES;
}
//用户点击了键盘的return按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //在此处实现return按钮的功能。
    return YES;
}
//每次内容发送变化都会被调用。
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSLog(@"range:%@",NSStringFromRange(range));
    NSLog(@"string:%@",string);
    NSLog(@"text:%@",textField.text);
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    self.hidesBottomBarWhenPushed=NO;
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
