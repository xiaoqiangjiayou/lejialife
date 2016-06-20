//
//  PerimeterViewController.m
//  LejiaLife
//
//  Created by 张强 on 16/3/21.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "PerimeterViewController.h"
#import "PerimeterTableViewCell.h"
#import "PerimeterDetailViewController.h"
#import "MerchantViewController.h"
#import "perimeterModel.h"
#import "AppDelegate.h"
@interface PerimeterViewController ()<UITableViewDataSource,UITableViewDelegate,BMKLocationServiceDelegate>
@property(nonatomic)UITableView *tableView;
@property(nonatomic,retain)NSMutableArray *datasouceArray;
@property (strong,nonatomic) BMKLocationService *locService;
//用户纬度
@property (nonatomic,assign) double userLatitude;

//用户经度
@property (nonatomic,assign) double userLongitude;

//用户位置
@property (strong,nonatomic) CLLocation *clloction;
@end
@implementation PerimeterViewController
+ (PerimeterViewController *)sharedInstance
{
    static PerimeterViewController *_instance = nil;
    
    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }
    
    return _instance;
}
-(id)init
{
    if (self == [super init])
    {
        [self initBMKUserLocation];
    }
    return self;
}
/**
 *  初始化百度地图用户位置管理类
 */
- (void)initBMKUserLocation
{
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    [self startLocation];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"PerimeterController"];//("PageOne"为页面名称，可自定义)
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self creatTitleViews];
    [self.view addSubview:self.tableView];
    [self CreatClassViews];
    [self fetchData];
}
-(void)fetchData{
    NSString *longitude=[NSString stringWithFormat:@"%f",self.userLongitude];
    NSString *latitude=[NSString stringWithFormat:@"%f",self.userLatitude];
    NSDictionary *dic=@{@"longitude":longitude,@"latitude":latitude};
    [[NetDataEngin sharedInstance]requestMerchantParamter:dic Atpage:nil WithURL:MERCHANT success:^(id responsData) {
        self.datasouceArray=[perimeterModel parseResponsData:responsData];
        [self.tableView reloadData];
        //[self endRefresh];
    } failed:^(NSError *error) {
        //[self endRefresh];
    }];
}
-(UITableView *)tableView{
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49) style:UITableViewStylePlain];
        _tableView.estimatedRowHeight = 2000;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [_tableView registerClass:[PerimeterTableViewCell class] forCellReuseIdentifier:@"xxx"];
    }
    return _tableView;
}
-(void)creatTitleViews{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(18, 29, 25, 25);
    [button setBackgroundImage:[UIImage imageNamed:@"choutitongcheng"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(drawer) forControlEvents:UIControlEventTouchUpInside];
    self.navigationController.navigationBarHidden=YES;
    UIView *NavView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    NavView.backgroundColor=[UIColor whiteColor];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 63, SCREEN_WIDTH, 1)];
    label.backgroundColor=[UIColor groupTableViewBackgroundColor];
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-30, 30, 60, 20)];
    titleLabel.text=@"鞍山";
    titleLabel.font=[UIFont systemFontOfSize:23.0f];
    titleLabel.textColor=[UIColor colorWithRed:214.0/250.0 green:46.0/250.0 blue:46.0/250.0 alpha:1];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    [NavView addSubview:label];
    [NavView addSubview:titleLabel];
    [NavView addSubview:button];
    [self.view addSubview:NavView];
}
-(void)CreatClassViews{
    UIView *ClassView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130)];
    ClassView.backgroundColor=[UIColor whiteColor];
    UIButton *btn1=[[UIButton alloc]init];
    btn1.tag=101;
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"delicious food"] forState:UIControlStateNormal];
    [ClassView addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35, 35));
        make.top.mas_equalTo(ClassView).offset(20);
        make.left.mas_equalTo(ClassView).offset(30);
    }];
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(75, 28, 40, 26)];
    label1.text=@"美食";
    label1.font=[UIFont systemFontOfSize:15.0];
    [ClassView addSubview:label1];
    UIButton *btn2=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-40, 20, 35, 35)];
    btn2.tag=102;
    [btn2 setBackgroundImage:[UIImage imageNamed:@"ktv"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [ClassView addSubview:btn2];
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+5, 28, 40, 26)];
    label2.text=@"KTV";
    label2.font=[UIFont systemFontOfSize:15.0];
    [ClassView addSubview:label2];
    
    UIButton *btn3=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-110, 20, 35, 35)];
    btn3.tag=103;
    [btn3 setBackgroundImage:[UIImage imageNamed:@"hot spring"] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [ClassView addSubview:btn3];
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60, 28, 40, 26)];
    label3.text=@"温泉";
    label3.font=[UIFont systemFontOfSize:15.0];
    [ClassView addSubview:label3];
    
    UIButton *btn4=[[UIButton alloc]initWithFrame:CGRectMake(30, ClassView.frame.size.height-60, 35, 35)];
    btn4.tag=104;
    [btn4 setBackgroundImage:[UIImage imageNamed:@"tourism"] forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [ClassView addSubview:btn4];
    UILabel *label4=[[UILabel alloc]initWithFrame:CGRectMake(75, ClassView.frame.size.height-53, 40, 26)];
    label4.text=@"旅游";
    label4.font=[UIFont systemFontOfSize:15.0];
    [ClassView addSubview:label4];
    
    UIButton *btn5=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-40, ClassView.frame.size.height-60, 35, 35)];
    btn5.tag=105;
    [btn5 setBackgroundImage:[UIImage imageNamed:@"bodybuilding"] forState:UIControlStateNormal];
    [btn5 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [ClassView addSubview:btn5];
    UILabel *label5=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+5, ClassView.frame.size.height-53, 40, 26)];
    label5.text=@"健身";
    label5.font=[UIFont systemFontOfSize:15.0];
    [ClassView addSubview:label5];
    
    UIButton *btn6=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-110, ClassView.frame.size.height-60, 35, 35)];
    btn6.tag=106;
    [btn6 setBackgroundImage:[UIImage imageNamed:@"shopping"] forState:UIControlStateNormal];
    [btn6 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [ClassView addSubview:btn6];
    UILabel *label6=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60, ClassView.frame.size.height-53, 40, 26)];
    label6.text=@"购物";
    label6.font=[UIFont systemFontOfSize:15.0];
    [ClassView addSubview:label6];
    self.tableView.tableHeaderView=ClassView;
}
//**************************************************click事件******************************************
-(void)btnClick:(UIButton*)sender{
    PerimeterDetailViewController *detailViewController=[[PerimeterDetailViewController alloc]init];
    detailViewController.popStyleId=[NSString stringWithFormat:@"%ld",sender.tag-100];
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:detailViewController animated:YES];
    self.hidesBottomBarWhenPushed=NO;

}
//****************************************************************************************************
-(void)drawer{
    AppDelegate *tempApplication =(AppDelegate*)[[UIApplication sharedApplication]delegate];
    if (tempApplication.leftSlide.closed) {
        //打开左视图
        [tempApplication.leftSlide openLeftView];
    }else{
        //关闭左视图
        [tempApplication.leftSlide closeLeftView];
    }
}
//*****************************************tableView代理方法*******************************************
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasouceArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PerimeterTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"xxx" forIndexPath:indexPath];
    if (cell==nil) {
        cell=[[PerimeterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"xxx"];
    }
    perimeterModel *model=[self.datasouceArray objectAtIndex:indexPath.row];
    [cell.imagV sd_setImageWithURL:[NSURL URLWithString:model.picture] placeholderImage:nil];
    cell.nameLabel.text=model.name;
    cell.distanceLabel.text=model.distance;
    cell.adressLabel.text=model.location;
    cell.accountLabel.text=model.rebate;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MerchantViewController *merchantVC=[[MerchantViewController alloc]init];
    perimeterModel *model=[self.datasouceArray objectAtIndex:indexPath.row];
    self.hidesBottomBarWhenPushed=YES;
    merchantVC.detailId=model.iid;
    [self.navigationController pushViewController:merchantVC animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

#pragma 打开定位服务
/**
 *  打开定位服务
 */
-(void)startLocation
{
    [_locService startUserLocationService];
}
#pragma 关闭定位服务

/**
 *  关闭定位服务
 */
-(void)stopLocation
{
    [_locService stopUserLocationService];
    [self performSelectorOnMainThread:@selector(fetchData) withObject:nil waitUntilDone:YES];
}
//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    _clloction = userLocation.location;
    //    _clloction = cllocation;
    _userLatitude = _clloction.coordinate.latitude;
    _userLongitude = _clloction.coordinate.longitude;
    [self stopLocation];//(如果需要实时定位不用停止定位服务)
}
/**
 *在停止定位后，会调用此函数
 */
- (void)didStopLocatingUser
{
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"PerimeterController"];
}
@end
