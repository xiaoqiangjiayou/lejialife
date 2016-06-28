//
//  EnvelopViewController.m
//  LejiaLife
//
//  Created by 张强 on 16/5/6.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "EnvelopViewController.h"
#import "EnvelopTableViewCell.h"
#import "EnvelopHeaderView.h"
#import "EnveLopeModel.h"
@interface EnvelopViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic)UITableView *tableView;
@property(nonatomic,retain)NSArray< EnveLopeModel*>*sectionDataSouceArray;
@end

@implementation EnvelopViewController
-(void)viewWillAppear:(BOOL)animated{
    [MobClick beginLogPageView:@"EnvelopViewController"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTitleView];
    [self.view addSubview:self.tableView];
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
    UIButton *returnBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 64)];
    [returnBtn setImage:[UIImage imageNamed:@"return_icon"] forState:UIControlStateNormal];
    [returnBtn setImageEdgeInsets:UIEdgeInsetsMake(15, -20, 5, 15)];
    [returnBtn addTarget:self action:@selector(Btnreturn) forControlEvents:UIControlEventTouchUpInside];
    [TitleVIew addSubview:returnBtn];
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 30, 100, 20)];
    titleLabel.text=self.titleStr;
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
    NSString *url=[[NSString alloc]init];
    if (self.isEnvelope==YES) {
        url=SCORELISTA;
    }else{
    url=SCORELISTB;
    }
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginToken"];
    NSDictionary *dic=@{@"token":token};
    [[NetDataEngin sharedInstance]requestHomeParamter:dic Atpage:nil WithURL:url success:^(id responsData) {
        self.sectionDataSouceArray=[EnveLopeModel parseResponsSectionData:responsData];
        [self.tableView reloadData];
    } failed:^(NSError *error) {
    }];
}
-(UITableView*)tableView{
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor=[UIColor whiteColor];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [_tableView registerClass:[EnvelopTableViewCell class] forCellReuseIdentifier:@"xxx"];
        [_tableView registerClass:[EnvelopHeaderView class] forHeaderFooterViewReuseIdentifier:@"header"];
        
    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sectionDataSouceArray[section].listArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 73*SCREEN_HEIGHTSCALE;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EnvelopTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"xxx" forIndexPath:indexPath];
    if (cell==nil) {
        cell=[[EnvelopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"xxx"];
    }
    cell.backgroundColor=[UIColor whiteColor];
    EnveLopeModel *model=[self.sectionDataSouceArray objectAtIndex:indexPath.section];
    NSDictionary *dic=[model.listArray objectAtIndex:indexPath.row];
    if (self.isEnvelope==YES) {
        cell.littleImagV.image=[UIImage imageNamed:@"red point of time second"];
        cell.bigImagV.image=[UIImage imageNamed:@"red envelope increased"];
        float a=[dic[@"number"] floatValue]/100;
        if (a>=0) {
            cell.numberLabel.text=[NSString stringWithFormat:@"+%.2f红包",a];
        }else{
        cell.numberLabel.text=[NSString stringWithFormat:@"%.2f红包",a];
        }
        
    }else if(self.isEnvelope==NO){
    cell.littleImagV.image=[UIImage imageNamed:@"integral point of time second"];
    cell.bigImagV.image=[UIImage imageNamed:@"integral envelope increased"];
        cell.numberLabel.text=[NSString stringWithFormat:@"%d积分",[dic[@"number"] intValue]];
    }
    NSString * timeStampString=[dic[@"dateCreated"] stringValue];
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"HH:mm:ss"];
    cell.timeLabel.text=[objDateformat stringFromDate:date];
    cell.nameLabel.text=dic[@"operate"];
    
    return cell;
}
//组头
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionDataSouceArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50*SCREEN_HEIGHTSCALE;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    EnvelopHeaderView *header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header" ];
    if (self.isEnvelope==YES) {
        header.littleImagV.image=[UIImage imageNamed:@"red point of time first"];
        header.labelImagV.image=[UIImage imageNamed:@"red time frame"];
    }else{
    header.littleImagV.image=[UIImage imageNamed:@"integral point of time first"];
    header.labelImagV.image=[UIImage imageNamed:@"integral time frame"];
    }
    EnveLopeModel *model=[self.sectionDataSouceArray objectAtIndex:section];
    header.timeLabel.text=model.createDate;
    return header;
}
-(void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden=YES;
    [MobClick endLogPageView:@"EnvelopViewController"];
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
