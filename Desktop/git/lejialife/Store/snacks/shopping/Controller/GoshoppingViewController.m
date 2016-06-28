//
//  GoshoppingViewController.m
//  LejiaLife
//
//  Created by 张强 on 16/3/30.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "GoshoppingViewController.h"
#import "ShoppingCartViewController.h"
#import "AppDelegate.h"
#import "OrderViewController.h"
#import "SnacksDetailViewController.h"
#import "GoshoppingTableViewCell.h"
#import "AddressViewController.h"
#import "GoshoppingCellModel.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "OrderViewController.h"
@interface GoshoppingViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIScrollViewDelegate,WXApiDelegate>
@property(nonatomic)UITableView *tableView;
@property(nonatomic)UILabel *actualPriceLabel;
@property(nonatomic)UILabel *nameLabel;
@property(nonatomic)UILabel *telePhoneLabel;
@property(nonatomic)UILabel *addressLabel;

@property(nonatomic)UITextField *scoreTextfield;
@property(nonatomic)UILabel *scorePriceLabel;
@property(nonatomic)int trueScore;
@property(nonatomic)UILabel *judgeLabel;
@property(nonatomic)int mostScore;
@property(nonatomic)UIView *resultView;

@property(nonatomic,retain)NSDictionary *payResultDic;
@end

@implementation GoshoppingViewController
#pragma mark - tabBar隐藏
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([WXApi isWXAppInstalled]) // 判断 用户是否安装微信
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"ORDER_PAY_NOTIFICATION" object:nil];//监听一个通知
    }
}
#pragma mark - tabbar还原
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];//移除通知
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self creatTitleViews];
    [self creatBottomView];
    [self creatTableViews];
    [self creatTableViewheadView];
    _mostScore=0;
    [self creatTableViewFootView];
}
//定制导航栏
-(void)creatTitleViews{
    self.navigationController.navigationBarHidden=YES;
    UIView *TitleVIew=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    UILabel *lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 63, SCREEN_WIDTH, 1)];
    lineLabel.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [TitleVIew addSubview:lineLabel];
    TitleVIew.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:TitleVIew];
    UIButton *returnBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 74)];
    [returnBtn setImage:[UIImage imageNamed:@"return_icon"] forState:UIControlStateNormal];
    [returnBtn setImageEdgeInsets:UIEdgeInsetsMake(15, -30, 5, 15)];
    [returnBtn addTarget:self action:@selector(Btnreturn) forControlEvents:UIControlEventTouchUpInside];
    [TitleVIew addSubview:returnBtn];
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 30, 100, 20)];
    titleLabel.text=@"订单确定";
    titleLabel.font=[UIFont systemFontOfSize:23.0f];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.textColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    [TitleVIew addSubview:titleLabel];
}
//导航栏返回按钮
-(void)Btnreturn{
    for (UINavigationController *nav in self.navigationController.viewControllers) {
        if (self.isOrderPush==NO) {
            if ([nav isKindOfClass:[ShoppingCartViewController class]]) {
                [self.navigationController popToViewController:nav animated:YES];
            }
            else{
            if ([nav isKindOfClass:[OrderViewController class]]) {
                [self.navigationController popToViewController:nav animated:YES];
            }
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }else{
          [self.navigationController popToRootViewControllerAnimated:YES];

        }
    }
}
//定制底部视图
-(void)creatBottomView{
    GoshoppingModel *model=[self.HeadFootdataSouceArray objectAtIndex:0];
    UIButton *weChat=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100, SCREEN_HEIGHT-49, 100, 49)];
    weChat.backgroundColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    [weChat setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [weChat setTitle:@"去付款" forState:UIControlStateNormal];
    weChat.titleLabel.font=[UIFont systemFontOfSize:16];
    [weChat addTarget:self action:@selector(weChatClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weChat];
    _actualPriceLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH-100, 49)];
    _actualPriceLabel.textColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    _actualPriceLabel.textAlignment=NSTextAlignmentCenter;
    _actualPriceLabel.font=[UIFont systemFontOfSize:16];
    _trueScore=0;
    _actualPriceLabel.text=[NSString stringWithFormat:@"实际支付：%.2f元",[model.truePrice floatValue]/100- _trueScore];
    [self.view addSubview:_actualPriceLabel];
}
-(void)weChatClick{
    GoshoppingModel *model=[self.HeadFootdataSouceArray objectAtIndex:0];
    if ([model.location isEqualToString:@"请填写收货地址"]) {
        [MBHelper showHUDViewWithTextForFooterView:@"请填写您的收货地址" withHUDColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.36]withDur:1.5];
    }else{
        GoshoppingModel *model=[self.HeadFootdataSouceArray objectAtIndex:0];
        NSDictionary *dic=@{@"orderId":model.orderid,@"truePrice":model.truePrice,@"trueScore":[NSString stringWithFormat:@"%d", _mostScore ]};
        [[NetDataEngin sharedInstance]requestHomeParamter:dic Atpage:nil WithURL:WXPAY success:^(id responsData) {
            NSLog(@"%@",responsData);
            //微信支付
            NSDictionary *responsDatadic=responsData;
            NSInteger status=[responsDatadic[@"status"] integerValue];
            if (status==200) {
                NSDictionary *dataDic=responsData[@"data"];
                PayReq *request = [[PayReq alloc] init];
                //request.
                request.partnerId = dataDic[@"partnerid"];
                request.prepayId= dataDic[@"prepayid"];
                request.package = dataDic[@"package"];
                request.nonceStr= dataDic[@"noncestr"];
                request.timeStamp= [dataDic[@"timestamp"] intValue];
                request.sign= dataDic[@"sign"];
                [WXApi sendReq:request];
            }else{
                [MBHelper showHUDViewWithTextForFooterView:responsDatadic[@"msg"] withHUDColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.36]withDur:1.0];
            }
        } failed:^(NSError *error) {
            
        }];
    }
}
//微信回调

-(void)getOrderPayResult:(NSNotification *)notification{
    if ([notification.object isEqualToString:@"fail"]) {
        [self payFailt];
    }else{
        [self paySuccess];
    }
}
-(void)paySuccess{
    NSDictionary *sendDic=@{@"orderId": self.HeadFootdataSouceArray[0].orderid};
    [[NetDataEngin sharedInstance]creatOrderParamter:sendDic WithURL:PAYSUCCESS success:^(id responsData){
        NSDictionary *responsDatadic=responsData;
        NSInteger status=[responsDatadic[@"status"] integerValue];
        if (status==200) {
            NSLog(@"支付成功");
            _payResultDic=responsDatadic[@"data"];
            
            
            [self creatSuccessResultView];
        }else{
            [MBHelper showHUDViewWithTextForFooterView:responsDatadic[@"msg"] withHUDColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.36]withDur:1.0];
        }
    } failed:^(NSError *error) {
        NSLog(@"生成订单失败");
        
    }];
}
-(void)creatSuccessResultView{
    _resultView=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _resultView.backgroundColor=[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.8];
    UIImageView *imagV=[[UIImageView alloc]initWithFrame:CGRectMake(10, SCREEN_HEIGHT/3-50, SCREEN_WIDTH-20, 180)];
    imagV.image=[UIImage imageNamed:@"red_success.png"];
    [_resultView addSubview:imagV];
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 40)];
    label1.textColor=[UIColor whiteColor];
    label1.font=[UIFont systemFontOfSize:30];
    label1.textAlignment=NSTextAlignmentCenter;
    label1.text=[NSString stringWithFormat:@"￥%.2f",[_payResultDic[@"payBackScore"] floatValue]/100];
    [imagV addSubview:label1];
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 10)];
    label2.textColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    label2.font=[UIFont systemFontOfSize:15];
    label2.textAlignment=NSTextAlignmentCenter;
    label2.text=[NSString stringWithFormat:@"￥您在乐+商城消费获得%.2f元红包",[_payResultDic[@"totoalScore"] floatValue]/100];
    [imagV addSubview:label2];
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(0, 120, SCREEN_WIDTH, 10)];
    label3.textColor=[UIColor blackColor];
    label3.font=[UIFont systemFontOfSize:15];
    label3.textAlignment=NSTextAlignmentCenter;
    label3.text=@"已存入红包余额";
    [imagV addSubview:label3];
    UILabel *label4=[[UILabel alloc]initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, 10)];
    label4.textColor=[UIColor blackColor];
    label4.font=[UIFont systemFontOfSize:15];
    label4.textAlignment=NSTextAlignmentCenter;
    label4.text=@"可在乐+商户消费";
    [imagV addSubview:label4];
    UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(25, SCREEN_HEIGHT/3+171, SCREEN_WIDTH/2-25-10, 50)];
    btn1.backgroundColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    [btn1 setTitle:@"查看订单" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
    [_resultView addSubview:btn1];
    UIButton *btn2=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+10, SCREEN_HEIGHT/3+171, SCREEN_WIDTH/2-25-10, 50)];
    //btn2.backgroundColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    btn2.layer.borderWidth=1.5;
    btn2.layer.borderColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1].CGColor;
    [btn2 setTitle:@"继续逛逛" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
    [_resultView addSubview:btn2];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.window addSubview:_resultView];
}
-(void)payFailt{
    _resultView=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _resultView.backgroundColor=[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.8];
    UIImageView *imagV=[[UIImageView alloc]initWithFrame:CGRectMake(30, SCREEN_HEIGHT/3-40, SCREEN_WIDTH-60, 150)];
    imagV.image=[UIImage imageNamed:@"red_fail.png"];
    [_resultView addSubview:imagV];
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/3+120, SCREEN_WIDTH, 20)];
    label1.text=@"您本次付款失败了";
    label1.font=[UIFont systemFontOfSize:17];
    label1.textColor=[UIColor whiteColor];
    label1.textAlignment=NSTextAlignmentCenter;
    [_resultView addSubview:label1];
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/3+155, SCREEN_WIDTH, 20)];
    label2.text=@"请在半小时内完成付款";
    label2.font=[UIFont systemFontOfSize:17];
    label2.textColor=[UIColor whiteColor];
    label2.textAlignment=NSTextAlignmentCenter;
    [_resultView addSubview:label2];
    UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(25, SCREEN_HEIGHT/3+190, SCREEN_WIDTH/2-25-10, 50)];
    btn1.backgroundColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    [btn1 setTitle:@"查看订单" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btn3Click) forControlEvents:UIControlEventTouchUpInside];
    [_resultView addSubview:btn1];
    UIButton *btn2=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+10, SCREEN_HEIGHT/3+190, SCREEN_WIDTH/2-25-10, 50)];
    //btn2.backgroundColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    btn2.layer.borderWidth=1.5;
    btn2.layer.borderColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1].CGColor;
    [btn2 setTitle:@"重新付款" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btn4Click) forControlEvents:UIControlEventTouchUpInside];
    [_resultView addSubview:btn2];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.window addSubview:_resultView];
}

-(void)btn1Click{
    [_resultView removeFromSuperview];
    OrderViewController *orderVC=[[OrderViewController alloc]init];
    [self.navigationController pushViewController:orderVC animated:YES];
}
-(void)btn2Click{
    [_resultView removeFromSuperview];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)btn3Click{
    [_resultView removeFromSuperview];
    OrderViewController *orderVC=[[OrderViewController alloc]init];
    [self.navigationController pushViewController:orderVC animated:YES];
}
-(void)btn4Click{
    [_resultView removeFromSuperview];
}
//*****************************************************************************************************
-(void)creatTableViews{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49) style:UITableViewStylePlain];
    _tableView.backgroundColor=[UIColor colorWithRed:222.0/250.0 green:222.0/250.0 blue:222.0/250.0 alpha:1];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [_tableView registerClass:[GoshoppingTableViewCell class] forCellReuseIdentifier:@"xxx"];
    [self.view addSubview:_tableView];
    
}
//tableVIew 头部视图
-(void)creatTableViewheadView{
    GoshoppingModel *model=[self.HeadFootdataSouceArray objectAtIndex:0];
    UIButton *headViewBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 63)];
    headViewBtn.backgroundColor=[UIColor whiteColor];
    [headViewBtn addTarget:self action:@selector(headViewBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *imagV=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-25, 24, 10, 15)];
    imagV.image=[UIImage imageNamed:@"choice_iconn.png"];
    [headViewBtn addSubview:imagV];
    self.nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 16, 50, 10)];
    self.nameLabel.font=[UIFont systemFontOfSize:12];
    self.nameLabel.text=model.name;
    self.telePhoneLabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 16, SCREEN_WIDTH-100, 10)];
    self.telePhoneLabel.text=model.phoneNumber;
    self.telePhoneLabel.font=[UIFont systemFontOfSize:12];
    self.addressLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 36, SCREEN_WIDTH, 12)];
    self.addressLabel.font=[UIFont systemFontOfSize:12];
    self.addressLabel.text=[NSString stringWithFormat:@"%@%@%@%@",model.province,model.city,model.country,model.location];
    self.addressLabel.textColor=[UIColor colorWithRed:140.0/250.0 green:140.0/250.0 blue:140.0/250.0 alpha:1];
    [headViewBtn addSubview:self.nameLabel];
    [headViewBtn addSubview:self.telePhoneLabel];
    [headViewBtn addSubview:self.addressLabel];
    self.tableView.tableHeaderView=headViewBtn;
}
//推进编辑地址控制器
-(void)headViewBtnClick{
    AddressViewController *address=[[AddressViewController alloc]init];
    address.isGoshoppingPush=YES;
    [self.navigationController pushViewController:address animated:YES];
}
//tableVIew脚步视图
-(void)creatTableViewFootView{
    GoshoppingModel *model=[self.HeadFootdataSouceArray objectAtIndex:0];
    UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220)];
    footView.backgroundColor=[UIColor colorWithRed:222.0/250.0 green:222.0/250.0 blue:222.0/250.0 alpha:1];
    UIView *View=[[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 210)];
    View.backgroundColor=[UIColor whiteColor];
    [footView addSubview:View];
    NSArray *array=@[@"总价",@"邮费",@"支付方式"];
    for (int i=0; i<3; i++) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 42+i*42, SCREEN_WIDTH, 1)];
        label.backgroundColor=[UIColor colorWithRed:222.0/250.0 green:222.0/250.0 blue:222.0/250.0 alpha:1];
        [View addSubview:label];
        UILabel *textLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, i*42, 80, 42)];
        textLabel.font=[UIFont systemFontOfSize:12];
        textLabel.text=[array objectAtIndex:i];
        [View addSubview:textLabel];
    }
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(151, 0, SCREEN_WIDTH, 42)];
    label1.font=[UIFont systemFontOfSize:12];
    label1.text=[NSString stringWithFormat:@"%.2f元",[model.totalPrice floatValue]/100];
    [View addSubview:label1];
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(151, 42, SCREEN_WIDTH, 42)];
    label2.font=[UIFont systemFontOfSize:12];
    label2.text=[NSString stringWithFormat:@"%.2f元",[model.freightPrice floatValue]/100];
    [View addSubview:label2];
    UIImageView *weChatIcon=[[UIImageView alloc]initWithFrame:CGRectMake(151, 95, 20, 20)];
    weChatIcon.image=[UIImage imageNamed:@"wechat"];
    [View addSubview:weChatIcon];
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(188, 84, SCREEN_WIDTH, 42)];
    label3.font=[UIFont systemFontOfSize:12];
    label3.text=[NSString stringWithFormat:@"微信支付"];
    [View addSubview:label3];
    UILabel *label4=[[UILabel alloc]initWithFrame:CGRectMake(20, 130, SCREEN_WIDTH, 42)];
    label4.font=[UIFont systemFontOfSize:12];
    label4.text=[NSString stringWithFormat:@"积分抵扣"];
    [View addSubview:label4];
    _judgeLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 180, SCREEN_WIDTH, 42)];
    _judgeLabel.font=[UIFont systemFontOfSize:12];
    _judgeLabel.textColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    if ([model.scoreB intValue]>=[model.totalScore intValue]) {
        _mostScore=[model.totalScore intValue];
        _judgeLabel.text=[NSString stringWithFormat:@"积分余额：%@             该订单最多可使用%d积分",model.scoreB,_mostScore];
    }else{
        _mostScore=[model.scoreB intValue];
    _judgeLabel.text=[NSString stringWithFormat:@"积分余额：%@             该订单最多可使用%d积分",model.scoreB,_mostScore];
    }
    _scoreTextfield=[[UITextField alloc]initWithFrame:CGRectMake(151, 140, 80, 25)];
    _scoreTextfield.layer.cornerRadius=3;
    _scoreTextfield.clipsToBounds=YES;
    _scoreTextfield.keyboardType=UIKeyboardTypePhonePad;
    _scoreTextfield.delegate=self;
    _scoreTextfield.textAlignment=NSTextAlignmentCenter;
    [_scoreTextfield.layer setBorderWidth:1];
    [_scoreTextfield.layer setBorderColor:[UIColor blackColor].CGColor];
    _scoreTextfield.font=[UIFont systemFontOfSize:12];
    _scoreTextfield.text=[NSString stringWithFormat:@"%d", _trueScore ];
    [View addSubview:_scoreTextfield];
    _scorePriceLabel=[[UILabel alloc]initWithFrame:CGRectMake(235, 130, SCREEN_WIDTH-277, 42)];
    _scorePriceLabel.font=[UIFont systemFontOfSize:12];
    _scorePriceLabel.text=[NSString stringWithFormat:@"积分=%@元",_scoreTextfield.text];
    [View addSubview:_scorePriceLabel];
    [View addSubview:_judgeLabel];
    self.tableView.tableFooterView=footView;

}
//*****************************************tableView代理方法*******************************************
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSouceArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125*SCREEN_HEIGHTSCALE;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GoshoppingTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"xxx" forIndexPath:indexPath];
    if (cell==nil) {
        cell=[[GoshoppingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"xxx"];
    }
    GoshoppingCellModel *model=[self.dataSouceArray objectAtIndex:indexPath.row];
    cell.nameLabel.text=model.name;
    cell.testLabel.text=model.space;
    [cell.imagV sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"placeholder1"]];
    cell.priceLabel.text=[NSString stringWithFormat:@"￥%.2f",[model.price floatValue]/100 ];
    cell.numberLabe.text=model.number;
    cell.backgroundColor=[UIColor colorWithRed:222.0/250.0 green:222.0/250.0 blue:222.0/250.0 alpha:1];
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
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
    GoshoppingModel *model=[self.HeadFootdataSouceArray objectAtIndex:0];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    if ([_scoreTextfield.text intValue]>=_mostScore) {
        _trueScore=_mostScore;
        _scoreTextfield.text=[NSString stringWithFormat:@"%d", _trueScore ];
    }else{
        _trueScore=[_scoreTextfield.text intValue];
    _scorePriceLabel.text=[NSString stringWithFormat:@"积分=%d元",_trueScore];
    }
    _actualPriceLabel.text=[NSString stringWithFormat:@"实际支付：%.2f",[model.truePrice floatValue]/100-_trueScore];
    return YES;
}
//用户点击了键盘的return按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //在此处实现return按钮的功能。
    return YES;
}
//每次内容发送变化都会被调用。
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
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
