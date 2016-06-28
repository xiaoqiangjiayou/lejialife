//
//  SnacksDetailViewController.m
//  LejiaLife
//
//  Created by 张强 on 16/3/28.
//  Copyright © 2016年 张强. All rights reserved.
//
#import "SnacksDetailViewController.h"
#import "SnacksTableViewCell.h"
#import "SnacksFirstTableViewCell.h"
#import "SnacksThirdTableViewCell.h"
#import "StoreViewController.h"
#import "ShoppingCartViewController.h"
#import "AppDelegate.h"
#import "GoshoppingViewController.h"
#import "SnacksDetailModel.h"
#import "GrayPageControl.h"
#import "DBManager.h"
#import "GoodsModel.h"
#import "typeSpaceModel.h"
#import "MBHelper.h"
#import "LoginViewController.h"
#import "GoshoppingModel.h"
@interface SnacksDetailViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
//滚动视图上面控件
@property(nonatomic)UIScrollView *ScrollowView;
@property(nonatomic)UIScrollView *littlescrollow;
@property(nonatomic,retain)UILabel *label1;
@property(nonatomic,retain)UILabel *label2;
@property(nonatomic,retain)UILabel *label3;
@property(nonatomic,retain)UILabel *label4;
//View上面的控件
@property(nonatomic)UIView *titleView;
@property(nonatomic)UIButton *titleBtn1;
@property(nonatomic)UIButton *titleBtn2;
@property(nonatomic)UILabel *titleLabel1;
@property(nonatomic)UILabel *titleLabel2;
@property(nonatomic)UIButton *manybtn;
@property(nonatomic)UIPageControl *myPagecontroller;
@property(nonatomic)UIButton *shoppingcart;
@property(nonatomic)UIButton *shoping;
@property(nonatomic)UIButton *favarite;
//蒙层
@property(nonatomic)UIView *btnView;
@property(nonatomic)UIView *chooseView;
@property(nonatomic)UITableView *chooseTableView;
@property(nonatomic,retain)NSMutableArray<typeSpaceModel*> * popWindowDatasouceArray;
@property(nonatomic)UILabel *animationLabel;
@property(nonatomic)UILabel *animationLabel2;
//数据
@property(nonatomic,retain)NSMutableDictionary *dataSouceDic;
@property(nonatomic,retain)NSArray *littleScrowDatasouceArray;
@property(nonatomic,retain)NSMutableArray *detailScrowDataSouceArray;
@property(nonatomic,retain)NSArray *detailPictureHighArray;
@property(nonatomic,copy)NSString *detailHith;

@property(nonatomic)NSInteger currentPage;
@end
@implementation SnacksDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    [MobClick beginLogPageView:@"snacksController"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.titleView];
    [self creatbottomView];
    [self.view addSubview:self.ScrollowView];
    [self.ScrollowView addSubview:self.littlescrollow];
    [self.ScrollowView addSubview:self.myPagecontroller];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self creatTitleLabels];
    [self creatTitleButtons];
    [self creatLabels];
    [self fetch];
}
/*---------------------------请求数据---------------------------- */
-(void)fetch{
    NSInteger DetailId=[self.DetailId integerValue];
    [[NetDataEngin sharedInstance]requestremenAtpage:DetailId WithURL:SNACKDETAILLIST success:^(id responsData) {
        self.dataSouceDic=[NSMutableDictionary dictionaryWithDictionary:[SnacksDetailModel parseResponsData:responsData] ];
        self.popWindowDatasouceArray=[typeSpaceModel parseResponsData:[responsData objectForKey:@"productSpecs"] ];
        [_chooseTableView reloadData];
        [self performSelectorOnMainThread:@selector(shuaxinUI) withObject:nil waitUntilDone:YES];
    } failed:^(NSError *error)
    {
        NSLog(@"shibai");
    }];
    
};
-(void)shuaxinUI{
    self.label1.text=[self.dataSouceDic objectForKey:@"name"];
    self.label2.text=[self.dataSouceDic objectForKey:@"detaildescription"];
    self.label3.text=[self.dataSouceDic objectForKey:@"price"];
    self.littleScrowDatasouceArray=[self.dataSouceDic objectForKey:@"littleScrollowDatasouceArray"];
    //上部小滚动视图
    _littlescrollow.contentSize=CGSizeMake(SCREEN_WIDTH*self.littleScrowDatasouceArray.count, 0);
    _littlescrollow.pagingEnabled= YES;
    for (int i=0; i<_littleScrowDatasouceArray.count; i++) {
        UIImageView *imagV=[[UIImageView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, 350*SCREEN_HEIGHTSCALE)];
        NSString *str=[_littleScrowDatasouceArray objectAtIndex:i];
        [imagV sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"placeholder1.jpg"]];
        imagV.userInteractionEnabled = YES;
        imagV.tag=100+i;
        [_littlescrollow addSubview:imagV];
    }
    _myPagecontroller.numberOfPages = self.littleScrowDatasouceArray.count;
    self.detailHith=[self.dataSouceDic objectForKey:@"scrollowHith"];
    self.detailPictureHighArray=[self.dataSouceDic objectForKey:@"scrollowHighArr"];
    self.detailScrowDataSouceArray=[self.dataSouceDic objectForKey:@"detailDatasouceArray"];
    _ScrollowView.contentSize=CGSizeMake(0, SCREEN_HEIGHT+[self.detailHith intValue]);
    int h=0;
    for (int i=0; i<self.detailScrowDataSouceArray.count; i++) {
        UIImageView *imagV=[[UIImageView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-64+h, SCREEN_WIDTH, [[self.detailPictureHighArray objectAtIndex:i] intValue])];
         h+=[[self.detailPictureHighArray objectAtIndex:i] intValue];
        [imagV sd_setImageWithURL:[NSURL URLWithString:[self.detailScrowDataSouceArray objectAtIndex:i]] placeholderImage:[UIImage imageNamed:@"placeholder1.jpg"]];
        [self.ScrollowView addSubview:imagV];
    }
}
/*-------------------------------中间展示Label--------------------------*/
-(void)creatLabels{
    __weak __typeof(&*self)weakSelf = self;
    UILabel *label1=[[UILabel alloc]init];
    [_ScrollowView addSubview:label1];
    label1.text=@"甜丫头 桂花黑糖    ";
    label1.textAlignment=NSTextAlignmentCenter;
    label1.font =[UIFont systemFontOfSize:16.0f];
    [label1 sizeToFit];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(weakSelf.view).offset(0);
        make.top.mas_equalTo(weakSelf.littlescrollow).offset(weakSelf.littlescrollow.frame.size.height+20.0f);
    }];
    UILabel *label2=[[UILabel alloc]init];
    __weak __typeof(&*label1)weakSelflabel1 = label1;
    label2.textAlignment=NSTextAlignmentCenter;
    label2.textColor=[UIColor colorWithRed:140.0/250.0 green:140.0/250.0 blue:140.0/250.0 alpha:1];
    label2.text=@"香留唇齿，消脂清肠";
    label2.font =[UIFont systemFontOfSize:13.0f];
    [label2 sizeToFit];
    [_ScrollowView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelflabel1);
        make.top.mas_equalTo(weakSelflabel1).offset((weakSelflabel1.frame.size.height + 15)*SCREEN_HEIGHTSCALE);
    }];
    UILabel *label4=[[UILabel alloc]init];
    label4.textAlignment=NSTextAlignmentCenter;
    label4.text=@"xxxxxxxxxxxxxxxxxxxxxxxxxxx";
    label4.textColor=[UIColor whiteColor];
    [_ScrollowView addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelflabel1);
        make.bottom.mas_equalTo(weakSelf.manybtn).offset(-20-weakSelf.manybtn.frame.size.height*SCREEN_HEIGHTSCALE);
    }];
    UILabel *label5=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 10, 100, 20)];
    label5.text=@"满128包邮";
    label5.backgroundColor=[UIColor colorWithRed:210.0/250.0 green:48.0/250.0 blue:53.0/250.0 alpha:1];
    label5.textColor=[UIColor whiteColor];
    label5.font =[UIFont systemFontOfSize:13.0f];
    label5.textAlignment=NSTextAlignmentCenter;
    label5.layer.cornerRadius=2;
    label5.clipsToBounds=YES;
    [label4 addSubview:label5];
    UILabel *label3=[[UILabel alloc]init];
    __weak __typeof(&*label4)weakSelflabel4 = label4;
    label3.textAlignment=NSTextAlignmentCenter;
    label3.text=@"￥68.00  ~  68.00";
    label3.textColor=[UIColor colorWithRed:210.0/250.0 green:48.0/250.0 blue:53.0/250.0 alpha:1];
    label3.font =[UIFont systemFontOfSize:23.0f];
    [label3 sizeToFit];
    [_ScrollowView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelflabel1);
        make.bottom.mas_equalTo(weakSelflabel4).offset((-20-weakSelflabel4.frame.size.height)*SCREEN_HEIGHTSCALE);
    }];
    self.label1=label1;
    self.label2=label2;
    self.label3=label3;
    self.label4=label4;
}

/*-------------------------------------------上部滚动视图-----------------------------*/
-(UIScrollView*)littlescrollow{
    if (_littlescrollow==nil) {
        _littlescrollow= [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 350*SCREEN_HEIGHTSCALE) ];
        _littlescrollow.showsHorizontalScrollIndicator=NO;
        _littlescrollow.delegate=self;
    }
    return _littlescrollow;
}

-(UIPageControl *)myPagecontroller{
    if (_myPagecontroller==nil) {
        _myPagecontroller = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, 300, 40)];
        _myPagecontroller.center = CGPointMake(self.littlescrollow.frame.size.width/2, self.littlescrollow.frame.size.height-20);
    
        _myPagecontroller.pageIndicatorTintColor = [UIColor groupTableViewBackgroundColor];
        _myPagecontroller.currentPageIndicatorTintColor = [UIColor redColor];
    }
//    [_myPagecontroller addTarget:self action:@selector(pageTurn) forControlEvents:UIControlEventTouchUpInside];
    return _myPagecontroller;
}
//-(void)pageTurn{
//
//}
/*-------------------------导航栏--------------------------------------------*/
-(UIView*)titleView{
    if (_titleView==nil) {
        _titleView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        UIImageView *imagV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        imagV.image=[UIImage imageNamed:@"title background"];
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 74)];
        [btn setImage:[UIImage imageNamed:@"return_icon"] forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(15, -20, 5, 15)];
        [btn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [_titleView addSubview:imagV];
        [_titleView addSubview:btn];
    }
    return _titleView;
}
-(void)creatTitleButtons{
    self.titleBtn1.selected=YES;
    self.titleBtn2.selected=NO;
    self.titleBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
    self.titleBtn2=[UIButton buttonWithType:UIButtonTypeCustom];
    self.titleBtn1.frame=CGRectMake(SCREEN_WIDTH/2-60, 20, 60, 44);
    self.titleBtn2.frame=CGRectMake(SCREEN_WIDTH/2, 20, 60, 44);
    [self.titleBtn1 setTitle:@"商品" forState:UIControlStateNormal];
    [self.titleBtn2 setTitle:@"详情" forState:UIControlStateNormal];
    [self.titleBtn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.titleBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.titleBtn1 addSubview:self.titleLabel1];
    [self.titleBtn2 addSubview:self.titleLabel2];
    [self.titleView addSubview:self.titleBtn1];
    [self.titleView addSubview:self.titleBtn2];
    [self.titleBtn1 addTarget:self action:@selector(titlebtn1click:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleBtn2 addTarget:self action:@selector(titlebtn2click:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)creatTitleLabels{
    self.titleLabel1=[[UILabel alloc]initWithFrame:CGRectMake(0, 41, 60, 3)];
    self.titleLabel2=[[UILabel alloc]initWithFrame:CGRectMake(0, 41, 60, 3)];
    self.titleLabel1.clipsToBounds=YES;
    self.titleLabel2.clipsToBounds=YES;
    self.titleLabel1.backgroundColor=[UIColor redColor];
    self.titleLabel2.backgroundColor=[UIColor clearColor];
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)titlebtn1click:(UIButton*)titlebtn1{
    if (self.titleBtn1.selected==NO) {
        self.titleBtn1.selected=YES;
        self.titleBtn2.selected=NO;
        [self.titleBtn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.titleLabel1.backgroundColor=[UIColor redColor];
        [self.titleBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel2.backgroundColor=[UIColor clearColor];
        [self.ScrollowView setContentOffset:CGPointMake(0 , 0) animated:YES];
    }
}
-(void)titlebtn2click:(UIButton*)titlebtn2{
    if (self.titleBtn2.selected==NO) {
        self.titleBtn1.selected=NO;
        self.titleBtn2.selected=YES;
        [self.titleBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel1.backgroundColor=[UIColor clearColor];
        [self.titleBtn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.titleLabel2.backgroundColor=[UIColor redColor];
        [self.ScrollowView setContentOffset:CGPointMake(0, SCREEN_HEIGHT-64) animated:YES];
    }
}
/*-----------------------------------------总体滚动视图---------------------------------------*/
-(UIScrollView*)ScrollowView{
    if (_ScrollowView==nil) {
        _ScrollowView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-49-64)];
        _ScrollowView.pagingEnabled = YES;
        _ScrollowView.showsHorizontalScrollIndicator=NO;
        _ScrollowView.bounces=NO;
        _ScrollowView.delegate=self;
        _ScrollowView.backgroundColor=[UIColor whiteColor];
        _manybtn= [UIButton buttonWithType:UIButtonTypeCustom];
        [_manybtn.layer setBorderWidth:1];
        [_manybtn.layer setBorderColor:[UIColor groupTableViewBackgroundColor].CGColor];
        _manybtn.frame= CGRectMake(0, SCREEN_HEIGHT-49-35*SCREEN_HEIGHTSCALE-64, SCREEN_WIDTH, 35*SCREEN_HEIGHTSCALE);
        [_manybtn setTitle:@"规格数量选择    " forState:UIControlStateNormal];
        _manybtn.titleEdgeInsets=UIEdgeInsetsMake(0, -SCREEN_WIDTH/2, 0, 0);
        _manybtn.titleLabel.font=[UIFont systemFontOfSize:16.0f];
        [_manybtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        UIImageView *imagV=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-25, 10, 10, 15)];
        imagV.image=[UIImage imageNamed:@"choice_iconn.png"];
        [_manybtn addSubview:imagV];
        [_manybtn addTarget:self action:@selector(chooseclick:) forControlEvents:UIControlEventTouchUpInside];
        [_ScrollowView addSubview:_manybtn];
    }
    return _ScrollowView;
}

/*---蒙层以及弹窗---------------------------------------------------------------*/
-(void)chooseclick:(UIButton*)manyBtn{
    _chooseView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49)];
    _chooseView.backgroundColor=[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.36];
    NSInteger length=0;
    for (typeSpaceModel *model in _popWindowDatasouceArray) {
        length+= model.typeSpecDetail.length;
    }
    NSInteger heigh=355;
    if (length<=40) {
        heigh=310;
    }else if (length>40&&length<=60){
        heigh=375;
    }else if(length>60&&length<=80){
        heigh=395;
    }else if (length>80&&length<100){
        heigh=415;
    }else{
        heigh=455;
    }
    _chooseTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-heigh-49, SCREEN_WIDTH, heigh-0.5)];
    [_chooseTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _chooseTableView.delegate=self;
    _chooseTableView.dataSource=self;
    _chooseTableView.backgroundColor=[UIColor whiteColor];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    tap.numberOfTapsRequired=1;
    [_chooseView addGestureRecognizer:tap];

/*-------------------------------------样式款式选择Button--------------------------------------------------*/
    [_chooseView addSubview:_chooseTableView];
    UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame= CGRectMake(SCREEN_WIDTH-26, 0, 22, 22);
    [btn setTitle:@"x" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_chooseTableView addSubview:btn];
    [btn addTarget:self action:@selector(disChoose) forControlEvents:UIControlEventTouchUpInside];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.window addSubview:_chooseView];
    CATransition *transion=[CATransition animation];
    transion.type=@"fade";
    //设置转场动画的方向
    transion.subtype=@"fromBottom";
    //把动画添加到某个view的图层上
    [delegate.window.layer addAnimation:transion forKey:nil];
}
/*-------------------------------弹窗消失---------------------------*/
-(void)tapClick{
    [_chooseView removeFromSuperview];
}
-(void)disChoose{
    [_chooseView removeFromSuperview];
}
/*--------------------------------底部视图-----------------------------------*/
-(void)creatbottomView{
    _shoppingcart= [UIButton buttonWithType:UIButtonTypeCustom];
    _shoppingcart.backgroundColor=[UIColor whiteColor];
    _shoppingcart.frame= CGRectMake(0 , SCREEN_HEIGHT-49, (SCREEN_WIDTH-150*SCREEN_WIDTHSCALE-150*SCREEN_WIDTHSCALE), 49);
    UILabel *shoppingcartlabel=[[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-(150-150-1)*SCREEN_WIDTHSCALE), 0, 1, 49)];
    shoppingcartlabel.backgroundColor=[UIColor colorWithRed:231/255 green:232/255 blue:233/255 alpha:0.1];
    
    _animationLabel2=[[UILabel alloc]initWithFrame:CGRectMake(45, 10, 15, 15)];
    _animationLabel2.layer.cornerRadius=7.5;
    _animationLabel2.clipsToBounds=YES;
    _animationLabel2.backgroundColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    _animationLabel2.text=[NSString stringWithFormat:@"%ld",[[DBManager manager]readAllGoods].count ];
    _animationLabel2.textColor=[UIColor whiteColor];
    _animationLabel2.font=[UIFont systemFontOfSize:9];
    _animationLabel2.textAlignment=NSTextAlignmentCenter;
    [_shoppingcart addSubview:_animationLabel2];
    [_shoppingcart addSubview:shoppingcartlabel];
    [_shoppingcart setImage:[UIImage imageNamed:@"shopping cart@2x_icon"] forState:UIControlStateNormal];
    [_shoppingcart addTarget:self action:@selector(shoppingcartclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_shoppingcart];
    _shoping=[UIButton buttonWithType:UIButtonTypeCustom];
    _shoping.frame= CGRectMake((SCREEN_WIDTH-300*SCREEN_WIDTHSCALE), SCREEN_HEIGHT-49, 150*SCREEN_WIDTHSCALE, 49);
    _shoping.backgroundColor=[UIColor whiteColor];
    [_shoping setTitle:@"立即购买" forState:UIControlStateNormal];
    [_shoping.layer setBorderWidth:1];
    [_shoping.layer setBorderColor:[UIColor groupTableViewBackgroundColor].CGColor];
    [_shoping setTitleColor:[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1]forState:UIControlStateNormal];
    [_shoping addTarget:self action:@selector(shoppingclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_shoping];
    _favarite=[UIButton buttonWithType:UIButtonTypeCustom];
    _favarite.frame= CGRectMake((150*SCREEN_WIDTHSCALE+(SCREEN_WIDTH-300*SCREEN_WIDTHSCALE)), SCREEN_HEIGHT-49, 150*SCREEN_WIDTHSCALE, 49);
    [_favarite setTitle:@"加入购物车" forState:UIControlStateNormal];
    _favarite.backgroundColor=[UIColor colorWithRed:214/255.0 green:46/255.0 blue:46/255.0 alpha:1.0];
    _favarite.titleLabel.textColor=[UIColor whiteColor];
    [_favarite addTarget:self action:@selector(favoriteclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_favarite];

}
/*------------------------------推进购物车页面------------------------------*/
-(void)shoppingcartclick{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {//如果未登录
        [_chooseView removeFromSuperview];
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.navigationController.navigationBarHidden=YES;
        [self.navigationController pushViewController:loginVC animated:YES];
        loginVC.loginBlock = ^{
            ShoppingCartViewController *shopcart=[[ShoppingCartViewController alloc]init];
            [self.navigationController pushViewController:shopcart animated:YES];
        };
        loginVC.notLoginBlock = ^{
            [self.navigationController popViewControllerAnimated:NO];
        };
        //未登录直接return,不在进行任何其他操作
        return;
    }else{
    [_chooseView removeFromSuperview];
    ShoppingCartViewController *shopcart=[[ShoppingCartViewController alloc]init];
//    shopcart.isLoginPush=NO;
    [self.navigationController pushViewController:shopcart animated:YES];
    }
}
/*------------------------------进入购买页面------------------------------*/
-(void)shoppingclick{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {//如果未登录
        [_chooseView removeFromSuperview];
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.navigationController.navigationBarHidden=YES;
        [self.navigationController pushViewController:loginVC animated:YES];
        loginVC.loginBlock = ^{
            GoshoppingViewController *Goshopping=[[GoshoppingViewController alloc]init];
//            Goshopping.isLoginPush=YES;
//            Goshopping.DetailId=self.DetailId;
            [self.navigationController pushViewController:Goshopping animated:YES];
            
        };
        loginVC.notLoginBlock = ^{
            [self.navigationController popViewControllerAnimated:NO];
        };
        //未登录直接return,不在进行任何其他操作
        return;
    }else{
        for (typeSpaceModel *model in self.popWindowDatasouceArray) {
            if (model.btnSelecd==NO&&_chooseView==nil) {
                [self chooseclick:_manybtn];
            }else{
                if (model.btnSelecd==NO) {
//                    [MBHelper showHUDViewWithTextForFooterView:@"请选择规格数量"withHUDColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.36]withDur:1.0];
                }else{
                    [_chooseView removeFromSuperview];
                    NSString *productSpecId=[[NSString alloc]init];
                    for (typeSpaceModel *model in _popWindowDatasouceArray) {
                        if (model.btnSelecd==YES) {
                            productSpecId=model.typeId;
                        }
                    }
                    NSDictionary *sendDic=@{@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginToken"],@"productId":_dataSouceDic[@"productId"],@"productNum":_dataSouceDic[@"cellNumber"],@"productSpecId":productSpecId};
                    [[NetDataEngin sharedInstance]creatOrderParamter:sendDic WithURL:SNACKDETAILCREATORDER success:^(id responsData){
                        NSDictionary *responsDatadic=responsData;
                        NSInteger status=[responsDatadic[@"status"] integerValue];
                        if (status==200) {
                            GoshoppingViewController *go=[[GoshoppingViewController alloc]init];
                            go.HeadFootdataSouceArray=[GoshoppingModel parseResponsData:responsDatadic];
                            go.isOrderPush=NO;
                            go.dataSouceArray=[GoshoppingCellModel parseResponsData:responsDatadic];
                            [MBHelper showHUDViewWithTextForFooterView:responsDatadic[@"msg"] withHUDColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.36]withDur:1.0];
                            [self.navigationController pushViewController:go animated:YES];
                        }else{
//                            [MBHelper showHUDViewWithTextForFooterView:responsDatadic[@"msg"] withHUDColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.36]withDur:1.0];
                        }
                    } failed:^(NSError *error) {
                        NSLog(@"生成订单失败");
                        
                    }];
                }
            }
        }
    }

}

/*------------------------------加入购物车------------------------------*/
-(void)favoriteclick{
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {//如果未登录
        [_chooseView removeFromSuperview];
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.navigationController.navigationBarHidden=YES;
        [self.navigationController pushViewController:loginVC animated:YES];
        loginVC.loginBlock = ^{
            [self.navigationController popViewControllerAnimated:YES];
            
        };
        loginVC.notLoginBlock = ^{
            [self.navigationController popViewControllerAnimated:YES];
        };
        //[self.navigationController pushViewController:loginVC animated:YES];
        
        //未登录直接return,不在进行任何其他操作
        return;
    }else{
        for (typeSpaceModel *model in self.popWindowDatasouceArray) {
            if (model.btnSelecd==NO&&_chooseView==nil) {
                [self chooseclick:_manybtn];
            }else{
                if (model.btnSelecd==NO) {
//                    [MBHelper showHUDViewWithTextForFooterView:@"请选择规格数量"withHUDColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.36]withDur:1.0];
                }else{
                    GoodsModel *good=[[GoodsModel alloc]init];
                    DBManager *manager=[[DBManager alloc]init];
                    good.detailId=self.DetailId;
                    good.name=[self.dataSouceDic objectForKey:@"name"];
                    good.Description=model.typeSpecDetail;
                    good.price=[NSString stringWithFormat:@"%.2f",[model.typeprice floatValue]*[self.dataSouceDic[@"cellNumber"] floatValue]];
                    good.imageurl=model.typePicture;
                    good.numbers=self.dataSouceDic[@"cellNumber"];
                    good.productSpecsId=model.typeId;
                    if ([manager isGoodsExists:good]==YES) {
                        [MBHelper showHUDViewWithTextForFooterView:@"宝贝已加入购物车"withHUDColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.36]withDur:1.0];
                        return;
                    }else{
                        //***************************************动画
                        _animationLabel=[[UILabel alloc]initWithFrame:CGRectMake(45, -300, 15, 15)];
                        _animationLabel.layer.cornerRadius=7.5;
                        _animationLabel.clipsToBounds=YES;
                        _animationLabel.backgroundColor=[UIColor clearColor];
                        [self.shoppingcart addSubview:_animationLabel];
                        [UIView beginAnimations:nil context:nil];//开始动画
                        [UIView setAnimationDuration:0.5];
                        CGPoint point=_animationLabel.center;
                        point.y+=310;
                        point.x-=0;
                        [_animationLabel setCenter:point];
                        [_animationLabel setBackgroundColor:[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1]];
                        [UIView commitAnimations];
                        //***************************************动画
                        [[DBManager manager]addGoods:good];
                        _animationLabel.text=[NSString stringWithFormat:@"%ld",[[DBManager manager]readAllGoods].count ];
                        _animationLabel.textColor=[UIColor whiteColor];
                        _animationLabel.font=[UIFont systemFontOfSize:9];
                        _animationLabel.textAlignment=NSTextAlignmentCenter;
                    }
                }
            }
        }
    }
}

#pragma Mark -scrollow代理方法-
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"已经结束减速");
    if (scrollView==self.ScrollowView) {
        if (self.ScrollowView.contentOffset.y==0) {
            [self titlebtn1click:_titleBtn1];
        }else if (self.ScrollowView.contentOffset.y!=0){
            [self titlebtn2click:_titleBtn2];
        }
    }else if (scrollView==self.littlescrollow){
            for (int i=0; i<100; i++) {
                if (self.littlescrollow.contentOffset.x==i*SCREEN_WIDTH) {
                    _myPagecontroller.currentPage=i;
                }
            }
    }
   
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
    if (indexPath.row==0) {
        return 105;
    }else if (indexPath.row==1){
        NSInteger length=0;
        for (typeSpaceModel *model in _popWindowDatasouceArray) {
            length+= model.typeSpecDetail.length;
        }
        NSInteger heigh=355;
        if (length<=40) {
            heigh=100;
        }else if (length>40&&length<=60){
            heigh=165;
        }else if(length>60&&length<=80){
            heigh=185;
        }else if (length>80&&length<100){
            heigh=205;
        }else{
            heigh=245;
        }
        return heigh-0.5;
    }else{
        return 105;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        SnacksFirstTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"xxx"];
        if (cell==nil) {
            cell=[[SnacksFirstTableViewCell alloc]initWithdatasouceArr:self.popWindowDatasouceArray];
        }
        cell.PopWindowNameLabel.text=self.label1.text;
        for (typeSpaceModel*model in self.popWindowDatasouceArray) {
            if (model.btnSelecd==NO) {
                cell.PopWindowPriceLabel.text=[NSString stringWithFormat:@"%@", self.label3.text ];
                cell.spaceFicationLabe.text=@"请选择规格数量";
                [cell.PopWindowImagV sd_setImageWithURL:self.dataSouceDic[@"thumb" ]placeholderImage:[UIImage imageNamed:@"placeholder1.jpg"]];
            }
        }
        for (typeSpaceModel*model in self.popWindowDatasouceArray) {
            if (model.btnSelecd==YES) {
                cell.PopWindowPriceLabel.text=model.typeprice;
                cell.spaceFicationLabe.text=[NSString stringWithFormat:@"该单品最高可使用%@积分",model.typeIntegral];
                [cell.PopWindowImagV sd_setImageWithURL:[NSURL URLWithString: model.typePicture ] placeholderImage:[UIImage imageNamed:@"placeholder1.jpg"]];
            }
        }
        
        return cell;
    }else if (indexPath.row==1){
        SnacksTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"xxx"];
        if (cell==nil) {
            cell=[[SnacksTableViewCell alloc]initWithdatasouceArr:self.popWindowDatasouceArray];
        }
        _btnView=[[UIView alloc]initWithFrame:CGRectMake(10, 50, SCREEN_WIDTH-20, 100)];
        [self labelLoopWithArray:self.popWindowDatasouceArray AndHeight:0 AndView:_btnView AndInterestArray:nil AndSelector:@selector(btnclick:) AndType:5];
        [cell addSubview:self.btnView];
        cell.backgroundColor=[UIColor whiteColor];
        return cell;
    }else{
        SnacksThirdTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ccc"];
        if (cell==nil) {
            cell=[[SnacksThirdTableViewCell alloc]initWithdatasouceArr:self.popWindowDatasouceArray];
        }
        if ([[self.dataSouceDic objectForKey:@"cellNumber"] isEqual:@"1"]) {
            cell.reducebtn.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
        }else{
            cell.reducebtn.layer.borderColor=[UIColor blackColor].CGColor;
        }
        cell.PopWindowNumberLabel.text=self.dataSouceDic[@"cellNumber"];
        for (typeSpaceModel*model in self.popWindowDatasouceArray) {
            if (model.btnSelecd==YES) {
                cell.PopWindowInventoryLabel.text=[NSString stringWithFormat:@"库存仅剩：%@",model.typeRepository];
            }
        }
        [cell.reducebtn addTarget:self action:@selector(reducebtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.addbtn addTarget:self action:@selector(addbtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    
}


-(void)reducebtnClick:(UIButton *)sender{
    int a=[self.dataSouceDic[@"cellNumber"] intValue];
    a--;
    if (a<=1) {
        a=1;
        sender.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
    }
    NSString *str=[NSString stringWithFormat:@"%d",a];
    [self.dataSouceDic setValue:str forKey:@"cellNumber"];
    [_chooseTableView reloadData];
    for (typeSpaceModel *model in self.popWindowDatasouceArray) {
        if (model.btnSelecd==YES) {
            NSString *newManyBtnTitle=[NSString stringWithFormat:@"已选：%@ x%@",model.typeSpecDetail,self.dataSouceDic[@"cellNumber"]];
            [self.manybtn setTitle:newManyBtnTitle forState:UIControlStateNormal];
        }
    }
}
-(void)addbtnClick:(UIButton *)sender{
    int a=[self.dataSouceDic[@"cellNumber"] intValue];
    a++;
    sender.layer.borderColor=[UIColor blackColor].CGColor;
    if (a>=50) {
        a=50;
        sender.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
    }
    NSString *str=[NSString stringWithFormat:@"%d",a];
    [self.dataSouceDic setValue:str forKey:@"cellNumber"];
    [_chooseTableView reloadData];
    for (typeSpaceModel *model in self.popWindowDatasouceArray) {
        if (model.btnSelecd==YES) {
            NSString *newManyBtnTitle=[NSString stringWithFormat:@"已选：%@ x%@",model.typeSpecDetail,self.dataSouceDic[@"cellNumber"]];
            [self.manybtn setTitle:newManyBtnTitle forState:UIControlStateNormal];
        }
    }
}
//规格数量button 的方法
-(void)btnclick:(UIButton*)sender{
    for (typeSpaceModel *model in self.popWindowDatasouceArray) {
        model.btnSelecd=NO;
    }
    self.popWindowDatasouceArray[sender.tag-5].btnSelecd=YES;
    [_chooseTableView reloadData];
    NSString *newManyBtnTitle=[NSString stringWithFormat:@"已选：%@ x%@",self.popWindowDatasouceArray[sender.tag-5].typeSpecDetail,self.dataSouceDic[@"cellNumber"]];
    [self.manybtn setTitle:newManyBtnTitle forState:UIControlStateNormal];
}
- (NSInteger )labelLoopWithArray:(NSMutableArray<typeSpaceModel *>  *)arr AndHeight:(CGFloat)beginHeight AndView:(UIView *)cell AndInterestArray:(NSMutableArray  *)interestArray AndSelector:(SEL)mySeletor AndType:(NSInteger)type {
    NSInteger cellHeight = 0;
    int width = 0;
    int height = 0;
    int number = 0;
    int han = 0;
    for (int i = 0; i < arr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (arr[i].btnSelecd==NO) {
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.backgroundColor=[UIColor whiteColor];
            [button.layer setBorderColor:[UIColor groupTableViewBackgroundColor].CGColor];
        }else if (arr[i].btnSelecd==YES){
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.backgroundColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
            [button.layer setBorderColor:[UIColor clearColor].CGColor];
        }
        button.tag = type + i;
        CGSize titleSize = [self getSizeByString:arr[i].typeSpecDetail AndFontSize:13];
        han = han +titleSize.width;
        if (han + 50 > [[UIScreen mainScreen]bounds].size.width) {
            han = 0;
            han = han + titleSize.width;
            height++;
            width = 0;
            width = width+titleSize.width;
            number = 0;
            button.frame = CGRectMake(10, beginHeight+30*height, titleSize.width, 25);
        }else{
            button.frame = CGRectMake(width+10+(number*10), beginHeight +30*height, titleSize.width, 25);
            width = width+titleSize.width;
        }
        number++;
        button.layer.cornerRadius = 3;
        button.clipsToBounds=YES;
        [button.layer setBorderWidth:1];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button setTitle:arr[i].typeSpecDetail forState:UIControlStateNormal];
        [button addTarget:self action:mySeletor forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:button];
        if (i == arr.count -1) {
        }
        if (i==arr.count-1) {
            CGRect f=button.frame;
            cellHeight=f.origin.y+f.size.height+10;
        }
    }
    return cellHeight;
}


- (CGSize)getSizeByString:(NSString*)string AndFontSize:(CGFloat)font
{
    CGSize size = [string boundingRectWithSize:CGSizeMake(999, 25) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    size.width += 5;
    return size;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"商城_01.png"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"商城_01.png"]];
    [MobClick endLogPageView:@"snacksController"];
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
