//
//  ZbarPayViewController.m
//  LejiaLife
//
//  Created by 张强 on 16/6/3.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "ZbarPayViewController.h"
#import "ZbarPayDetailViewController.h"
@interface ZbarPayViewController ()
@property(nonatomic)UILabel *flagLabel;
@property(nonatomic)UILabel *nameLabel;
@property(nonatomic)UILabel *leftLabel;
@property(nonatomic)UILabel *rightLabel;
@property(nonatomic)UITextField *textField;
@property(nonatomic)UIButton *Btn;
@end

@implementation ZbarPayViewController
-(void)viewWillAppear:(BOOL)animated{
    [_textField becomeFirstResponder];
    [MobClick beginLogPageView:@"ZbarPayone"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:240.0/250.0 green:240.0/250.0 blue:240.0/250.0 alpha:1];
    [self creatTitleView];
    [self creatView];
}
//导航栏视图
-(void)creatTitleView{
    self.navigationController.navigationBarHidden=YES;
    UIView *TitleVIew=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    TitleVIew.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:TitleVIew];
    UIButton *returnBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 74)];
    [returnBtn setImage:[UIImage imageNamed:@"return_icon"] forState:UIControlStateNormal];
    [returnBtn setImageEdgeInsets:UIEdgeInsetsMake(15, 20, 5, 15)];
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
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)creatView{
    _flagLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 84, SCREEN_WIDTH, 10)];
    _flagLabel.textColor=[UIColor colorWithRed:140.0/250.0 green:140.0/250.0 blue:140.0/250.0 alpha:1];
    _flagLabel.textAlignment=NSTextAlignmentCenter;
    _flagLabel.font=[UIFont systemFontOfSize:13];
    _flagLabel.text=@"乐+签约商户";
    [self.view addSubview:_flagLabel];
    _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 114, SCREEN_WIDTH, 10)];
    _nameLabel.textColor=[UIColor blackColor];
    _nameLabel.textAlignment=NSTextAlignmentCenter;
    _nameLabel.font=[UIFont systemFontOfSize:17];
    _nameLabel.text=@"棉花糖KTV";
    [self.view addSubview:_nameLabel];
    _textField=[[UITextField alloc]initWithFrame:CGRectMake(20, 154, SCREEN_WIDTH-40, 50*SCREEN_HEIGHTSCALE)];

    _textField.layer.cornerRadius=5;
    _textField.backgroundColor=[UIColor whiteColor];
    AFFNumericKeyboard *keyboard = [[AFFNumericKeyboard alloc] initWithFrame:CGRectMake(0, 200, 320, 216)];
    self.textField.inputView = keyboard;
    keyboard.delegate = self;
    _textField.font=[UIFont systemFontOfSize:16];
    //设置开始编辑时候，提供清空按钮
    _textField.clearsOnBeginEditing=YES;
    _textField.clearButtonMode=UITextFieldViewModeWhileEditing;
    _textField.placeholder=@"问问收银员应付多少钱 ?";
    _textField.textAlignment=NSTextAlignmentRight;
    _leftLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 50*SCREEN_HEIGHTSCALE)];
    _leftLabel.textColor=[UIColor blackColor];
    _leftLabel.text=@"消费金额(元):";
    _leftLabel.font=[UIFont systemFontOfSize:15];
    [_textField addSubview:_leftLabel];
    [self.view addSubview:_textField];
    _rightLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 210, SCREEN_WIDTH-40, 10)];
    _rightLabel.textColor=[UIColor  colorWithRed:209.0/250.0 green:50.0/250.0 blue:53.0/250.0 alpha:1];
    _rightLabel.font=[UIFont systemFontOfSize:12];
    _rightLabel.textAlignment=NSTextAlignmentRight;
    _rightLabel.text=@"本笔交易百分之百返红包";
    [self.view addSubview:_rightLabel];
    _Btn=[[UIButton alloc]initWithFrame:CGRectMake(20, 240*SCREEN_HEIGHTSCALE, SCREEN_WIDTH-40, 50*SCREEN_HEIGHTSCALE)];
    _Btn.layer.cornerRadius=5;
    _Btn.backgroundColor=[UIColor colorWithRed:209.0/250.0 green:50.0/250.0 blue:53.0/250.0 alpha:1];
    [_Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_Btn setTitle:@"确认支付" forState:UIControlStateNormal];
    _Btn.titleLabel.font=[UIFont systemFontOfSize:16];
    [_Btn addTarget:self action:@selector(BtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_Btn];
}
-(void)BtnClick{
    ZbarPayDetailViewController *detail=[[ZbarPayDetailViewController alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma mark - textField代理方法 -

-(void)numberKeyboardBackspace
{
    if (self.textField.text.length != 0)
    {
        self.textField.text = [self.textField.text substringToIndex:self.textField.text.length -1];
    }
}

-(void)numberKeyboardInput:(NSInteger)number
{
    self.textField.text = [self.textField.text stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)number]];
    NSMutableString *str=[[NSMutableString alloc] initWithString:_textField.text];
    if ([[str substringToIndex:1] intValue]==0&&str.length==2) {
        if ([[str substringToIndex:2] isEqualToString:@"."]==NO) {
            NSRange range = [str rangeOfString:@"0"];
            [str deleteCharactersInRange:range];
            _textField.text=str;
        }
    }
    if ([[str substringToIndex:1] intValue]==0&&str.length==5) {
        NSString *str2=[str substringToIndex:[str length]-1];
        _textField.text=str2;
    }
    if ([str floatValue]>=9999.99) {
        _textField.text=@"9999.99";
        [MBHelper showHUDViewWithTextForCenterView:@"单笔交易限额9999.99" withDur:1.0 withHUDColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.36]];
    }
    
    NSLog(@"%ld",(long)number);
}
-(void)pointNumberKeyboardInput{
    if ([_textField.text isEqual:@""]) {
        _textField.text=@"";
    }else{
        self.textField.text = [self.textField.text stringByAppendingString:@"."];
    }
    NSMutableString *str=[[NSMutableString alloc] initWithString:_textField.text];
    if (str.length>=2) {
        NSString *temp = nil;
        int a=0;
        for(int i =0; i < [str length]; i++)
        {
            temp = [str substringWithRange:NSMakeRange(i, 1)];
            if ([temp isEqualToString:@"."]) {
                a++;
            }
            if (a==2) {
                NSString *str2=[str substringToIndex:[str length]-1];
                NSLog(@"%@",str2);
                _textField.text=str2;
            }
        }
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [MobClick endLogPageView:@"ZbarPayone"];
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
