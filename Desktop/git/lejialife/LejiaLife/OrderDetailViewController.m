//
//  OrderDetailViewController.m
//  LejiaLife
//
//  Created by 张强 on 16/6/6.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderHeaderView.h"
#import "MyOrderTableViewCell.h"
#import "LogisticsViewController.h"
@interface OrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic)UITableView *tableView;
@property(nonatomic)UIView *headView;
@property(nonatomic)UIView *footView;
@end

@implementation OrderDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [MobClick beginLogPageView:@"OrderDetail"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTitleView];
    [self.view addSubview:self.tableView];
    [self creatHeadView];
    [self creatFootView];
}
//导航栏视图
-(void)creatTitleView{
    self.navigationController.navigationBarHidden=YES;
    UIView *TitleVIew=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    UILabel *lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 63, SCREEN_WIDTH, 1)];
    lineLabel.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [TitleVIew addSubview:lineLabel];
    TitleVIew.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:TitleVIew];
    UIButton *returnBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, 30, 12, 20)];
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"return_icon"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(Btnreturn) forControlEvents:UIControlEventTouchUpInside];
    [TitleVIew addSubview:returnBtn];
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 30, 100, 20)];
    titleLabel.text=@"我的订单";
    titleLabel.font=[UIFont systemFontOfSize:20.0f];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.textColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    [TitleVIew addSubview:titleLabel];
}
//返回上一页
-(void)Btnreturn{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(UITableView *)tableView{
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [_tableView registerClass:[MyOrderTableViewCell class] forCellReuseIdentifier:@"xxx"];
    }
    return _tableView;
}
-(void)creatHeadView{
    _headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    UIImageView *imagV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    imagV.image=[UIImage imageNamed:@""];
    [_headView addSubview:imagV];
    UIButton *headViewBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 137, SCREEN_WIDTH, 63)];
    headViewBtn.backgroundColor=[UIColor whiteColor];
    UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 16, 50, 10)];
    nameLabel.font=[UIFont systemFontOfSize:12];
    nameLabel.text=@"dfs";
    UILabel *telePhoneLabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 16, SCREEN_WIDTH-100, 10)];
    telePhoneLabel.text=@"dfsdf";
    telePhoneLabel.font=[UIFont systemFontOfSize:12];
    UILabel *addressLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 36, SCREEN_WIDTH, 12)];
    addressLabel.font=[UIFont systemFontOfSize:12];
    addressLabel.text=[NSString stringWithFormat:@"%@%@%@%@",@"sadfasd",@"asdf",@"sadfasd",@"sdf"];
    addressLabel.textColor=[UIColor colorWithRed:140.0/250.0 green:140.0/250.0 blue:140.0/250.0 alpha:1];
    [headViewBtn addSubview:nameLabel];
    [headViewBtn addSubview:telePhoneLabel];
    [headViewBtn addSubview:addressLabel];
    [_headView addSubview:headViewBtn];
    _tableView.tableHeaderView=_headView;
}
-(void)creatFootView{
    _footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 450)];
    _footView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 141)];
    view1.backgroundColor=[UIColor whiteColor];
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 60, 15)];
    label1.textColor=[UIColor colorWithRed:140.0/250.0 green:140.0/250.0 blue:140.0/250.0 alpha:1];
    label1.font=[UIFont systemFontOfSize:13];
    label1.text=@"订单金额:";
    [view1 addSubview:label1];
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(20, 35, 60, 15)];
    label2.text=@"运费:";
    label2.textColor=[UIColor colorWithRed:140.0/250.0 green:140.0/250.0 blue:140.0/250.0 alpha:1];
    label2.font=[UIFont systemFontOfSize:13];
    [view1 addSubview:label2];
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 10, SCREEN_WIDTH/2-20, 15)];
    label3.textColor=[UIColor blackColor];
    label3.font=[UIFont systemFontOfSize:13];
    label3.textAlignment=NSTextAlignmentRight;
    label3.text=@"￥4.00";
    [view1 addSubview:label3];
    UILabel *label4=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 35, SCREEN_WIDTH/2-20, 15)];
    label4.text=@"￥0";
    label4.textAlignment=NSTextAlignmentRight;
    label4.textColor=[UIColor blackColor];
    label4.font=[UIFont systemFontOfSize:13];
    [view1 addSubview:label4];
    UILabel *label5=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 60, SCREEN_WIDTH/2-20, 15)];
    label5.text=@"￥400";
    label5.textAlignment=NSTextAlignmentRight;
    label5.textColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    label5.font=[UIFont systemFontOfSize:13];
    [view1 addSubview:label5];
    UILabel *label8=[[UILabel alloc]initWithFrame:CGRectMake(20, 85, 60, 15)];
    label8.textColor=[UIColor colorWithRed:140.0/250.0 green:140.0/250.0 blue:140.0/250.0 alpha:1];
    label8.font=[UIFont systemFontOfSize:13];
    label8.text=@"积分抵扣:";
    [view1 addSubview:label8];
    UILabel *label9=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 85, SCREEN_WIDTH/2-20, 15)];
    label9.textColor=[UIColor colorWithRed:140.0/250.0 green:140.0/250.0 blue:140.0/250.0 alpha:1];
    label9.font=[UIFont systemFontOfSize:13];
    label9.textAlignment=NSTextAlignmentRight;
    label9.text=@"-￥100";
    [view1 addSubview:label9];
    UILabel *label10=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 110, SCREEN_WIDTH/2-20, 15)];
    label10.text=@"实付金额：￥300";
    label10.textAlignment=NSTextAlignmentRight;
    label10.textColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    label10.font=[UIFont systemFontOfSize:13];
    [view1 addSubview:label10];
    UILabel *lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 80, SCREEN_WIDTH-40, 1.5)];
    lineLabel.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [view1 addSubview:lineLabel];
    [_footView addSubview:view1];
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(0, 160, SCREEN_WIDTH, 50)];
    view2.backgroundColor=[UIColor whiteColor];
    UILabel *label6=[[UILabel alloc]initWithFrame:CGRectMake(20, 20, 60, 15)];
    label6.textColor=[UIColor colorWithRed:140.0/250.0 green:140.0/250.0 blue:140.0/250.0 alpha:1];
    label6.font=[UIFont systemFontOfSize:13];
    label6.text=@"消费返利:";
    [view2 addSubview:label6];
    UILabel *label7=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 20, SCREEN_WIDTH/2-20, 15)];
    label7.text=@"获得乐+生活￥7.32红包";
    label7.textAlignment=NSTextAlignmentRight;
    label7.textColor=[UIColor blackColor];
    label7.font=[UIFont systemFontOfSize:13];
    [view2 addSubview:label7];
    [_footView addSubview:view2];
    UIView *view3=[[UIView alloc]initWithFrame:CGRectMake(0, 220, SCREEN_WIDTH, 141)];
    view3.backgroundColor=[UIColor whiteColor];
    for (int i=0; i<5; i++) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20, 10+i*25, SCREEN_WIDTH-40, 15)];
        label.textColor=[UIColor colorWithRed:140.0/250.0 green:140.0/250.0 blue:140.0/250.0 alpha:1];
        label.text=@"asdfjahldfjhaljdhflakjdhflakj";
        [view3 addSubview:label];
    }
    [_footView addSubview:view3];
    
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 371, SCREEN_WIDTH, 40)];
    btn.backgroundColor=[UIColor whiteColor];
    [btn setTitle:@"查看物流" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(logisticsBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_footView addSubview:btn];
    _tableView.tableFooterView=_footView;
}
-(void)logisticsBtnClick{
    LogisticsViewController *logistics=[[LogisticsViewController alloc]init];
    [self.navigationController pushViewController:logistics animated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//组头
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    backgroundView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 15, SCREEN_WIDTH, 40)];
    backView.backgroundColor=[UIColor whiteColor];
    UIImageView *imagV=[[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 20, 20)];
    imagV.image=[UIImage imageNamed:@""];
    [backView addSubview:imagV];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(50, 10, 60, 15)];
    label.font=[UIFont systemFontOfSize:13];
    label.text=@"乐+商城";
    label.textColor=[UIColor blackColor];
    [backView addSubview:label];
    UILabel *stateLabel=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-80, 0, 70, 30)];
    stateLabel.textColor=[UIColor whiteColor];
    stateLabel.text=@"待发货";
    stateLabel.textAlignment=NSTextAlignmentCenter;
    stateLabel.font=[UIFont systemFontOfSize:13];
    stateLabel.backgroundColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    [backgroundView addSubview:backView];
    [backView addSubview:stateLabel];
    return backgroundView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 141;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyOrderTableViewCell *cell=[_tableView dequeueReusableCellWithIdentifier:@"xxx" forIndexPath:indexPath];
    if (cell==nil) {
        cell=[[MyOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"xxx"];
    }
    //    NSArray <OrderDetailsModel*>*arr=[OrderDetailsModel parseResponsSectionData:[self.dataSouceArray objectAtIndex:indexPath.section].orderDetails ];
    //    OrderDetailsModel *model=[arr objectAtIndex:indexPath.row];
    //    cell.priceLabel.text=[NSString stringWithFormat:@"￥%.2f",[model.minPrice floatValue]/100];
    //    cell.nameLabel.text=model.name;
    //    cell.testLabel.text=[NSString stringWithFormat:@"规格：%@", model.specDetail ];
    //    cell.numberLabe.text=[NSString stringWithFormat:@"数量：%@", model.productNumber ];
    //    [cell.imagV sd_setImageWithURL:[NSURL URLWithString:model.picture] placeholderImage:nil];
    cell.backgroundColor=[UIColor groupTableViewBackgroundColor];
    return cell;
}
-(void)viewWillDisappear:(BOOL)animated{
    [MobClick endLogPageView:@"OrderDetail"];
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
