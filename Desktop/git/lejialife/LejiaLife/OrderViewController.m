//
//  OrderViewController.m
//  LejiaLife
//
//  Created by 张强 on 16/4/29.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "OrderViewController.h"
#import "GoshoppingViewController.h"
#import "MyOrderTableViewCell.h"
#import "OrderModel.h"
#import "OrderDetailsModel.h"
#import "OrderHeaderView.h"
#import "OrderFootView.h"
#import "OrderFootTwoView.h"
#import "OrderDetailViewController.h"
@interface OrderViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic)UITableView *tableView;
@property(nonatomic,retain)NSArray<OrderModel *> *dataSouceArray;
@end

@implementation OrderViewController
-(void)viewWillAppear:(BOOL)animated{
    [MobClick beginLogPageView:@"Order"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    [self creatTitleView];
    [self fetchData];
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
    UIButton *returnBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 74)];
    [returnBtn setImage:[UIImage imageNamed:@"return_icon"] forState:UIControlStateNormal];
    [returnBtn setImageEdgeInsets:UIEdgeInsetsMake(15, -30, 5, 15)];
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
//
-(void)fetchData{
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginToken"];
    NSDictionary *dic=@{@"token":token};
    [[NetDataEngin sharedInstance]requestHomeParamter:dic Atpage:nil WithURL:MYORDER success:^(id responsData) {
        self.dataSouceArray=[OrderModel parseResponsSectionData:responsData];
        [self.tableView reloadData];
        //[self endRefresh];
    } failed:^(NSError *error) {
        //[self endRefresh];
    }];
}
-(UITableView*)tableView{
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [_tableView registerClass:[MyOrderTableViewCell class] forCellReuseIdentifier:@"xxx"];
        [_tableView registerClass:[OrderHeaderView class] forHeaderFooterViewReuseIdentifier:@"header"];
        [_tableView registerClass:[OrderFootView class] forHeaderFooterViewReuseIdentifier:@"footer"];
        [_tableView registerClass:[OrderFootTwoView class] forHeaderFooterViewReuseIdentifier:@"footertwo"];
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSouceArray objectAtIndex:section].orderDetails.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSouceArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 141;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyOrderTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"xxx" forIndexPath:indexPath];
    if (cell==nil) {
        cell=[[MyOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"xxx"];
    }
    NSArray <OrderDetailsModel*>*arr=[OrderDetailsModel parseResponsSectionData:[self.dataSouceArray objectAtIndex:indexPath.section].orderDetails ];
    OrderDetailsModel *model=[arr objectAtIndex:indexPath.row];
    cell.priceLabel.text=[NSString stringWithFormat:@"￥%.2f",[model.minPrice floatValue]/100];
    cell.nameLabel.text=model.name;
    cell.testLabel.text=[NSString stringWithFormat:@"规格：%@", model.specDetail ];
    cell.numberLabe.text=[NSString stringWithFormat:@"数量：%@", model.productNumber ];
    [cell.imagV sd_setImageWithURL:[NSURL URLWithString:model.picture] placeholderImage:nil];
    return cell;
}
//组头
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    OrderHeaderView *header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header" ];
    OrderModel *model=[self.dataSouceArray objectAtIndex:section];
    if (model.state==0) {
        header.stateLabel.text=@"未支付";
    }else if (model.state==1){
    header.stateLabel.text=@"已支付";
    }else if (model.state==2){
        header.stateLabel.text=@"已发货";
    }else if (model.state==3){
        header.stateLabel.text=@"已收货";
    }else if (model.state==4){
        header.stateLabel.text=@"订单取消";
        header.stateLabel.backgroundColor=[UIColor grayColor];
    }
    header.orderNumberLabel.text=[NSString stringWithFormat:@"订单号：%@", model.orderSid ];
    return header;
}
//组尾
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    OrderModel *model=[self.dataSouceArray objectAtIndex:section];
    if (model.state==0) {
        return 100;
    }else if (model.state==2){
        return 100;
    }else if (model.state==1||model.state==3){
    
        return 50;
    }else{
        return 50;
    }
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    OrderModel *model=[self.dataSouceArray objectAtIndex:section];
    if (model.state==0) {
    OrderFootView *foot=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footer" ];
        foot.envelopeLabe.text=[NSString stringWithFormat:@"合计：￥%.2f+%@积分",[model.totalPrice floatValue]/100,model.trueScore];
        [foot.cancleBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        [foot.cancleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [foot.payBtn setTitle:@"立即支付" forState:UIControlStateNormal];
        [foot.payBtn setTitleColor:[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1] forState:UIControlStateNormal];
        [foot.cancleBtn addTarget:self action:@selector(cancleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        foot.cancleBtn.tag=[model.oneId integerValue];
        [foot.payBtn addTarget:self action:@selector(payBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        foot.payBtn.tag=[model.oneId integerValue];
        //foot.
        return foot;
    }else if (model.state==2){
        OrderFootView *foot=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footer" ];
        foot.totalLabel.text=[NSString stringWithFormat:@"合计：￥%@+%@积分",model.totalPrice,model.trueScore];
        foot.envelopeLabe.text=[NSString stringWithFormat:@"红包返利：￥%@",model.totalScore];
//        [foot.cancleBtn removeFromSuperview];
        [foot.payBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        [foot.payBtn setTitleColor:[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1] forState:UIControlStateNormal];
        foot.payBtn.backgroundColor=[UIColor blueColor];
        return foot;
    }else if (model.state==1||model.state==3){
    OrderFootTwoView *foot=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footertwo"];
        foot.totalLabel.text=[NSString stringWithFormat:@"合计：￥%@+%@积分",model.totalPrice,model.totalScore];
        foot.envelopeLabe.text=[NSString stringWithFormat:@"红包返利：￥%@",model.totalScore];
        
            return foot;
    }else if (model.state==4){
    OrderFootTwoView *foot=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footertwo"];
        foot.envelopeLabe.text=[NSString stringWithFormat:@"合计：￥%@+%@积分",model.totalPrice,model.totalScore];
    }
    return nil;
}
-(void)cancleBtnClick:(UIButton *)sender{
    NSDictionary *dic=@{@"orderId":[NSString stringWithFormat:@"%ld",sender.tag]};
    [[NetDataEngin sharedInstance]requestHomeParamter:dic Atpage:nil WithURL:ORDERCANCLE success:^(id responsData) {
        [self fetchData];
        [MBHelper showHUDViewWithTextForFooterView:@"订单取消成功"withHUDColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.36]withDur:1.0];
    } failed:^(NSError *error) {
        [MBHelper showHUDViewWithTextForFooterView:@"取消失败"withHUDColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.36]withDur:1.0];
    }];
    
}
-(void)payBtnClick:(UIButton *)sender{
    NSDictionary *sendDic=@{@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginToken"],@"orderId":[NSString stringWithFormat:@"%ld",sender.tag]};
    [[NetDataEngin sharedInstance]creatOrderParamter:sendDic WithURL:ORDERCREATORDER success:^(id responsData){
        NSDictionary *responsDatadic=responsData;
        NSInteger status=[responsDatadic[@"status"] integerValue];
        if (status==200) {
            GoshoppingViewController *go=[[GoshoppingViewController alloc]init];
            go.HeadFootdataSouceArray=[GoshoppingModel parseResponsData:responsDatadic];
            go.isOrderPush=YES;
            go.dataSouceArray=[GoshoppingCellModel parseResponsData:responsDatadic];
            [MBHelper showHUDViewWithTextForFooterView:responsDatadic[@"msg"] withHUDColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.36]withDur:1.0];
            [self.navigationController pushViewController:go animated:YES];
        }else{
            [MBHelper showHUDViewWithTextForFooterView:responsDatadic[@"msg"] withHUDColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.36]withDur:1.0];
        }
    } failed:^(NSError *error) {
        NSLog(@"生成订单失败");
        
    }];

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderDetailViewController *detail=[[OrderDetailViewController alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [MobClick endLogPageView:@"Order"];
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
