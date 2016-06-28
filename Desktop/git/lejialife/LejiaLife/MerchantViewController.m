//
//  MerchantViewController.m
//  LejiaLife
//
//  Created by 张强 on 16/4/27.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "MerchantViewController.h"
#import "MerchantTableViewCell.h"
#import "MerchantModel.h"
@interface MerchantViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property(nonatomic)UITableView *tableView;
@property(nonatomic)UIScrollView *headScrollowView;
@property(nonatomic)UIPageControl *pageControl;
@property(nonatomic,retain)NSArray <MerchantModel*>*dataSouceArray;
@property(nonatomic,retain)NSArray *imageArray;
@end

@implementation MerchantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self creatTitleViews];
    [self.view addSubview:self.tableView];
    [self fetch];
}
//定制导航栏
-(void)creatTitleViews{
    self.navigationController.navigationBarHidden=YES;
    UIView *TitleVIew=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    UILabel *lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 63, SCREEN_WIDTH, 1)];
    lineLabel.backgroundColor=[UIColor colorWithRed:222.0/250.0 green:222.0/250.0 blue:222.0/250.0 alpha:1];
    [TitleVIew addSubview:lineLabel];
    TitleVIew.backgroundColor=[UIColor groupTableViewBackgroundColor];;
    [self.view addSubview:TitleVIew];
    UIButton *returnBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 64)];
    [returnBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [returnBtn setImageEdgeInsets:UIEdgeInsetsMake(15, 20, 5, 15)];
    //[returnBtn setBackgroundImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(Btnreturn) forControlEvents:UIControlEventTouchUpInside];
    [TitleVIew addSubview:returnBtn];
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 30, 100, 20)];
    titleLabel.text=@"周边";
    titleLabel.font=[UIFont systemFontOfSize:23.0f];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.textColor=[UIColor blackColor];
    [TitleVIew addSubview:titleLabel];
}
-(void)Btnreturn{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)fetch{
    _imageArray=@[@"geographical position_icon",@"telephone_icon",@"time_icon"];
    NSDictionary *dic=@{@"id":self.detailId};
    [[NetDataEngin sharedInstance]requestHomeParamter:dic Atpage:nil WithURL:MERCHANTDETAIL success:^(id responsData) {
        self.dataSouceArray=[MerchantModel parseResponsData:responsData];
        [self.tableView reloadData];
        [self creatTableHeadView];
        //[self creatTableFootView];
    } failed:^(NSError *error) {
        
    }];

}
-(UITableView*)tableView{
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [_tableView registerClass:[MerchantTableViewCell class] forCellReuseIdentifier:@"xxx"];
    }
    return _tableView;
}
-(void)creatTableHeadView{
    MerchantModel *model=[self.dataSouceArray objectAtIndex:0];
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 332*SCREEN_HEIGHTSCALE)];
    headView.backgroundColor=[UIColor whiteColor];
    _headScrollowView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250*SCREEN_HEIGHTSCALE)];
    _headScrollowView.showsHorizontalScrollIndicator=NO;
    _headScrollowView.backgroundColor=[UIColor grayColor];
    _headScrollowView.pagingEnabled = YES;
    _headScrollowView.delegate=self;
    _headScrollowView.contentSize=CGSizeMake(SCREEN_WIDTH*3, 0);
    for (int i=0; i<3; i++) {
        UIImageView *imagV=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, 250*SCREEN_HEIGHTSCALE)];
//        [imagV sd_setImageWithURL:[NSURL URLWithString:[model.pictureArray objectAtIndex:i]] placeholderImage:[UIImage imageNamed:@"placeholder2.jpg"]];
        imagV.image=[UIImage imageNamed:@"placeholder2.jpg"];
        [_headScrollowView addSubview:imagV];
    }
    _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, 200, 200, 20)];
    _pageControl.pageIndicatorTintColor = [UIColor groupTableViewBackgroundColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageControl.numberOfPages=3;
    [headView addSubview:_headScrollowView];
    [headView addSubview:_pageControl];
    UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(20,  270*SCREEN_HEIGHTSCALE, SCREEN_WIDTH-40, 15)];
    nameLabel.font=[UIFont systemFontOfSize:15];
    nameLabel.text=model.name;
    [headView addSubview:nameLabel];
    UIImageView *imagV=[[UIImageView alloc]initWithFrame:CGRectMake(20, 285*SCREEN_HEIGHTSCALE+10, 20, 20)];
    imagV.layer.cornerRadius=10;
    imagV.clipsToBounds=YES;
    imagV.image=[UIImage imageNamed:@"rebate"];
    [headView addSubview:imagV];
    UILabel *secondLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 285*SCREEN_HEIGHTSCALE+15, SCREEN_WIDTH-50-20, 12)];
    secondLabel.font=[UIFont systemFontOfSize:12];
    secondLabel.text=[NSString stringWithFormat:@"消费额的百分之%@将返到您的乐+账户",model.rebate];
    [headView addSubview:secondLabel];
    self.tableView.tableHeaderView=headView;
    
}
//-(void)creatTableFootView{
//    MerchantModel *model=[self.dataSouceArray objectAtIndex:0];
//    UIView *footVIew=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT- 332*SCREEN_HEIGHTSCALE-44*3)];
//    UIImageView *imagV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT- 332*SCREEN_HEIGHTSCALE-44*3)];
//    if (model.picture ==NULL) {
//    }else{
//    [imagV sd_setImageWithURL:[NSURL URLWithString:model.picture] placeholderImage:[UIImage imageNamed:@"placeholder2.jpg"]];
//    }
//    [footVIew addSubview:imagV];
//    self.tableView.tableFooterView=footVIew;
//}

//tableVIew代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MerchantTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"xxx" forIndexPath:indexPath];
    if (cell==nil) {
        cell=[[MerchantTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"xxx"];
    }
    [cell.imagBtn setBackgroundImage:[UIImage imageNamed:[_imageArray objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
    MerchantModel *model=[self.dataSouceArray objectAtIndex:0];
    if (indexPath.row==0) {
        cell.label.text=model.location;
        [cell.imagBtn addTarget:self action:@selector(imageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.imagBtn.tag=indexPath.row+100;
    }else if (indexPath.row==1){
        cell.label.text=model.phoneNumber;
        [cell.imagBtn addTarget:self action:@selector(imageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.imagBtn.tag=indexPath.row+100;
    }else{
    cell.label.text=@"8:00 ~ 24:00";
    [cell.imagBtn addTarget:self action:@selector(imageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.imagBtn.tag=indexPath.row+100;
    }
    return cell;
}
-(void)imageBtnClick:(UIButton *)sender{
//    MerchantModel *model=[self.dataSouceArray objectAtIndex:0];
//    if (sender.tag==100) {
//        NSString *stringURL=[NSString stringWithFormat:@"mapbarnaviiap:"];
//        NSURL *url=[NSURL URLWithString:stringURL];
//        if ([[UIApplication sharedApplication]canOpenURL:url]) {
//            [[UIApplication sharedApplication]openURL:url];
//        }else{
//            UIAlertView *alart=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您尚未安装百度地图，请前往appStore安装" delegate:self cancelButtonTitle:nil otherButtonTitles:@"立即安装",@"稍后安装" ,nil];
//            [alart show];
//        }
//        
//        
//        
//        
//    }else if (sender.tag==101){
//        UIWebView*callWebview =[[UIWebView alloc] init];
//        NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",model.phoneNumber]];// 貌似tel:// 或者 tel: 都行
//        [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
//        //记得添加到view上
//        [self.view addSubview:callWebview];
//    }else{
//    
//    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MerchantModel *model=[self.dataSouceArray objectAtIndex:0];
    if (indexPath.row==0) {
        //判断手机上是否存在chenshtwo的应用
        BOOL blCanOpenUrl = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]];
        if (blCanOpenUrl) {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"baidumap://"]];
            BMKOpenTransitRouteOption *opt = [[BMKOpenTransitRouteOption alloc] init];
            opt.appScheme = @"baidumapsdk://mapsdk.baidu.com";//用于调起成功后，返回原应用
            //opt.appScheme=@"baidumapsdk://sBrSreGsNg3DuB8NMm9uw1TrqA55t6QA";
            //初始化起点节点
            BMKPlanNode* start = [[BMKPlanNode alloc]init];
            //指定起点经纬度
            CLLocationCoordinate2D coor1;
            coor1.latitude = _latitude;
            coor1.longitude = _longitude;
            //指定起点名称
            //start.name = @"";
            start.pt = coor1;
            //指定起点
            opt.startPoint = start;
            //初始化终点节点
            BMKPlanNode* end = [[BMKPlanNode alloc]init];
            CLLocationCoordinate2D coor2;
            coor2.latitude = [model.lat doubleValue];
            coor2.longitude = [model.lng doubleValue];
            end.pt = coor2;
            //指定终点名称
            //end.name = @"";
            opt.endPoint = end;
            //打开地图公交路线检索
            BMKOpenErrorCode code = [BMKOpenRoute openBaiduMapTransitRoute:opt];
        }else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您尚未安装百度地图，请前往appStore安装" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }else if (indexPath.row==1){
        UIWebView*callWebview =[[UIWebView alloc] init];
        NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",model.phoneNumber]];// 貌似tel:// 或者 tel: 都行
        [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
        //记得添加到view上
        [self.view addSubview:callWebview];
    }else{
        
    }
}
#pragma Mark -scrollow代理方法-
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView==self.headScrollowView) {
        for (int i=0; i<100; i++) {
            if (self.headScrollowView.contentOffset.x==i*SCREEN_WIDTH) {
                self.pageControl.currentPage=i;
            }
        }
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"MerchantController"];//("PageOne"为页面名称，可自定义)
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"MerchantController"];
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
