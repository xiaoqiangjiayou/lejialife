//
//  LogisticsViewController.m
//  LejiaLife
//
//  Created by 张强 on 16/6/7.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "LogisticsViewController.h"

@interface LogisticsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic)UITableView *tableView;
@end

@implementation LogisticsViewController
-(void)viewWillAppear:(BOOL)animated{
    [MobClick beginLogPageView:@"Logistics"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTitleView];
    [self.view addSubview:self.tableView];
    [self creatHeadView];
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
    UIButton *returnBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, 30, 12, 20)];
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"return_icon"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(Btnreturn) forControlEvents:UIControlEventTouchUpInside];
    [TitleVIew addSubview:returnBtn];
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 30, 100, 20)];
    titleLabel.text=@"查看物流";
    titleLabel.font=[UIFont systemFontOfSize:20.0f];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.textColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    [TitleVIew addSubview:titleLabel];
}
//返回上一页
-(void)Btnreturn{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)fetchData{
    //账户登录的token
//    NSString *url=[[NSString alloc]init];
//    if (self.isEnvelope==YES) {
//        url=SCORELISTA;
//    }else{
//        url=SCORELISTB;
//    }
//    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginToken"];
//    NSDictionary *dic=@{@"token":token};
//    [[NetDataEngin sharedInstance]requestHomeParamter:dic Atpage:nil WithURL:url success:^(id responsData) {
//        self.sectionDataSouceArray=[EnveLopeModel parseResponsSectionData:responsData];
//        [self.tableView reloadData];
//    } failed:^(NSError *error) {
//    }];
}
-(UITableView*)tableView{
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor=[UIColor whiteColor];
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}
-(void)creatHeadView{
    UIImageView *imagV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 250)];
    imagV.image=[UIImage imageNamed:@""];
    
    _tableView.tableHeaderView=imagV;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[_tableView dequeueReusableCellWithIdentifier:@"xxx"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"xxx"];
    }
    UILabel *lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(40, 0, 1.5, 50)];
    lineLabel.backgroundColor=[UIColor colorWithRed:140.0/250.0 green:140.0/250.0 blue:140.0/250.0 alpha:1];
    [cell addSubview:lineLabel];
    UIImageView *littleImagV=[[UIImageView alloc]initWithFrame:CGRectMake(40, 8, 11, 11)];
    littleImagV.backgroundColor=[UIColor redColor];
    [cell addSubview:littleImagV];
    
    UILabel *timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 10, SCREEN_WIDTH-50, 11)];
    timeLabel.font=[UIFont systemFontOfSize:9];
    timeLabel.textAlignment=NSTextAlignmentLeft;
    timeLabel.textColor=[UIColor colorWithRed:140.0/250.0 green:140.0/250.0 blue:140.0/250.0 alpha:1];
    [cell addSubview:timeLabel];
    UILabel *addressLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 25, SCREEN_WIDTH-50, 11)];
    addressLabel.font=[UIFont systemFontOfSize:9];
    addressLabel.textAlignment=NSTextAlignmentLeft;
    addressLabel.textColor=[UIColor colorWithRed:140.0/250.0 green:140.0/250.0 blue:140.0/250.0 alpha:1];
    [cell addSubview:addressLabel];
    
    return cell;
}
-(void)viewWillDisappear:(BOOL)animated{
    [MobClick endLogPageView:@"Logistics"];
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
