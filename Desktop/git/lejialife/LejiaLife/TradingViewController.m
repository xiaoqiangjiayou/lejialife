//
//  TradingViewController.m
//  LejiaLife
//
//  Created by 张强 on 16/6/6.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "TradingViewController.h"

@interface TradingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic)UITableView *tableView;
@end

@implementation TradingViewController
-(void)viewWillAppear:(BOOL)animated{
    [MobClick beginLogPageView:@"Trading"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:240.0/250.0 green:240.0/250.0 blue:240.0/250.0 alpha:1];
    [self creatTitleView];
    [self.view addSubview:self.tableView];
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
    titleLabel.text=@"交易详情";
    titleLabel.font=[UIFont systemFontOfSize:20.0f];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.textColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    [TitleVIew addSubview:titleLabel];
}
-(void)Btnreturn{
    [self.navigationController popViewControllerAnimated:YES];
}
-(UITableView *)tableView{
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return (SCREEN_HEIGHT-64)*4/7;
    }else if (indexPath.row==1){
        return (SCREEN_HEIGHT-64)*1.5/7;
    }else{
        return (SCREEN_HEIGHT-64)*1.5/7;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[_tableView dequeueReusableCellWithIdentifier:@"xxx"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"xxx"];
    }
    if (indexPath.row==0) {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(20, 50, SCREEN_WIDTH-40, (SCREEN_HEIGHT-64)*4/7-50-30)];
        view.backgroundColor=[UIColor whiteColor];
        [cell addSubview:view];
        UIImageView *imagV=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-25, 20, 50, 50)];
        imagV.image=[UIImage imageNamed:@""];
        [cell addSubview:imagV];
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(view.frame.size.width/2-30, 30, 60, 10)];
        label1.font=[UIFont systemFontOfSize:13];
        label1.textColor=[UIColor blackColor];
        label1.text=@"支付成功";
        [view addSubview:label1];
        NSArray *arr=@[@"消费门店",@"消费金额",@"乐付确认码",@"支付单号",@"时间"];
        for (int i=0; i<5; i++) {
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(40, 50+i*40*SCREEN_HEIGHTSCALE, view.frame.size.width/2-40, 10)];
            label.textColor=[UIColor blackColor];
            label.font=[UIFont systemFontOfSize:10];
            label.text=[arr objectAtIndex:i];
            [view addSubview:label];
            UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(view.frame.size.width/2, 50+i*40*SCREEN_HEIGHTSCALE, view.frame.size.width/2-40, 10)];
            label2.textAlignment=NSTextAlignmentRight;
            label2.textColor=[UIColor blackColor];
            label2.font=[UIFont systemFontOfSize:10];
            label2.text=@"sdfasdhfadhfljadhf";
            [view addSubview:label2];
        }
        UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(40, 50+40*SCREEN_HEIGHTSCALE+20, view.frame.size.width-80, 10)];
        label2.textAlignment=NSTextAlignmentRight;
        label2.textColor=[UIColor groupTableViewBackgroundColor];
        label2.text=@"adfasdfasdfasdf";
        [view addSubview:label2];
        UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(0, (SCREEN_HEIGHT-64)*4/7-25, SCREEN_WIDTH, 25)];
        label3.textAlignment=NSTextAlignmentCenter;
        label3.textColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
        label3.text=@"gongxi";
        [cell addSubview:label3];
    }else if (indexPath.row==1){
        UIImageView *imagV=[[UIImageView alloc]initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH-40, (SCREEN_HEIGHT-64)*1.5/7-20)];
        imagV.image=[UIImage imageNamed:@""];
        [cell addSubview:imagV];
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 60, 15)];
        label1.textAlignment=NSTextAlignmentCenter;
        label1.font=[UIFont systemFontOfSize:12];
        label1.textColor=[UIColor whiteColor];
        label1.text=@"红包";
        [imagV addSubview:label1];
        UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(20, (SCREEN_HEIGHT-64)*1.5/7/2-10, 60, 20)];
        label2.textAlignment=NSTextAlignmentCenter;
        label2.font=[UIFont systemFontOfSize:15];
        label2.textColor=[UIColor whiteColor];
        label2.text=@"￥8.00";
        [imagV addSubview:label2];
        UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(20, (SCREEN_HEIGHT-64)*1.5/7-20-15, 60, 15)];
        label3.textAlignment=NSTextAlignmentCenter;
        label3.font=[UIFont systemFontOfSize:12];
        label3.textColor=[UIColor whiteColor];
        label3.text=@"待使用";
        [imagV addSubview:label3];
        //UILabel *label4=[UILabel alloc]initWithFrame:CGRectMake(100, 10, <#CGFloat width#>, <#CGFloat height#>)
    }else{
    
    }
    cell.backgroundColor=[UIColor colorWithRed:240.0/250.0 green:240.0/250.0 blue:240.0/250.0 alpha:1];
    return cell;
}
-(void)viewWillDisappear:(BOOL)animated{
    [MobClick endLogPageView:@"Trading"];
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
