//
//  ZbarPayDetailViewController.m
//  LejiaLife
//
//  Created by 张强 on 16/6/3.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "ZbarPayDetailViewController.h"
#import "TradingViewController.h"
@interface ZbarPayDetailViewController ()
@property(nonatomic)UILabel *flagLabel;
@property(nonatomic)UILabel *nameLabel;
@property(nonatomic)UILabel *leftLabel;
@property(nonatomic)UILabel *rightLabel;
@property(nonatomic)UITextField *textField;
@property(nonatomic)UIButton *Btn;
@end

@implementation ZbarPayDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [_textField becomeFirstResponder];
    [MobClick beginLogPageView:@"ZbarPaytwo"];
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
    _textField.textAlignment=NSTextAlignmentRight;
    _leftLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 50*SCREEN_HEIGHTSCALE)];
    _leftLabel.textColor=[UIColor blackColor];
    _leftLabel.text=@"使用红包";
    _leftLabel.font=[UIFont systemFontOfSize:15];
    [_textField addSubview:_leftLabel];
    [self.view addSubview:_textField];
    _textField.text=[NSString stringWithFormat:@"￥%.2f",8.00];
    _rightLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 210, SCREEN_WIDTH-40, 10)];
    _rightLabel.textColor=[UIColor  colorWithRed:209.0/250.0 green:50.0/250.0 blue:53.0/250.0 alpha:1];
    _rightLabel.font=[UIFont systemFontOfSize:12];
    _rightLabel.textAlignment=NSTextAlignmentRight;
    _rightLabel.text=[NSString stringWithFormat:@"您有￥%.2f红包余额",8.00];
    [self.view addSubview:_rightLabel];
    UILabel *lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 250, SCREEN_WIDTH-40, 1.5)];
    lineLabel.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.view addSubview:lineLabel];
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(20, 270, SCREEN_WIDTH/2-20, 10)];
    label1.text=@"还需支付";
    label1.textColor=[UIColor blackColor];
    label1.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:label1];
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 270, SCREEN_WIDTH/2-20, 15)];
    label2.text=[NSString stringWithFormat:@"￥%.2f",100.00];
    label2.textAlignment=NSTextAlignmentRight;
    label2.textColor=[UIColor blackColor];
    label2.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:label2];
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(20, 300, SCREEN_WIDTH-40, 50*SCREEN_HEIGHTSCALE)];
    btn.layer.cornerRadius=5;
    btn.backgroundColor=[UIColor colorWithRed:209.0/250.0 green:50.0/250.0 blue:53.0/250.0 alpha:1];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"确认支付" forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:16];
    [btn addTarget:self action:@selector(Btn2Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
-(void)Btn2Click{
    TradingViewController *trading=[[TradingViewController alloc]init];
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:trading animated:YES];
    self.hidesBottomBarWhenPushed=NO;
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
    [MobClick endLogPageView:@"ZbarPaytwo"];
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
