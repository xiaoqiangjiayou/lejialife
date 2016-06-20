//
//  StoreViewController.m
//  LejiaLife
//
//  Created by 张强 on 16/3/21.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "StoreViewController.h"
#import "AppDelegate.h"
#import "Masonry.h"
#import "BaseViewController.h"
#import "SnacksTableView.h"
#import "FurnishingTableView.h"
#import "KitchenTableView.h"
#import "LifeTableView.h"
#import "AlltableViewViewController.h"
#import "SnacksDetailViewController.h"
#import "ShoppingCartViewController.h"
#import "StoreModel.h"
#import "TestTableViewCell.h"
#import "LoginViewController.h"
@interface StoreViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property(nonatomic)UILabel *linelabel1;
@property(nonatomic)UILabel *linelabel2;
@property(nonatomic)UILabel *linelabel3;
@property(nonatomic)UILabel *linelabel4;

@property(nonatomic)UITableView *snackstableView;
@property(nonatomic)UITableView *furnishingtableView;
@property(nonatomic)UITableView *lifetableView;
@property(nonatomic)UITableView *kitchentableView;
@property(nonatomic)UIScrollView *lejiaScrollView;

@property(nonatomic)UIImageView *imagV;
@property(nonatomic)UIButton *rightBarButton;
@property(nonatomic)UILabel *titleLabel;


@property(nonatomic)UIButton *btn1;
@property(nonatomic)UIButton *btn2;
@property(nonatomic)UIButton *btn3;
@property(nonatomic)UIButton *btn4;

@property(nonatomic)UILabel *label1;
@property(nonatomic)UILabel *label2;
@property(nonatomic)UILabel *label3;
@property(nonatomic)UILabel *label4;

@property(nonatomic)BOOL rememberFlag;
@property(nonatomic)BOOL rememberFlag2;
@property(nonatomic)BOOL rememberFlag3;
@property(nonatomic)BOOL rememberFlag4;

/*
 ------------wangluo---------
 */
@property(nonatomic,retain)NSArray *tableViewArr;
@property(nonatomic)BOOL isRefreshing;
@property(nonatomic)BOOL isLoading;
@property(nonatomic,retain)NSMutableArray *dataSouce;
@property(nonatomic,retain)NSMutableArray *FurshingdataSouce;
@property(nonatomic,retain)NSMutableArray *LifedataSouce;
@property(nonatomic,retain)NSMutableArray *kitChendatasouce;
@property(nonatomic)NSInteger currentPage;


@property(nonatomic)UIScrollView *titleScrollow;
@end
@implementation StoreViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden=NO;
    self.tabBarController.tabBar.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.lejiaScrollView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.imagV];
    [self creatTitleView];
    [self creatlinelabel];
    [self creatButtons];
    [self creatTableViews];
    self.currentPage=1;
    [self fetch];
    [self fetchFurching];
    [self fetchLife];
    [self fetchKitchen];
    [self fetchRefreshView];
    
}
//导航栏视图
-(void)creatTitleView{
    self.navigationController.navigationBarHidden=YES;
    UIView *TitleVIew=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    TitleVIew.backgroundColor=[UIColor clearColor];
    [self.view addSubview:TitleVIew];
    UIButton *drawerBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, 30, 25, 25)];
    [drawerBtn setBackgroundImage:[UIImage imageNamed:@"hamburg navigation_icon"] forState:UIControlStateNormal];
    [drawerBtn addTarget:self action:@selector(drawer) forControlEvents:UIControlEventTouchUpInside];
    [TitleVIew addSubview:drawerBtn];
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 30, 100, 20)];
    titleLabel.text=@"商城";
    titleLabel.font=[UIFont systemFontOfSize:20.0f];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.textColor=[UIColor whiteColor];
    [TitleVIew addSubview:titleLabel];
    _rightBarButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _rightBarButton.frame=CGRectMake(SCREEN_WIDTH-40, 30, 25, 25) ;
    [_rightBarButton setBackgroundImage:[UIImage imageNamed:@"shopping cart_icon.png"] forState:UIControlStateNormal];
    [_rightBarButton addTarget:self action:@selector(shoppingcart) forControlEvents:UIControlEventTouchUpInside];
    [TitleVIew addSubview:_rightBarButton];
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
-(UIImageView *)imagV{
    if (_imagV==nil) {
        _imagV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 141.5)];
        _imagV.image=[UIImage imageNamed:@"bg.png"];
    }
    return _imagV;
}
-(void)creatButtons{
    self.btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    self.btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    self.btn3=[UIButton buttonWithType:UIButtonTypeCustom];
    self.btn4=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.btn1];
    [self.view addSubview:self.btn2];
    [self.view addSubview:self.btn3];
    [self.view addSubview:self.btn4];
    
    [self.btn1 addSubview:self.linelabel1];
    [self.btn2 addSubview:self.linelabel2];
    [self.btn3 addSubview:self.linelabel3];
    [self.btn4 addSubview:self.linelabel4];
    
    
    self.btn1.frame=CGRectMake(30, 72.5, 30, 69);
    [self.btn1 setImage:[UIImage imageNamed:@"home-furnishing_icon2"] forState:UIControlStateNormal];
    self.label1=[[UILabel alloc]initWithFrame:CGRectMake(0, 30, 30, 18)];
    self.label1.text=@"家居";
    self.label1.textColor=[UIColor redColor];
    self.label1.font=[UIFont systemFontOfSize:15];
    [self.btn1 addSubview:self.label1];
    self.btn1.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 39, 0);
    [self.btn1 setTitleEdgeInsets:UIEdgeInsetsMake(18, 0, 0, 0)];
    [self.btn1 addTarget:self action:@selector(btn1click:) forControlEvents:UIControlEventTouchUpInside];
    
    self.linelabel1.backgroundColor=[UIColor redColor];
    
    self.btn2.frame=CGRectMake((SCREEN_WIDTH-180)/3+60, 72.5, 30, 69);
    [self.btn2 setImage:[UIImage imageNamed:@"snacks_icon"] forState:UIControlStateNormal];
    self.btn2.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 39, 0);
    self.label2=[[UILabel alloc]initWithFrame:CGRectMake(0, 30, 30, 18)];
    self.label2.text=@"零食";
    self.label2.font=[UIFont systemFontOfSize:15];
    self.label2.textColor=[UIColor whiteColor];
    [self.btn2 addSubview:self.label2];
    [self.btn2 addTarget:self action:@selector(btn2click:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.btn3.frame=CGRectMake(((SCREEN_WIDTH-180)/3)*2+90, 72.5, 30, 69);
    [self.btn3 setImage:[UIImage imageNamed:@"digital first_2x"] forState:UIControlStateNormal];
    self.btn3.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 39, 0);
    self.label3=[[UILabel alloc]initWithFrame:CGRectMake(0, 30, 30, 18)];
    self.label3.text=@"数码";
    self.label3.font=[UIFont systemFontOfSize:15];
    self.label3.textColor=[UIColor whiteColor];
    [self.btn3 addSubview:self.label3];
    [self.btn3 addTarget:self action:@selector(btn3click:) forControlEvents:UIControlEventTouchUpInside];
    self.btn4.frame=CGRectMake(((SCREEN_WIDTH-180)/3)*3+120, 72.5, 30, 69);
    [self.btn4 setImage:[UIImage imageNamed:@"outdoors first_"] forState:UIControlStateNormal];
    self.btn4.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 39, 0);
    self.label4=[[UILabel alloc]initWithFrame:CGRectMake(0, 30, 30, 18)];
    self.label4.text=@"户外";
    self.label4.font=[UIFont systemFontOfSize:15];
    self.label4.textColor=[UIColor whiteColor];
    [self.btn4 addSubview:self.label4];
    [self.btn4 addTarget:self action:@selector(btn4click:) forControlEvents:UIControlEventTouchUpInside];
    
    
}
-(void)btn1click:(UIButton *)button{
    [_lejiaScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    self.rememberFlag=YES;
    self.rememberFlag4=YES;
    self.rememberFlag3=YES;
    [self.btn2 setImage:[UIImage imageNamed:@"snacks_icon"] forState:UIControlStateNormal];
    self.label2.textColor=[UIColor whiteColor];
    [self.btn3 setImage:[UIImage imageNamed:@"digital first_2x"] forState:UIControlStateNormal];
    self.label3.textColor=[UIColor whiteColor];
    [self.btn4 setImage:[UIImage imageNamed:@"outdoors first_"] forState:UIControlStateNormal];
    self.label4.textColor=[UIColor whiteColor];
    self.linelabel2.backgroundColor=[UIColor clearColor];
    self.linelabel3.backgroundColor=[UIColor clearColor];
    self.linelabel4.backgroundColor=[UIColor clearColor];
    
    [button setImage:[UIImage imageNamed:@"home-furnishing_icon2"] forState:UIControlStateNormal];
    self.label1.textColor=[UIColor redColor];
    self.linelabel1.backgroundColor=[UIColor redColor];
    if (self.rememberFlag == NO) {
        self.rememberFlag = YES;
        [button setImage:[UIImage imageNamed:@"home-furnishing_icon2"] forState:UIControlStateNormal];
        self.label1.textColor=[UIColor redColor];
        self.linelabel1.backgroundColor=[UIColor redColor];
        
    } else {
        self.rememberFlag = YES;
        [button setImage:[UIImage imageNamed:@"home-furnishing_icon2"] forState:UIControlStateNormal];
        self.label1.textColor=[UIColor redColor];
        self.linelabel1.backgroundColor=[UIColor redColor];
    }
    
}
-(void)btn2click:(UIButton *)button{
    [_lejiaScrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
    self.rememberFlag=YES;
    self.rememberFlag4=YES;
    self.rememberFlag3=YES;
    [self.btn1 setImage:[UIImage imageNamed:@"home furnishing_icon"] forState:UIControlStateNormal];
    self.label1.textColor=[UIColor whiteColor];
    [self.btn3 setImage:[UIImage imageNamed:@"digital first_2x"] forState:UIControlStateNormal];
    self.label3.textColor=[UIColor whiteColor];
    [self.btn4 setImage:[UIImage imageNamed:@"outdoors first_"] forState:UIControlStateNormal];
    self.label4.textColor=[UIColor whiteColor];
    
    self.linelabel1.backgroundColor=[UIColor clearColor];
    self.linelabel3.backgroundColor=[UIColor clearColor];
    self.linelabel4.backgroundColor=[UIColor clearColor];
    
    [button setImage:[UIImage imageNamed:@"snacks_icon 2"] forState:UIControlStateNormal];
    self.label2.textColor=[UIColor whiteColor];
    if (self.rememberFlag2 == NO) {
        self.rememberFlag2 = YES;
        [button setImage:[UIImage imageNamed:@"snacks_icon 2"] forState:UIControlStateNormal];
        self.label2.textColor=[UIColor redColor];
        self.linelabel2.backgroundColor=[UIColor redColor];
        
    } else {
        self.rememberFlag2 = YES;
        [button setImage:[UIImage imageNamed:@"snacks_icon 2"] forState:UIControlStateNormal];
        self.label2.textColor=[UIColor redColor];
        self.linelabel2.backgroundColor=[UIColor redColor];
    }
}
-(void)btn3click:(UIButton *)button{
    [_lejiaScrollView setContentOffset:CGPointMake(SCREEN_WIDTH*2, 0) animated:YES];
    self.rememberFlag=YES;
    self.rememberFlag4=YES;
    self.rememberFlag2=YES;
    [self.btn1 setImage:[UIImage imageNamed:@"home furnishing_icon"] forState:UIControlStateNormal];
    self.label1.textColor=[UIColor whiteColor];
    [self.btn2 setImage:[UIImage imageNamed:@"snacks_icon"] forState:UIControlStateNormal];
    self.label2.textColor=[UIColor whiteColor];
    [self.btn4 setImage:[UIImage imageNamed:@"outdoors first_"] forState:UIControlStateNormal];
    self.label4.textColor=[UIColor whiteColor];
    
    self.linelabel2.backgroundColor=[UIColor clearColor];
    self.linelabel1.backgroundColor=[UIColor clearColor];
    self.linelabel4.backgroundColor=[UIColor clearColor];
    
    [button setImage:[UIImage imageNamed:@"digital second_"] forState:UIControlStateNormal];
    self.label3.textColor=[UIColor redColor];
    if (self.rememberFlag3 == NO) {
        self.rememberFlag3 = YES;
        [button setImage:[UIImage imageNamed:@"digital second_"] forState:UIControlStateNormal];
        self.label3.textColor=[UIColor redColor];
        self.linelabel3.backgroundColor=[UIColor redColor];
        
    } else {
        self.rememberFlag3 = YES;
        [button setImage:[UIImage imageNamed:@"digital second_"] forState:UIControlStateNormal];
        self.label3.textColor=[UIColor redColor];
        self.linelabel3.backgroundColor=[UIColor redColor];
    }
}
-(void)btn4click:(UIButton *)button{
    [_lejiaScrollView setContentOffset:CGPointMake(SCREEN_WIDTH*3, 0) animated:YES];
    self.rememberFlag=YES;
    self.rememberFlag2=YES;
    self.rememberFlag3=YES;
    [self.btn1 setImage:[UIImage imageNamed:@"home furnishing_icon"] forState:UIControlStateNormal];
    self.label1.textColor=[UIColor whiteColor];
    [self.btn3 setImage:[UIImage imageNamed:@"digital first_2x"] forState:UIControlStateNormal];
    self.label3.textColor=[UIColor whiteColor];
    [self.btn2 setImage:[UIImage imageNamed:@"snacks_icon"] forState:UIControlStateNormal];
    self.label2.textColor=[UIColor whiteColor];
    
    self.linelabel2.backgroundColor=[UIColor clearColor];
    self.linelabel3.backgroundColor=[UIColor clearColor];
    self.linelabel1.backgroundColor=[UIColor clearColor];
    
    [button setImage:[UIImage imageNamed:@"outdoors second_"] forState:UIControlStateNormal];
    self.label4.textColor=[UIColor whiteColor];
    self.linelabel4.backgroundColor=[UIColor clearColor];
    if (self.rememberFlag4 == NO) {
        self.rememberFlag4= YES;
        [button setImage:[UIImage imageNamed:@"outdoors second_"] forState:UIControlStateNormal];
        self.label4.textColor=[UIColor redColor];
        self.linelabel4.backgroundColor=[UIColor redColor];
        
    } else {
        self.rememberFlag4 = YES;
        [button setImage:[UIImage imageNamed:@"outdoors second_"] forState:UIControlStateNormal];
        self.label4.textColor=[UIColor redColor];
        self.linelabel4.backgroundColor=[UIColor redColor];
    }
}
-(void)creatlinelabel{
    self.linelabel1=[[UILabel alloc]initWithFrame:CGRectMake(0, 64.5, 30, 5)];
    self.linelabel2=[[UILabel alloc]initWithFrame:CGRectMake(0, 64.5, 30, 5)];
    self.linelabel3=[[UILabel alloc]initWithFrame:CGRectMake(0, 64.5, 30, 5)];
    self.linelabel4=[[UILabel alloc]initWithFrame:CGRectMake(0, 64.5, 30, 5)];
    self.linelabel1.layer.cornerRadius=2.5;
    self.linelabel2.layer.cornerRadius=2.5;
    self.linelabel3.layer.cornerRadius=2.5;
    self.linelabel4.layer.cornerRadius=2.5;
    self.linelabel1.clipsToBounds=YES;
    self.linelabel2.clipsToBounds=YES;
    self.linelabel3.clipsToBounds=YES;
    self.linelabel4.clipsToBounds=YES;
}

-(UIScrollView *)lejiaScrollView{
    if (_lejiaScrollView==nil) {
        _lejiaScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 141.5, SCREEN_WIDTH, SCREEN_HEIGHT-141.5)];
        _lejiaScrollView.backgroundColor=[UIColor whiteColor];
        _lejiaScrollView.contentSize=CGSizeMake(SCREEN_WIDTH*4, 0);
        _lejiaScrollView.pagingEnabled = YES;
        _lejiaScrollView.showsVerticalScrollIndicator=NO;
        _lejiaScrollView.showsHorizontalScrollIndicator=NO;
        _lejiaScrollView.bounces=NO;
        _lejiaScrollView.delegate=self;
    }
    return _lejiaScrollView;
}
-(void)creatTableViews{
    self.snackstableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-141.5-49) style:UITableViewStylePlain];
    [self.lejiaScrollView addSubview:self.snackstableView];
    self.furnishingtableView=[[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-141.5-49) style:UITableViewStylePlain];
    [self.lejiaScrollView addSubview:self.furnishingtableView];
    self.lifetableView=[[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, SCREEN_HEIGHT-141.5-49) style:UITableViewStylePlain];
    [self.lejiaScrollView addSubview:self.lifetableView];
    self.kitchentableView=[[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*3, 0, SCREEN_WIDTH, SCREEN_HEIGHT-141.5-49) style:UITableViewStylePlain];
    [self.lejiaScrollView addSubview:self.kitchentableView];
    self.snackstableView.delegate=self;
    self.snackstableView.dataSource=self;
    self.furnishingtableView.delegate=self;
    self.furnishingtableView.dataSource=self;
    self.lifetableView.delegate=self;
    self.lifetableView.dataSource=self;
    self.kitchentableView.delegate=self;
    self.kitchentableView.dataSource=self;
    [_snackstableView registerNib:[UINib nibWithNibName:@"TestTableViewCell" bundle:nil]forCellReuseIdentifier:@"cellId"];
    [_furnishingtableView registerNib:[UINib nibWithNibName:@"TestTableViewCell" bundle:nil]forCellReuseIdentifier:@"cellId"];
    [_lifetableView registerNib:[UINib nibWithNibName:@"TestTableViewCell" bundle:nil]forCellReuseIdentifier:@"cellId"];
    [_kitchentableView registerNib:[UINib nibWithNibName:@"TestTableViewCell" bundle:nil]forCellReuseIdentifier:@"cellId"];
}
-(void)shoppingcart{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {//如果未登录
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.navigationController.navigationBarHidden=YES;
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:loginVC animated:YES];
        self.hidesBottomBarWhenPushed=NO;
        loginVC.loginBlock = ^{
            ShoppingCartViewController *shopcart=[[ShoppingCartViewController alloc]init];
            shopcart.isLoginPush=YES;
            
            [self.navigationController pushViewController:shopcart animated:YES];
            
        };
        loginVC.notLoginBlock = ^{
            [self.navigationController popViewControllerAnimated:NO];
        };
        //未登录直接return,不在进行任何其他操作
        return;
    }else{
        ShoppingCartViewController *shopcart=[[ShoppingCartViewController alloc]init];
        shopcart.isLoginPush=NO;
        shopcart.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:shopcart animated:YES];
    }
}
#pragma Mark -scrollow代理方法-
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"已经结束减速");
    if(scrollView==_lejiaScrollView){
    if (_lejiaScrollView.contentOffset.x==0) {
        [self btn1click:_btn1];
    }else if(_lejiaScrollView.contentOffset.x==SCREEN_WIDTH){
        [self btn2click:_btn2];
    }else if (_lejiaScrollView.contentOffset.x==SCREEN_WIDTH*2){
        [self btn3click:_btn3];
    }else
        [self btn4click:_btn4];
    }
}

/*
---------------------------请求数据----------------------------
*/

-(void)fetch{

        [[NetDataEngin sharedInstance]requestremenAtpage:_currentPage WithURL:SNACKSLIST success:^(id responsData) {
            __weak typeof(self) weakself = self;
            if (weakself.isLoading==YES) {
                NSArray *newData=[StoreModel parseResponsData:responsData];
                for (StoreModel *model in newData) {
                    [weakself.dataSouce addObject:model];
                }
                
            }else{
                [weakself.dataSouce removeAllObjects];
                weakself.dataSouce=[StoreModel parseResponsData:responsData];
            }
            [weakself.snackstableView reloadData];
            [weakself endRefresh];
            
        } failed:^(NSError *error) {
            [self endRefresh];
        }];
};
-(void)fetchFurching{
    [[NetDataEngin sharedInstance]requestremenAtpage:_currentPage WithURL:FURNISHING success:^(id responsData) {
        __weak typeof(self) weakself = self;
        if (weakself.isLoading==YES) {
            NSArray *newData=[StoreModel parseResponsData:responsData];
            for (StoreModel *model in newData) {
                [weakself.FurshingdataSouce addObject:model];
            }
            
        }else{
            [weakself.FurshingdataSouce removeAllObjects];
            weakself.FurshingdataSouce=[StoreModel parseResponsData:responsData];
        }
        [self.furnishingtableView reloadData];
        [self endRefresh];
    } failed:^(NSError *error) {
        [self endRefresh];
    }];
}
-(void)fetchLife{
    [[NetDataEngin sharedInstance]requestremenAtpage:_currentPage WithURL:LIFELIST success:^(id responsData) {
        __weak typeof(self) weakself = self;
        if (weakself.isLoading==YES) {
            NSArray *newData=[StoreModel parseResponsData:responsData];
            for (StoreModel *model in newData) {
                [weakself.LifedataSouce addObject:model];
            }
            
        }else{
            [weakself.LifedataSouce removeAllObjects];
            weakself.LifedataSouce=[StoreModel parseResponsData:responsData];
        }
        [self.lifetableView reloadData];
        [self endRefresh];
    } failed:^(NSError *error) {
        [self endRefresh];
    }];
}
-(void)fetchKitchen{
    [[NetDataEngin sharedInstance]requestremenAtpage:_currentPage WithURL:KITCHENLIFT success:^(id responsData) {
        __weak typeof(self) weakself = self;
        if (weakself.isLoading==YES) {
            NSArray *newData=[StoreModel parseResponsData:responsData];
            for (StoreModel *model in newData) {
                [weakself.kitChendatasouce addObject:model];
            }
            
        }else{
            [weakself.kitChendatasouce removeAllObjects];
            weakself.kitChendatasouce=[StoreModel parseResponsData:responsData];
        }
        [self.kitchentableView reloadData];
        [self endRefresh];
    } failed:^(NSError *error) {
        [self endRefresh];
    }];
}
//****************************************************刷新******************************************************
-(void)fetchRefreshView
{
    __weak typeof(self) weakself = self;
    //下拉刷新
        [_snackstableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
            if (weakself.isRefreshing) {
                return ;
            }
            weakself.isRefreshing = YES;
            weakself.currentPage = 1;
            //[weakself acquireNetwork];
            [weakself fetch];
        }];
        //上拉加载更多
        [self.snackstableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
            if (weakself.isLoading) {
                return ;
            }
            //设置页数
            weakself.currentPage++;
            weakself.isLoading = YES;
            //[weakself acquireNetwork];
            [weakself fetch];
        }];
/*-------------------------------------------------------------------------------------------------------*/
    [_furnishingtableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakself.isRefreshing) {
            return ;
        }
        weakself.isRefreshing = YES;
        weakself.currentPage = 1;
        //[weakself acquireNetwork];
        [weakself fetchFurching];
    }];
    //上拉加载更多
    [self.furnishingtableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakself.isLoading) {
            return ;
        }
        //设置页数
        weakself.currentPage++;
        weakself.isLoading = YES;
        //[weakself acquireNetwork];
        [weakself fetchFurching];
    }];
/*-------------------------------------------------------------------------------------------------------*/
    [_kitchentableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakself.isRefreshing) {
            return ;
        }
        weakself.isRefreshing = YES;
        weakself.currentPage = 1;
        //[weakself acquireNetwork];
        [weakself fetchLife];
    }];
    //上拉加载更多
    [self.kitchentableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakself.isLoading) {
            return ;
        }
        //设置页数
        weakself.currentPage++;
        weakself.isLoading = YES;
        //[weakself acquireNetwork];
        [weakself fetchLife];
    }];
/*-------------------------------------------------------------------------------------------------------*/
    [_lifetableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakself.isRefreshing) {
            return ;
        }
        weakself.isRefreshing = YES;
        weakself.currentPage = 1;
//        [weakself.LifedataSouce removeAllObjects];
        //[weakself acquireNetwork];
        [weakself fetchKitchen];
    }];
    //上拉加载更多
    [self.lifetableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakself.isLoading) {
            return ;
        }
        //设置页数
        weakself.currentPage++;
        weakself.isLoading = YES;
        //[weakself acquireNetwork];
        [weakself fetchKitchen];
    }];
   }
-(void)endRefresh{
    if (self.isRefreshing) {
        self.isRefreshing = NO;
        [self.snackstableView headerEndRefreshingWithResult:JHRefreshResultNone];
        [self.furnishingtableView headerEndRefreshingWithResult:JHRefreshResultNone];
        [self.kitchentableView headerEndRefreshingWithResult:JHRefreshResultNone];
        [self.lifetableView headerEndRefreshingWithResult:JHRefreshResultNone];
    }
    if (self.isLoading) {
        self.isLoading = NO;
        [self.snackstableView footerEndRefreshing];
        [self.furnishingtableView footerEndRefreshing];
        [self.kitchentableView footerEndRefreshing];
        [self.lifetableView footerEndRefreshing];
    }
}
#pragma Mark-代理方法-

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

        return 121;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==self.snackstableView) {
        return self.dataSouce.count;
    }else if (tableView==self.furnishingtableView){
        return self.FurshingdataSouce.count;
    }else if (tableView==self.lifetableView){
        return self.LifedataSouce.count;
    }else
    {
        return self.kitChendatasouce.count;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_snackstableView)
    {
        TestTableViewCell *cell1 = [_snackstableView dequeueReusableCellWithIdentifier:@"cellId" ];
    if (cell1==nil)
    {
        cell1 = [[TestTableViewCell alloc] init];
    }
        StoreModel *model=[self.dataSouce objectAtIndex:indexPath.row];
        [cell1 updateWith:model];
        
        return cell1;
    }
    else if (tableView==_furnishingtableView)
    {
     TestTableViewCell *cell2 = [_furnishingtableView dequeueReusableCellWithIdentifier:@"cellId" ];
        if (cell2==nil)
        {
            cell2 = [[TestTableViewCell alloc] init];
        }
        StoreModel *model=[self.FurshingdataSouce objectAtIndex:indexPath.row];
        [cell2 updateWith:model];
        return cell2;
        
    }
    else if (tableView==_lifetableView)
    {
    TestTableViewCell *cell3 = [_lifetableView dequeueReusableCellWithIdentifier:@"cellId" ];
        if (cell3==nil) {
            cell3 = [[TestTableViewCell alloc] init];
        }
        StoreModel *model=[self.LifedataSouce objectAtIndex:indexPath.row];
        [cell3 updateWith:model];
        return cell3;
    }else
    {
        TestTableViewCell *cell4 = [_kitchentableView dequeueReusableCellWithIdentifier:@"cellId" ];
        if (cell4==nil) {
            cell4 = [[TestTableViewCell alloc] init];
        }
        StoreModel *model=[self.kitChendatasouce objectAtIndex:indexPath.row];
        [cell4 updateWith:model];
        return cell4;
    }
   
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.snackstableView) {
        SnacksDetailViewController *snacksDetail=[[SnacksDetailViewController alloc]init];
        snacksDetail.hidesBottomBarWhenPushed=YES;
        StoreModel *model=[self.dataSouce objectAtIndex:indexPath.row];
        snacksDetail.DetailId=[model.detailId stringValue];
        NSLog(@"%@",model.detailId);
       [self.navigationController pushViewController:snacksDetail animated:YES];
    }else if (tableView==self.furnishingtableView){
        SnacksDetailViewController *snacksDetail=[[SnacksDetailViewController alloc]init];
        snacksDetail.hidesBottomBarWhenPushed=YES;
        StoreModel *model=[self.FurshingdataSouce objectAtIndex:indexPath.row];
        snacksDetail.DetailId=[model.detailId stringValue];
        NSLog(@"%@",model.detailId);
        [self.navigationController pushViewController:snacksDetail animated:YES];
    }else if (tableView==self.lifetableView){
        SnacksDetailViewController *snacksDetail=[[SnacksDetailViewController alloc]init];
        snacksDetail.hidesBottomBarWhenPushed=YES;
        StoreModel *model=[self.LifedataSouce objectAtIndex:indexPath.row];
        snacksDetail.DetailId=[model.detailId stringValue];
        NSLog(@"%@",model.detailId);
        [self.navigationController pushViewController:snacksDetail animated:YES];
    }else if (tableView==self.kitchentableView){
        SnacksDetailViewController *snacksDetail=[[SnacksDetailViewController alloc]init];
        snacksDetail.hidesBottomBarWhenPushed=YES;
        StoreModel *model=[self.kitChendatasouce objectAtIndex:indexPath.row];
        snacksDetail.DetailId=[model.detailId stringValue];
        NSLog(@"%@",model.detailId);
        [self.navigationController pushViewController:snacksDetail animated:YES];
    }
    
    /*-----------------------------动画-------------------------*/
//    CATransition *transition = [CATransition animation];
//    transition.duration = 1;
//    transition.delegate = self;
//    transition.type = @"rippleEffect";
//    [self.navigationController.view.layer addAnimation:transition forKey:nil];
}
//*********************************转场*********************
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"StoreController"];//("PageOne"为页面名称，可自定义)
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"StoreController"];
}
@end
