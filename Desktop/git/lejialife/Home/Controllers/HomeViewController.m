//
//  HomeViewController.m
//  LejiaLife
//
//  Created by 张强 on 16/3/21.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCollectionViewCell.h"
#import "PerimeterTableViewCell.h"
#import "MerchantViewController.h"
#import "AppDelegate.h"
#import "HomeModel.h"
#import "HomeCollectionModel.h"
#import "EnvelopViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ZCZBarViewController.h"
#import "SetViewController.h"
#import "ZbarPayViewController.h"
#import "UMSocialWechatHandler.h"
#import "UMSocial.h"
@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,BMKLocationServiceDelegate,ZBarReaderDelegate>
@property(nonatomic)UILabel *titleLabel;
@property(nonatomic)UIImageView *imagV;
@property(nonatomic)UITableView *TableView;
@property(nonatomic)UIView *titleView;
@property(nonatomic)UIView *HeadView;
@property(nonatomic)UICollectionView *CollectionView;
@property (strong,nonatomic) BMKLocationService *locService;
//用户纬度
@property (nonatomic,assign) double userLatitude;

//用户经度
@property (nonatomic,assign) double userLongitude;

//用户位置
@property (strong,nonatomic) CLLocation *clloction;
@property(nonatomic,copy)NSDictionary *sendDic;
//数据
@property(nonatomic,retain)NSMutableArray *tableViewdataSouceArray;
@property(nonatomic,retain)NSMutableArray *colllectionViewdataSouceArray;
@property(nonatomic)BOOL isRefreshing;
@property(nonatomic)BOOL isLoading;
@end

@implementation HomeViewController
+ (HomeViewController *)sharedInstance
{
    static HomeViewController *_instance = nil;
    
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewDidLoad];
    [self.view addSubview:self.TableView];
    [self.view addSubview:self.titleView];
    [self creatHeadView];
    [self fetchData];
    [self fetchTopic];
}
-(void)viewDidLoad{
}
-(void)fetchData{
    NSString *longitude=[NSString stringWithFormat:@"%f",self.userLongitude];
    NSString *latitude=[NSString stringWithFormat:@"%f",self.userLatitude];
    NSDictionary *dic=@{@"longitude":longitude,@"latitude":latitude};
    [[NetDataEngin sharedInstance]requestHomeMerchantParamter:dic Atpage:nil WithURL:HOME success:^(id responsData) {
        self.tableViewdataSouceArray=[HomeModel parseResponsData:responsData];
        [self.TableView reloadData];
        [self endRefresh];
    } failed:^(NSError *error) {
        [self endRefresh];
    }];
}
-(void)fetchTopic{
    [[NetDataEngin sharedInstance]requestremenAtpage:1 WithURL:TOPIC success:^(id responsData) {
        self.colllectionViewdataSouceArray=[HomeCollectionModel parseResponsData:responsData];
        [self.CollectionView reloadData];
        [self endRefresh];
    } failed:^(NSError *error) {
        [self.CollectionView reloadData];
        [self endRefresh];
    }];
}
-(void)fetchRefreshView
{
    __weak typeof(self) weakself = self;
    //下拉刷新
    //    for (UITableView *tableView in self.tableViewArr ) {
    [_TableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakself.isRefreshing) {
            return ;
        }
        weakself.isRefreshing = YES;
        //weakself.currentPage = 1;
        //[weakself acquireNetwork];
        [weakself fetchData];
    }];
    //上拉加载更多
    [self.TableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakself.isLoading) {
            return ;
        }
        //设置页数
        //weakself.currentPage++;
        weakself.isLoading = YES;
        //[weakself acquireNetwork];
        [weakself fetchData];
    }];
}
-(void)endRefresh
{
    if (self.isRefreshing) {
        self.isRefreshing = NO;
        [self.TableView headerEndRefreshingWithResult:JHRefreshResultNone];
    }
    if (self.isLoading) {
        self.isLoading = NO;
        [self.TableView footerEndRefreshing];
    }
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
//导航栏视图
-(UIView *)titleView{
    if (_titleView==nil) {
        self.navigationController.navigationBarHidden=YES;
        _titleView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        _titleView.backgroundColor=[UIColor clearColor];
        UIButton *drawerBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, 30, 25, 25)];
        [drawerBtn setBackgroundImage:[UIImage imageNamed:@"chouti"] forState:UIControlStateNormal];
        [drawerBtn addTarget:self action:@selector(drawer) forControlEvents:UIControlEventTouchUpInside];
        [_titleView addSubview:drawerBtn];
    }
    return _titleView;
}
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
-(UITableView *)TableView{
    if (_TableView==nil) {
        _TableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        //_TableView.estimatedRowHeight = 2000;
        _TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _TableView.dataSource=self;
        _TableView.delegate=self;
        _TableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [_TableView registerClass:[PerimeterTableViewCell class] forCellReuseIdentifier:@"cellId"];
    }
    return _TableView;
}
-(void)creatHeadView{
    _HeadView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , (SCREEN_HEIGHT-273.5*SCREEN_HEIGHTSCALE+44)*SCREEN_HEIGHTSCALE)];
    _HeadView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    [self creatOtherViews];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {
        [self creatRandomView1];
    }else{
    [self creatRandomView2];
    }
    [_HeadView addSubview:self.CollectionView];
    self.TableView.tableHeaderView=_HeadView;
    SetViewController *set=[[SetViewController alloc]init];
    set.ExitUpdateBlock=^{
        [self creatHeadView];
    };
}
-(void)creatRandomView1{
    _imagV=[[UIImageView alloc]initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, self.HeadView.frame.size.height-220*SCREEN_HEIGHTSCALE)];
    _imagV.userInteractionEnabled=YES;
    _imagV.image=[UIImage imageNamed:@"title bgtwo"];
    [_HeadView addSubview:_imagV];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, _imagV.frame.size.height-108*SCREEN_HEIGHTSCALE, 200, 50)];
    label.userInteractionEnabled=YES;
    label.layer.cornerRadius=3;
    [label.layer setBorderWidth:1];
    [label.layer setBorderColor:[UIColor whiteColor].CGColor];
    [_imagV addSubview:label];
    UIButton *loginBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(LoginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [label addSubview:loginBtn];
    UIButton *registBtn=[[UIButton alloc]initWithFrame:CGRectMake(100, 0, 100, 50)];
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [label addSubview:registBtn];
    UILabel *lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 10, 1, 30)];
    lineLabel.backgroundColor=[UIColor whiteColor];
    [label addSubview:lineLabel];
}
-(void)LoginBtnClick{
    LoginViewController *LoginV=[[LoginViewController alloc]init];
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:LoginV animated:YES];
    self.hidesBottomBarWhenPushed=NO;
//    [UMSocialData setAppKey:YMAPPKEY];
//    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
//    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//        if (response.responseCode == UMSResponseCodeSuccess) {
//            NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
//            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
//            NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);
//            NSString *openId=[response.thirdPlatformUserProfile objectForKey:@"openid"];
//            NSString *unionid=[response.thirdPlatformUserProfile objectForKey:@"unionid"];
//            NSString *country=[response.thirdPlatformUserProfile objectForKey:@"country"];
//            NSString *nickname=[response.thirdPlatformUserProfile objectForKey:@"nickname"];
//            NSString *city=[response.thirdPlatformUserProfile objectForKey:@"city"];
//            NSString *province=[response.thirdPlatformUserProfile objectForKey:@"province"];
//            NSString *language=[response.thirdPlatformUserProfile objectForKey:@"language"];
//            NSString *headimgurl=[response.thirdPlatformUserProfile objectForKey:@"headimgurl"];
//            NSString *sex=[response.thirdPlatformUserProfile objectForKey:@"sex"];
//            NSString *token=snsAccount.accessToken;
//            _sendDic=@{@"unionid":unionid,@"openid":openId,@"country":country,@"nickname":nickname,@"city":city,@"province":province,@"language":language,@"headimgurl":headimgurl,@"sex":sex,@"token":token};
//            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogin"];
//            [self creatRandomView2];
//            [[NetDataEngin sharedInstance]requestHomeParamter:_sendDic Atpage:nil WithURL:WXLOGIN success:^(id responsData) {
//                NSDictionary *responsDatadic=responsData;
//                NSInteger status=[responsDatadic[@"status"] integerValue];
//                if (status==200) {
//                    NSLog(@"登录成功");
//                    //用户数据
//                    NSMutableDictionary *data=responsData[@"data"];
//                    NSString *LoginToken=data[@"token"];
//                    NSString *phoneNumber=data[@"phoneNumber"];
//                    NSString *userOneBarCode=data[@"userOneBarCode"];
//                    NSString *scoreA=[NSString stringWithFormat:@"%@",data[@"scoreA"] ];
//                    NSString *scoreB=[NSString stringWithFormat:@"%@",data[@"scoreB"] ];
//                    NSString *headImageUrlStr=[NSString stringWithFormat:@"%@",data[@"headImageUrl"]];
//                    if ([headImageUrlStr isEqual:@"<null>"]) {
//                        NSData *imageData = UIImagePNGRepresentation([UIImage imageNamed:@"touxiang"]);
//                        [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"headImageUrl"];
//                    }else{
//                        NSString *headImageUrl=data[@"headImageUrl"];
//                        NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:headImageUrl]];
//                        [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"headImageUrl"];
//                    }
//                    [[NSUserDefaults standardUserDefaults] setObject:LoginToken forKey:@"LoginToken"];
//                    [[NSUserDefaults standardUserDefaults] setObject:phoneNumber forKey:@"PhoneNumber"];
//                    ;
//                    [[NSUserDefaults standardUserDefaults] setObject:userOneBarCode forKey:@"userOneBarCode"];
//                    [[NSUserDefaults standardUserDefaults] setObject:scoreA forKey:@"scoreA"];
//                    [[NSUserDefaults standardUserDefaults] setObject:scoreB forKey:@"scoreB"];
//                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogin"];
//                    [self.TableView reloadData];
//                }else{
//                    
//                    [MBHelper showHUDViewWithTextForFooterView:responsDatadic[@"msg"] withHUDColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.36]withDur:1.0];
//                }
//            } failed:^(NSError *error) {
//                
//            }];
//        }
//    });

}

-(void)registBtnClick{
    RegisterViewController *registV=[[RegisterViewController alloc]init];
    registV.typeId=@"1";
    registV.titleStr=@"注册";
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:registV animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}
-(void)creatRandomView2{
    _imagV=[[UIImageView alloc]initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, self.HeadView.frame.size.height-220*SCREEN_HEIGHTSCALE)];
    _imagV.userInteractionEnabled=YES;
    _imagV.image=[UIImage imageNamed:@"title bgtwo"];
    [_HeadView addSubview:_imagV];
    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame=CGRectMake(57, _imagV.frame.size.height-138*SCREEN_HEIGHTSCALE, 40 , 65) ;
    UIImageView *BtnimagV1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 35)];
    BtnimagV1.image=[UIImage imageNamed:@"payment_icon"];
    [btn1 addSubview:BtnimagV1];
    UILabel *BtnLabel1=[[UILabel alloc]initWithFrame:CGRectMake(0, 45*SCREEN_HEIGHTSCALE, 40, 20)];
    BtnLabel1.text=@"付款";
    BtnLabel1.textColor=[UIColor whiteColor];
    BtnLabel1.textAlignment=NSTextAlignmentCenter;
    [btn1 addSubview:BtnLabel1];
    [btn1 addTarget:self action:@selector(Paymoney) forControlEvents:UIControlEventTouchUpInside];
    [_imagV addSubview:btn1];
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame=CGRectMake(SCREEN_WIDTH/2-20, _imagV.frame.size.height-138*SCREEN_HEIGHTSCALE, 40 , 65) ;
    UIImageView *BtnimagV2=[[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 30, 35)];
    BtnimagV2.image=[UIImage imageNamed:@"red_icon"];
    [btn2 addSubview:BtnimagV2];
    UILabel *BtnLabel2=[[UILabel alloc]initWithFrame:CGRectMake(0, 45*SCREEN_HEIGHTSCALE, 40, 20)];
    BtnLabel2.text=@"红包";
    BtnLabel2.textColor=[UIColor whiteColor];
    BtnLabel2.textAlignment=NSTextAlignmentCenter;
    [btn2 addSubview:BtnLabel2];
    [btn2 addTarget:self action:@selector(Redenvelope) forControlEvents:UIControlEventTouchUpInside];
    [_imagV addSubview:btn2];
    UIButton *btn3=[UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame=CGRectMake(SCREEN_WIDTH-87, _imagV.frame.size.height-138*SCREEN_HEIGHTSCALE, 40 , 65) ;
    UIImageView *BtnimagV3=[[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 30, 35)];
    BtnimagV3.image=[UIImage imageNamed:@"integral_icon"];
    [btn3 addSubview:BtnimagV3];
    UILabel *BtnLabel3=[[UILabel alloc]initWithFrame:CGRectMake(0, 45*SCREEN_HEIGHTSCALE, 40, 20)];
    BtnLabel3.text=@"积分";
    BtnLabel3.textColor=[UIColor whiteColor];
    BtnLabel3.textAlignment=NSTextAlignmentCenter;
    [btn3 addSubview:BtnLabel3];
    [btn3 addTarget:self action:@selector(Integral) forControlEvents:UIControlEventTouchUpInside];
    [_imagV addSubview:btn3];
    UILabel *label4=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-60, _imagV.frame.size.height-65*SCREEN_HEIGHTSCALE, 110, 20)];
    label4.textAlignment=NSTextAlignmentCenter;
    label4.text=[NSString stringWithFormat:@"￥%.2f",[[[NSUserDefaults standardUserDefaults]objectForKey:@"scoreA"] floatValue]/100];
    label4.font=[UIFont systemFontOfSize:19.0];
    label4.textColor=[UIColor whiteColor];
    [_imagV addSubview:label4];
    
    UILabel *label5=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-122, _imagV.frame.size.height-65*SCREEN_HEIGHTSCALE, 110, 20)];
    label5.textAlignment=NSTextAlignmentCenter;
    label5.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"scoreB"];;
    label5.font=[UIFont systemFontOfSize:19.0];
    label5.textColor=[UIColor whiteColor];
    [_imagV addSubview:label5];
    
}
-(void)Paymoney{
//    ZbarPayViewController *vc=[[ZbarPayViewController alloc]init];
//    self.hidesBottomBarWhenPushed=YES;
//    [self.navigationController pushViewController:vc animated:YES];
//    self.hidesBottomBarWhenPushed=NO;
    ZCZBarViewController*vc=[[ZCZBarViewController alloc]initWithIsQRCode:NO Block:^(NSString *result, BOOL isFinish) {
        if (isFinish) {
            NSLog(@"最后的结果%@",result);
            //self.label.text = result;
            NSLog(@"%@",result);
        }
        
    }];
    [self presentViewController:vc animated:YES completion:nil];
}
-(void)Redenvelope{
    EnvelopViewController *enveVC=[[EnvelopViewController alloc]init];
    enveVC.titleStr=@"红包记录";
    enveVC.isEnvelope=YES;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:enveVC animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}
-(void)Integral{
    EnvelopViewController *enveVC=[[EnvelopViewController alloc]init];
    enveVC.titleStr=@"积分记录";
    enveVC.isEnvelope=NO;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:enveVC animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}
-(void)creatOtherViews{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"商城_01.png"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"商城_01.png"]];
    //下部
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, self.HeadView.frame.size.height-12.5, 50, 1)];
    label.backgroundColor=[UIColor colorWithRed:209.0/250.0 green:50.0/250.0 blue:53.0/250.0 alpha:1];
    [_HeadView addSubview:label];
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+60, self.HeadView.frame.size.height-12.5, 45, 1)];
    label2.backgroundColor=[UIColor colorWithRed:209.0/250.0 green:50.0/250.0 blue:53.0/250.0 alpha:1];
    [_HeadView addSubview:label2];
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-16.7, self.HeadView.frame.size.height-20.5, 60, 20)];
    label3.text=@"离我最近";
    label3.font=[UIFont systemFontOfSize:14.0];
    [_HeadView addSubview:label3];
    UIImageView *imagV=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-40, self.HeadView.frame.size.height-20.5, 15, 15)];
    imagV.image=[UIImage imageNamed:@"lately_icon"];
    [_HeadView addSubview:imagV];
    //上部
    UILabel *label4=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, self.HeadView.frame.size.height-213.5*SCREEN_HEIGHTSCALE, 50, 1)];
    label4.backgroundColor=[UIColor colorWithRed:209.0/250.0 green:50.0/250.0 blue:53.0/250.0 alpha:1];
    [_HeadView addSubview:label4];
    UILabel *label5=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+60, self.HeadView.frame.size.height-213.5*SCREEN_HEIGHTSCALE, 45, 1)];
    label5.backgroundColor=[UIColor colorWithRed:209.0/250.0 green:50.0/250.0 blue:53.0/250.0 alpha:1];
    [_HeadView addSubview:label5];
    UILabel *label6=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-16.7, self.HeadView.frame.size.height-221.5*SCREEN_HEIGHTSCALE, 60, 20)];
    label6.text=@"每日乐选";
    label6.font=[UIFont systemFontOfSize:14.0];
    [_HeadView addSubview:label6];
    UIImageView *imagV2=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-40, self.HeadView.frame.size.height-221*SCREEN_HEIGHTSCALE, 15, 15)];
    imagV2.image=[UIImage imageNamed:@"music-selection_icon"];
    [_HeadView addSubview:imagV2];
}
-(UICollectionView*)CollectionView{
    if (_CollectionView==nil) {
        UICollectionViewFlowLayout * flowLayout=[[UICollectionViewFlowLayout alloc]init];
//        //设置item之间的最小间距
        flowLayout.minimumInteritemSpacing=5;
        //设置最小行间距
        flowLayout.minimumLineSpacing=5;
        //设置每个item建议大小
        flowLayout.itemSize=CGSizeMake(240, 160);
        //设置滚动方向
        flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        //实例化collection
        _CollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, self.HeadView.frame.size.height-39*SCREEN_HEIGHTSCALE-160*SCREEN_HEIGHTSCALE, SCREEN_WIDTH, 162*SCREEN_HEIGHTSCALE) collectionViewLayout:flowLayout];
        _CollectionView.showsVerticalScrollIndicator=NO;
        //设置collectionView代理
        _CollectionView.delegate=self;
        _CollectionView.dataSource=self;
        //设置collectionView背景色
        _CollectionView.backgroundColor=[UIColor whiteColor];
        //注册cell类
        [_CollectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    }
    return _CollectionView;
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

/*--------------------------------------------------tableView代理方法--------------------------------*/
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150*SCREEN_HEIGHTSCALE;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableViewdataSouceArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PerimeterTableViewCell *cell=[self.TableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    HomeModel *model=[self.tableViewdataSouceArray objectAtIndex:indexPath.row];
    cell.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [cell.imagV sd_setImageWithURL:[NSURL URLWithString:model.picture] placeholderImage:[UIImage imageNamed:@"placeholder1.jpg"]];
    cell.nameLabel.text=model.name;
    cell.distanceLabel.text=model.distance;
    cell.adressLabel.text=model.location;
    CGSize size = [cell sizeThatFits:CGSizeMake(cell.adressLabel.frame.size.height, MAXFLOAT)];
    CGRect frame = cell.adressLabel.frame;
    frame.size.height = size.height;
    [cell.adressLabel setFrame:frame];
    cell.accountLabel.text=model.rebate;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MerchantViewController *mechant=[[MerchantViewController alloc]init];
    HomeModel *model=[self.tableViewdataSouceArray objectAtIndex:indexPath.row];
    self.hidesBottomBarWhenPushed=YES;
    mechant.detailId=model.iid;
    mechant.latitude=_userLatitude;
    mechant.longitude=_userLongitude;
    [self.navigationController pushViewController:mechant animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}
/*--------------------------------------------------CollectionView代理方法--------------------------------*/
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    if (cell==nil) {
        cell=[[HomeCollectionViewCell alloc]initWithFrame:CGRectMake(0, 0, 240, 150)];
    }
    if (self.colllectionViewdataSouceArray.count==3) {
        HomeCollectionModel *model=[self.colllectionViewdataSouceArray objectAtIndex:indexPath.row];
        [cell.imgV  sd_setImageWithURL:[NSURL URLWithString:model.picture] placeholderImage:[UIImage imageNamed:@"placeholder1.jpg"]];
        cell.priceLabel.text=[NSString stringWithFormat:@"￥%@起", model.minPrice ];
        cell.nameLabel.text=model.title;
        cell.littleDescriptionLabel.text=model.ddescription;
        cell.backgroundColor=[UIColor whiteColor];
    }else{
        cell.imgV.image=[UIImage imageNamed:@"placeholder1.jpg"];
    }
    
    //更新显示内容
    return cell;
}
//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    return 1;
//}
//每个section的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.colllectionViewdataSouceArray.count>1) {
        return self.colllectionViewdataSouceArray.count;
    }else{
        return 3;
    }
}
////定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(240, 150);
}
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
}
//*****************************************************************************************
#pragma mark - tabbar还原
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated]; 
}
@end
