//
//  VerificationViewController.m
//  LejiaLife
//
//  Created by 张强 on 16/4/29.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "VerificationViewController.h"
#import "LoginViewController.h"
#import "LoginPassWordViewController.h"
@interface VerificationViewController ()<UITextFieldDelegate>
@property(nonatomic)NSString *timeStr;
@property(nonatomic)UITextField *textField;
@property(nonatomic)int secondsCountDown; //倒计时总时长
@property(nonatomic)NSTimer *countDownTimer;
@property(nonatomic)UILabel *timeLabel;
@property(nonatomic)UIButton *repeatBtn;
@end

@implementation VerificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self creatTitleView];
    [self creatViews];
    [self receiveCheckNumButton];
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
-(void)close{
//    LoginViewController *login=[[LoginViewController alloc]init];
//    [self.navigationController po];
//    for (UINavigationController *nav in self.navigationController.viewControllers) {
//        if ([nav isKindOfClass:[LoginViewController class]]) {
//            [self.navigationController popToViewController:nav animated:YES];
//        }
//    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)Btnreturn{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)creatViews{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20, 84, SCREEN_WIDTH-40, 40)];
    label.font=[UIFont systemFontOfSize:16];
    label.text=[NSString stringWithFormat:@"您的手机号：%@",self.phoneNumber];
    [self.view addSubview:label];
    _textField=[[UITextField alloc]initWithFrame:CGRectMake(20, 134, SCREEN_WIDTH/2, 50)];
    _textField.placeholder=@"请输入验证码";
    _textField.textAlignment=NSTextAlignmentLeft;
    _textField.layer.cornerRadius=5;
    [_textField.layer setBorderWidth:1.5];
    [_textField.layer setBorderColor:[UIColor groupTableViewBackgroundColor].CGColor];
    //设置开始编辑时候，提供清空按钮
    _textField.clearsOnBeginEditing=YES;
    _textField.clearButtonMode=UITextFieldViewModeWhileEditing;
    _textField.keyboardType=UIKeyboardTypePhonePad;
    _textField.delegate=self;
    [self.view addSubview:_textField];
    //倒计时button
    _repeatBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/2+50, 131, SCREEN_WIDTH/2-50-20, 50)];
    
    _repeatBtn.backgroundColor = [UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    
    [_repeatBtn setTitle:@"获取验证码"forState:UIControlStateNormal];
    
    [_repeatBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _repeatBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    _repeatBtn.layer.cornerRadius =5;
    
    _repeatBtn.layer.masksToBounds =YES;
    
    _repeatBtn.alpha =0.3;
    
    [_repeatBtn addTarget:self action:@selector(receiveCheckNumButton)forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_repeatBtn];
    
    UIButton *commitBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, 224, SCREEN_WIDTH-40, 50)];
    commitBtn.backgroundColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    commitBtn.layer.cornerRadius=5;
    [commitBtn setTitle:@"提交验证码" forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitBtn];
}
- (void)receiveCheckNumButton{
    
    __block int timeout=60;//倒计时时间
    
    dispatch_queue_t queue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL,0),1.0*NSEC_PER_SEC,0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){//倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示根据自己需求设置
                
                [_repeatBtn setTitle:@"重新获取"forState:UIControlStateNormal];
                
                _repeatBtn.userInteractionEnabled =YES;
                
                _repeatBtn.backgroundColor = [UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
                
            });
            
        }else{
            
            int seconds = timeout;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //让按钮变为不可点击的灰色
                
                _repeatBtn.backgroundColor = [UIColor grayColor];
                
                _repeatBtn.userInteractionEnabled =NO;
                
                //设置界面的按钮显示根据自己需求设置
                
                [UIView beginAnimations:nil context:nil];
                
                [UIView setAnimationDuration:1];
                
                [_repeatBtn setTitle:[NSString stringWithFormat:@"%@秒后重新获取",strTime]forState:UIControlStateNormal];
                
                [UIView commitAnimations];
                
            });
            
            timeout--;
            
        }
        
    });
    dispatch_resume(_timer);
}
-(void)commitBtnClick{
    if (self.textField.text.length==6) {
        NSDictionary *senddic=@{@"phoneNumber":self.phoneNumber,@"code":self.textField.text};
        [[NetDataEngin sharedInstance]requestHomeParamter: senddic Atpage:nil WithURL:SENDCODE success:^(id responsData) {
            NSDictionary *dic=responsData;
            NSInteger status=[dic[@"status"] integerValue];
            if (status==200) {
                LoginPassWordViewController *passWord=[[LoginPassWordViewController alloc]init];
                passWord.titleStr=self.titleStr;
                passWord.phoneNumber=self.phoneNumber;
                self.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:passWord animated:YES];
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
