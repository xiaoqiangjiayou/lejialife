//
//  PerimeterDetailViewController.m
//  LejiaLife
//
//  Created by 张强 on 16/4/14.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "PerimeterDetailViewController.h"
#import "PerimeterTableViewCell.h"
#import "MerchantViewController.h"
#import "perimeterModel.h"
#import "ZZPopoverWindow.h"
@interface PerimeterDetailViewController ()<UITableViewDelegate,UITableViewDataSource,BMKLocationServiceDelegate,UIPopoverPresentationControllerDelegate>
@property(nonatomic)UITableView *tableView;
@property(nonatomic,retain)NSMutableArray *datasouceArray;
@property(nonatomic,retain)NSMutableArray *styleDataouceArray;
@property(nonatomic,retain)NSMutableArray *nearDataouceArray;
@property(nonatomic)UIButton *styleBtn;
@property(nonatomic)UIButton *nearBtn;
@property(nonatomic)BOOL styleBtnFlag;
@property(nonatomic)BOOL nearBtnFlag;

@property(nonatomic)UITableView *contentView1;
@property(nonatomic)UITableView *contentView2;
@property (nonatomic) ZZPopoverWindow *popover;
@property (strong,nonatomic) BMKLocationService *locService;
//用户纬度
@property (nonatomic,assign) double userLatitude;

//用户经度
@property (nonatomic,assign) double userLongitude;

//用户位置
@property (strong,nonatomic) CLLocation *clloction;
@end

@implementation PerimeterDetailViewController
+ (PerimeterDetailViewController *)sharedInstance
{
    static PerimeterDetailViewController *_instance = nil;
    
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
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self creatTitleViews];
    [self.view addSubview:self.tableView];
    [self fetchData];
}
-(void)fetchData{
    _styleDataouceArray=[NSMutableArray arrayWithArray:@[@"美食",@"ktv",@"温泉",@"旅游",@"健身",@"购物"]];
    _nearDataouceArray=[NSMutableArray arrayWithArray:@[@"铁西",@"铁东",@"立山"]];
    NSString *longitude=[NSString stringWithFormat:@"%f",self.userLongitude];
    NSString *latitude=[NSString stringWithFormat:@"%f",self.userLatitude];
    NSDictionary *dic=@{@"longitude":longitude,@"latitude":latitude,@"page":@"1",@"type":self.popStyleId,@"areaId":@"1"};
    [[NetDataEngin sharedInstance]requestHomeMerchantParamter:dic Atpage:nil WithURL:MERCHANT success:^(id responsData) {
        self.datasouceArray=[perimeterModel parseResponsData:responsData];
        [self.tableView reloadData];
        //[self endRefresh];
    } failed:^(NSError *error) {
        //[self endRefresh];
        NSLog(@"请求数据失败");
    }];
}
-(void)creatTitleViews{
    UIView *TitleVIew=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 108)];
    UILabel *lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 63, SCREEN_WIDTH, 1.5)];
    lineLabel.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [TitleVIew addSubview:lineLabel];
    UILabel *lineLabel2=[[UILabel alloc]initWithFrame:CGRectMake(0, 107, SCREEN_WIDTH, 1.5)];
    lineLabel2.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [TitleVIew addSubview:lineLabel2];
    TitleVIew.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:TitleVIew];
    UILabel *lineLabel3=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-1, 71, 1.5, 30)];
    lineLabel3.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [TitleVIew addSubview:lineLabel3];
    UIButton *returnBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, 30, 12, 20)];
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"return_icon"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(Btnreturn) forControlEvents:UIControlEventTouchUpInside];
    [TitleVIew addSubview:returnBtn];
    UIButton *titleBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 20, 100, 40)];
    [titleBtn setTitle:@"鞍山" forState:UIControlStateNormal];
    titleBtn.titleLabel.font=[UIFont systemFontOfSize:20.0f];
    titleBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [titleBtn setTitleColor:[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1] forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@"downward-triangle_city"] forState:UIControlStateNormal];
    [titleBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 95, 0, 0)];
    [TitleVIew addSubview:titleBtn];
    self.styleBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH/2, 44)];
    if ([self.popStyleId isEqualToString:@"1"]) {
       [self.styleBtn setTitle:@"美食" forState:UIControlStateNormal];
    }else if ([self.popStyleId isEqualToString:@"2"]){
    [self.styleBtn setTitle:@"KTV" forState:UIControlStateNormal];
    }else if ([self.popStyleId isEqualToString:@"3"]){
    [self.styleBtn setTitle:@"温泉" forState:UIControlStateNormal];
    }else if ([self.popStyleId isEqualToString:@"4"]){
    [self.styleBtn setTitle:@"旅游" forState:UIControlStateNormal];
    }else if ([self.popStyleId isEqualToString:@"5"]){
    [self.styleBtn setTitle:@"健身" forState:UIControlStateNormal];
    }else if ([self.popStyleId isEqualToString:@"6"]){
    [self.styleBtn setTitle:@"购物" forState:UIControlStateNormal];
    }else{
    [self.styleBtn setTitle:@"全部类型" forState:UIControlStateNormal];
    }
    [self.styleBtn setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
    self.styleBtn.titleLabel.font=[UIFont systemFontOfSize:17];
    [self.styleBtn addTarget:self action:@selector(styleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.styleBtn setImage:[UIImage imageNamed:@"drop-triangle"] forState:UIControlStateNormal];
    [self.styleBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 95, 0, -10)];
    self.styleBtn.selected=NO;
    [TitleVIew addSubview:self.styleBtn];
    self.nearBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 64, SCREEN_WIDTH/2, 44)];
    [self.nearBtn setTitle:@"鞍山" forState:UIControlStateNormal];
    [self.nearBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.nearBtn.titleLabel.font=[UIFont systemFontOfSize:17];
    [self.nearBtn addTarget:self action:@selector(nearBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.nearBtn setImage:[UIImage imageNamed:@"drop-triangle"] forState:UIControlStateNormal];
    [self.nearBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 95, 0, 0)];
    [TitleVIew addSubview:self.nearBtn];
}
-(void)Btnreturn{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)styleBtnClick{
    [self.nearBtn setImage:[UIImage imageNamed:@"drop-triangle"] forState:UIControlStateNormal];
    [self.nearBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 95, 0, 0)];
    [self.nearBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.styleBtn setTitleColor:[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1] forState:UIControlStateNormal];
    _contentView1= [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 100, 300)];
    _contentView1.delegate=self;
    _contentView1.dataSource=self;
    [_contentView1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"aaa"];
    self.popover= [[ZZPopoverWindow alloc] init];
    self.popover.contentView    = _contentView1;
    __weak typeof(self) weakself = self;
    self.popover.didShowHandler = ^() {
        NSLog(@"Did show");
        [weakself.styleBtn setImage:[UIImage imageNamed:@"upward-triangle"] forState:UIControlStateNormal];
        [weakself.styleBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 95, 0, -10)];
    };
    self.popover.didDismissHandler = ^() {
        NSLog(@"Did dismiss");
        [weakself.styleBtn setImage:[UIImage imageNamed:@"downward-triangle"] forState:UIControlStateNormal];
        [weakself.styleBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 95, 0, -10)];
    };
    [self.popover showAtView:self.styleBtn];
}

-(void)nearBtnClick{
    [self.styleBtn setImage:[UIImage imageNamed:@"drop-triangle"] forState:UIControlStateNormal];
    [self.styleBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 95, 0, -10)];
    [self.styleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.nearBtn setTitleColor:[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1] forState:UIControlStateNormal];
    _contentView2= [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 300-60, 150)];
    _contentView2.delegate=self;
    _contentView2.dataSource=self;
    [_contentView2 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"bbb"];
    _contentView2.backgroundColor=[UIColor whiteColor];
    self.popover= [[ZZPopoverWindow alloc] init];
    self.popover.contentView= _contentView2;
     __weak typeof(self) weakself = self;
    self.popover.didShowHandler = ^() {
        NSLog(@"Did twoshow");
        [weakself.nearBtn setImage:[UIImage imageNamed:@"upward-triangle"] forState:UIControlStateNormal];
        [weakself.nearBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 95, 0, 0)];
    };
    self.popover.didDismissHandler = ^() {
        NSLog(@"Did twodismiss");
        [weakself.nearBtn setImage:[UIImage imageNamed:@"downward-triangle"] forState:UIControlStateNormal];
        [weakself.nearBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 95, 0, 0)];
    };
    [self.popover showAtView:self.nearBtn];
}
- (void)dismiss{
    [self.popover dismiss];
}
-(UITableView *)tableView{
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 108, SCREEN_WIDTH, SCREEN_HEIGHT-108) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [_tableView registerClass:[PerimeterTableViewCell class] forCellReuseIdentifier:@"xxx"];
    }
    return _tableView;
}
//*********************************************
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==_contentView1) {
        return _styleDataouceArray.count;
    }else if (tableView==_contentView2){
        return _nearDataouceArray.count;
    }else{
    return self.datasouceArray.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_tableView) {
        return 140;
    }else{
    return 50;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_tableView) {
        PerimeterTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"xxx" forIndexPath:indexPath];
        if (cell==nil) {
            cell=[[PerimeterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"xxx"];
        }
        cell.backgroundColor=[UIColor colorWithRed:222.0/250.0 green:222.0/250.0 blue:222.0/250.0 alpha:1];
        perimeterModel *model=[self.datasouceArray objectAtIndex:indexPath.row];
        [cell.imagV sd_setImageWithURL:[NSURL URLWithString:model.picture] placeholderImage:nil];
        cell.nameLabel.text=model.name;
        cell.distanceLabel.text=model.distance;
        cell.adressLabel.text=model.location;
        cell.accountLabel.text=model.rebate;
        return cell;
    }else if(tableView==_contentView1){
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"aaa"];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"aaa"];
        }
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
        [cell setBackgroundView:label];
        label.textAlignment=NSTextAlignmentCenter;
        label.text=[_styleDataouceArray objectAtIndex:indexPath.row];
        label.textColor=[UIColor grayColor];
        return cell;
    }else{
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"bbb"];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"bbb"];
        }
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
        [cell setBackgroundView:label];
        label.textAlignment=NSTextAlignmentCenter;
        label.text=[_nearDataouceArray objectAtIndex:indexPath.row];
        label.textColor=[UIColor grayColor];
        return cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_tableView) {
        MerchantViewController *merchantVC=[[MerchantViewController alloc]init];
        perimeterModel *model=[self.datasouceArray objectAtIndex:indexPath.row];
        self.hidesBottomBarWhenPushed=YES;
        merchantVC.detailId=model.iid;
        [self.navigationController pushViewController:merchantVC animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    }else if (tableView==_contentView1){
        [self.popover dismiss];
        [self.styleBtn setTitle:[_styleDataouceArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    }else{
    [self.popover dismiss];
    [self.nearBtn setTitle:[_nearDataouceArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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
    [self fetchData];
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
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"PerimeterDetailController"];//("PageOne"为页面名称，可自定义)
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"PerimeterDetailController"];
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
