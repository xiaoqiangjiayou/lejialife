//
//  ShoppingCartViewController.m
//  LejiaLife
//
//  Created by 张强 on 16/3/28.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "StoreViewController.h"
#import "SnacksDetailViewController.h"
#import "ShoppingCartTableViewCell.h"
#import "GoshoppingViewController.h"
#import "SnacksDetailViewController.h"
#import "ShoppingCartModel.h"
#import "DBManager.h"
#import "MBHelper.h"
#import "object2Json.h"
#import "GoshoppingModel.h"
#import "GoshoppingCellModel.h"
@interface ShoppingCartViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic)UITableView *tableView;
@property(nonatomic,retain)NSMutableArray<ShoppingCartModel*> *datasouceArray;
@property(nonatomic,copy)NSString *totalPrice;
@property(nonatomic,copy)NSString *totalNumber;
@property(nonatomic)UILabel *totalPriceLabel;
@property(nonatomic)UILabel *totalNumberLabel;
@property(nonatomic)UIButton *allBtn;
@property(nonatomic,retain)NSMutableArray *reduceArray;
@property(nonatomic,retain)NSMutableArray *rememberArray;
@end

@implementation ShoppingCartViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"ShoppingCart"];//("PageOne"为页面名称，可自定义)
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:222.0/250.0 green:222.0/250.0 blue:222.0/250.0 alpha:1];
    [self creatTitleView];
    [self creatButtomViews];
    _rememberArray=[[NSMutableArray alloc]init];
    [self.view addSubview:self.tableView];
    [self fetch];
    [self.tableView reloadData];
    //[self tableViewEdit];
}
//获取本地数据
-(void)fetch{
    DBManager *manager=[[DBManager alloc]init];
    self.datasouceArray=[ShoppingCartModel parseResponsData:[[NSMutableArray alloc]initWithArray:[manager readAllGoods]]];
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
    titleLabel.text=@"购物车";
    titleLabel.font=[UIFont systemFontOfSize:20.0f];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.textColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    [TitleVIew addSubview:titleLabel];
    UIButton *deleteBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame=CGRectMake(SCREEN_WIDTH-60, 30, 40, 20) ;
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    deleteBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [deleteBtn setTitleColor:[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1] forState:UIControlStateNormal];
    [TitleVIew addSubview:deleteBtn];
    [deleteBtn addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
}
//返回上一页
-(void)Btnreturn{
        for (UINavigationController *nav in self.navigationController.viewControllers) {
            if ([nav isKindOfClass:[SnacksDetailViewController class]]) {
                [self.navigationController popToViewController:nav animated:YES];
            }else if([nav isKindOfClass:[StoreViewController class]]){
                [self.navigationController popToViewController:nav animated:YES];
            }
        }
}
//删除或者编辑
-(void)edit{
    if (_rememberArray.count==0) {
        
    }else{
        //数组排序
        int i,j,t;
        for ( i=0; i<_rememberArray.count-1; i++) {
            for ( j=i+1; j<_rememberArray.count; j++) {
                if([_rememberArray[i] intValue]>[_rememberArray[j] intValue]) {
                    
                    t=[_rememberArray[i] intValue];
                    
                    _rememberArray[i]=_rememberArray[j];
                    
                    _rememberArray[j]=[NSString stringWithFormat:@"%d",t ];
                }
            }
        }
        for (int i=0; i<self.rememberArray.count; i++) {
            int a=[[_rememberArray objectAtIndex:i] intValue];
            
            NSLog(@"eeeeeeeeeeeeeeeeeeeeee%@",self.rememberArray);
            DBManager *manager=[DBManager manager];
            NSLog(@"rrrrrrrrrrrrrrrrrrrrrr%@",[manager readAllGoods]);
            GoodsModel *delMode =[[manager readAllGoods] objectAtIndex:a-i];
            [manager deleteGoods:delMode];
            [self.datasouceArray removeObjectAtIndex:a-i];
            NSLog(@"hhhhhhhhhhhh%@",[manager readAllGoods]);
        }
        
        self.totalPrice = @"0";
        self.totalPriceLabel.text = [NSString stringWithFormat:@"合计：￥%.2f", 0.00];
        [self.tableView reloadData];
    }
}
//底部视图
-(void)creatButtomViews{
    UIView *View=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 49)];
    View.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:View];
    UILabel *lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 2)];
    lineLabel.backgroundColor=[UIColor colorWithRed:222.0/250.0 green:222.0/250.0 blue:222.0/250.0 alpha:1];
    [View addSubview:lineLabel];
    _allBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _allBtn.frame=CGRectMake(20, 15, 20, 20);
    _allBtn.layer.cornerRadius=10;
    _allBtn.clipsToBounds=YES;
    [_allBtn.layer setBorderWidth:2];
    [_allBtn.layer setBorderColor:[UIColor colorWithRed:222.0/250.0 green:222.0/250.0 blue:222.0/250.0 alpha:1].CGColor];
    [_allBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [View addSubview:_allBtn];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(55, 17, 30, 14)];
    label.text=@"全选";
    label.font=[UIFont systemFontOfSize:14];
    [View addSubview:label];
    self.totalPriceLabel=[[UILabel alloc]initWithFrame:CGRectMake(130, 17, 120, 14)];
    self.totalPrice=@"0.00";
    self.totalPriceLabel.text=[NSString stringWithFormat:@"合计：￥%@",self.totalPrice];
    self.totalPriceLabel.font=[UIFont systemFontOfSize:14];
    self.totalPriceLabel.textColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    [View addSubview:self.totalPriceLabel];
    UIButton *GoshoppingBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [GoshoppingBtn addTarget:self action:@selector(GoshoppingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    GoshoppingBtn.frame=CGRectMake(250, 0, SCREEN_WIDTH-250, 49);
    GoshoppingBtn.backgroundColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    [GoshoppingBtn setTitle:@"去下单" forState:UIControlStateNormal];
    GoshoppingBtn.titleLabel.font=[UIFont systemFontOfSize:18];
    [GoshoppingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [View addSubview:GoshoppingBtn];
}
//全选
-(void)btnClick:(UIButton*)sender{
    if (sender.selected!=YES) {
        sender.selected = YES;
        for (int i; i<self.datasouceArray.count; i++) {
            self.datasouceArray[i].modelRememberFlag=YES;
        }
        [_allBtn.layer setBorderWidth:0];
        [_allBtn.layer setBorderColor:[UIColor clearColor].CGColor];
        [_allBtn setBackgroundImage:[UIImage imageNamed:@"choice_icon"] forState:UIControlStateNormal];
        ShoppingCartModel *model=[[ShoppingCartModel alloc]init];
        for (model in self.datasouceArray) {
            model.modelRememberFlag=YES;
        }
        [self.rememberArray removeAllObjects];
        DBManager *manager=[[DBManager alloc]init];
        for (int i=0; i<[manager readAllGoods].count; i++) {
            [self.rememberArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }else{
        sender.selected = NO;
        for (int i; i<self.datasouceArray.count; i++) {
            self.datasouceArray[i].modelRememberFlag=NO;
        }
        [sender setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [sender.layer setBorderWidth:2];
        [sender.layer setBorderColor:[UIColor groupTableViewBackgroundColor].CGColor];
        ShoppingCartModel *model=[[ShoppingCartModel alloc]init];
        for (model in self.datasouceArray) {
            model.modelRememberFlag=NO;
        }
        [self.rememberArray removeAllObjects];
        [self.tableView reloadData];
    }
//    int totalPrice=0;
//    for (ShoppingCartModel*model in self.datasouceArray) {
//        if (model.modelRememberFlag==YES) {
//            totalPrice+=[model.price intValue];
//        }
//    }
    self.totalPrice = @"0.00";
    self.totalPriceLabel.text = [NSString stringWithFormat:@"合计：￥%.2f", 0.00];
    [self.tableView reloadData];
    //self.totalPrice=[NSString stringWithFormat:@"%d",totalPrice];
}
-(void)GoshoppingBtnClick{
    NSLog(@"下单");
    if ([self.totalPrice isEqualToString:@"0.00"]) {
       [MBHelper showHUDViewWithTextForFooterView:@"请选择商品"withHUDColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.36]withDur:1.0];
    }else{
        NSString *lastStr=[[NSString alloc]init];
        for (ShoppingCartModel *model in self.datasouceArray) {
            if (model.modelRememberFlag==YES) {
                NSString *str=[NSString stringWithFormat:@"%@_%@_%@,",model.detailId,model.productSpecId,model.numbers];
                lastStr=[lastStr stringByAppendingString:str];
            }
        }
      NSString *url=[NSString stringWithFormat:@"%@%@",CREATCARTORDER,[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginToken"]];
        NSDictionary *sendDic=@{@"cartDetailDtos":lastStr};
        [[NetDataEngin sharedInstance]creatOrderParamter:sendDic WithURL:url success:^(id responsData){
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
            [MBHelper showHUDViewWithTextForFooterView:responsDatadic[@"msg"] withHUDColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.36]withDur:1.0];
            }
        } failed:^(NSError *error) {
            NSLog(@"生成订单失败");
            
        }];
    }
}

//**************************************代理方法*******************************************************
-(UITableView*)tableView{
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49) style:UITableViewStylePlain];
         _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}
-(void)tableViewEdit{
    self.tableView.editing=YES;
}
#pragma Mark ------代理方法-------------------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datasouceArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 137;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShoppingCartTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"xxx" ];
    if (cell==nil) {
        cell=[[ShoppingCartTableViewCell alloc]initWithIndexPath:indexPath];
    }
    cell.backgroundColor=[UIColor colorWithRed:222.0/250.0 green:222.0/250.0 blue:222.0/250.0 alpha:1];
    ShoppingCartModel *model=[[ShoppingCartModel alloc]init];
    model=[self.datasouceArray objectAtIndex:indexPath.row];
    NSString *imageUrl=model.imageurl;
    [cell.imagV sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"sugertest"]];
    cell.nameLabel.text=model.name;
    cell.descriptionLabel.text=model.Description;
    cell.numberLabel.text=model.numbers;
    cell.priceLabel.text=[NSString stringWithFormat:@"￥%@", model.price];
    NSLog(@"每个cell商品的总价:%@", model.price);
    cell.rememberBtn.tag=100+indexPath.row;
    //for (int i=0; i<self.datasouceArray.count; i++) {
        if (model.modelRememberFlag==NO) {
            cell.rememberBtn.selected = NO;
            [cell.rememberBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [cell.rememberBtn.layer setBorderWidth:2];
            [cell.rememberBtn.layer setBorderColor:[UIColor groupTableViewBackgroundColor].CGColor];
//            int price0 = [self.totalPrice intValue];
//            int price1 = price0 + [cell.priceLabel.text floatValue] *[model.numbers integerValue];
//            self.totalPriceLabel.text = [NSString stringWithFormat:@"合计：￥%d.00", price1];
        }else{
            cell.rememberBtn.selected=YES;
            [cell.rememberBtn setBackgroundImage:[UIImage imageNamed:@"choice_icon"] forState:UIControlStateNormal];
            [cell.rememberBtn.layer setBorderWidth:0];
            
            float price0 = [self.totalPrice floatValue];
            float price1 = price0 + [model.price intValue];
            self.totalPrice = [NSString stringWithFormat:@"%.2f", price1];
            self.totalPriceLabel.text = [NSString stringWithFormat:@"合计：￥%.2f", price1];
            
//            int price0 = [self.totalPrice intValue];
//            NSLog(@"合计:%@", self.totalPrice);
//            int price1 = price0 + [model.price intValue] *[model.numbers intValue];
//            NSLog(@"单个价格:%@,数量:%@,总计:%d", cell.priceLabel.text, model.numbers, price1);
//            self.totalPriceLabel.text = [NSString stringWithFormat:@"合计：￥%d.00", price1];
////            self.totalPrice = []
        }
    //}
    [cell.rememberBtn addTarget:self action:@selector(cellRememberBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //增加数量
    cell.addBtn.tag=100+indexPath.row;
    [cell.addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.reduceBtn.tag=100+indexPath.row;
    if ([[self.datasouceArray objectAtIndex:indexPath.row].numbers isEqualToString: @"1"]) {
        cell.reduceBtn.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
    }else{
        cell.reduceBtn.layer.borderColor=[UIColor blackColor].CGColor;
    }
    [cell.reduceBtn addTarget:self action:@selector(reduceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
//增减数量
-(void)reduceBtnClick:(UIButton*)sender{
    NSString *Labletext = self.datasouceArray[sender.tag-100].numbers;
    int newLabeTextNumber = [Labletext intValue];
    NSString *newLableText=[[NSString alloc]init];
    int UnitPrice=[self.datasouceArray[sender.tag-100].price intValue]/[self.datasouceArray[sender.tag-100].numbers intValue];
    if (newLabeTextNumber<=1) {
        newLabeTextNumber=1;
        newLableText=@"1";
    }else{
        newLabeTextNumber =newLabeTextNumber-1;
        newLableText = [NSString stringWithFormat:@"%d",newLabeTextNumber];
    }
    self.datasouceArray[sender.tag-100].numbers= newLableText;
    float price=UnitPrice *[self.datasouceArray[sender.tag-100].numbers intValue];
    NSString *newPriceStr=[NSString stringWithFormat:@"%.2f",price];
    self.datasouceArray[sender.tag-100].price=newPriceStr;
    
    
    
    self.totalPrice = @"0.00";
    self.totalPriceLabel.text = [NSString stringWithFormat:@"合计：￥%.2f", 0.00];
    [self.tableView reloadData];
}
-(void)addBtnClick:(UIButton*)sender{
    NSString *Labletext = self.datasouceArray[sender.tag-100].numbers;
    int newLabeTextNumber = [Labletext intValue];
    NSString *newLableText=[[NSString alloc]init];
    int UnitPrice=[self.datasouceArray[sender.tag-100].price intValue]/[self.datasouceArray[sender.tag-100].numbers intValue];
    if (newLabeTextNumber>=100) {
        newLabeTextNumber=100;
        newLableText = [NSString stringWithFormat:@"%d",newLabeTextNumber];
    }else{
        newLabeTextNumber =newLabeTextNumber+1;
        newLableText = [NSString stringWithFormat:@"%d",newLabeTextNumber];
    }
    self.datasouceArray[sender.tag-100].numbers= newLableText;
    float price=UnitPrice *[self.datasouceArray[sender.tag-100].numbers floatValue];
    NSString *newPriceStr=[NSString stringWithFormat:@"%.2f",price];
    self.datasouceArray[sender.tag-100].price=newPriceStr;
    
    
    
    self.totalPrice = @"0.00";
    self.totalPriceLabel.text = [NSString stringWithFormat:@"合计：￥%.2f", 0.00];
    [self.tableView reloadData];
}
//标记button点击方法
-(void)cellRememberBtnClick:(UIButton*)sender{
    if (!sender.selected) {
        sender.selected=YES;
        self.datasouceArray[sender.tag-100].modelRememberFlag=YES;
        [sender setBackgroundImage:[UIImage imageNamed:@"choice_icon"] forState:UIControlStateNormal];
        [sender.layer setBorderWidth:0];
        NSString *str=[NSString stringWithFormat:@"%ld",(long)sender.tag-100];
        [_rememberArray addObject:str];
//        int totalPrice=[self.totalPrice intValue];
//        for (ShoppingCartModel*model in self.datasouceArray) {
//            if (model.modelRememberFlag==YES) {
//                totalPrice+=[model.price intValue];
//            }
//            self.totalPrice=[NSString stringWithFormat:@"￥%d.00",totalPrice];
//            self.totalPriceLabel.text=self.totalPrice;
//        }
        
//        [self.tableView reloadData];
    }else{
        sender.selected = NO;
        self.datasouceArray[sender.tag-100].modelRememberFlag=NO;
        [sender setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [sender.layer setBorderWidth:2];
        [sender.layer setBorderColor:[UIColor groupTableViewBackgroundColor].CGColor];
        NSString *tagStr=[NSString stringWithFormat:@"%ld",(long)sender.tag-100];
        [self.rememberArray removeObject:tagStr];
//        int totalPrice=[self.totalPrice intValue];
//        for (ShoppingCartModel*model in self.datasouceArray) {
//            if (model.modelRememberFlag==YES) {
//                totalPrice+=[model.price intValue];
//            }
//            self.totalPrice=[NSString stringWithFormat:@"￥%d.00",totalPrice];
//            self.totalPriceLabel.text=self.totalPrice;
//        }
        
//        [self.tableView reloadData];
    }
    self.totalPrice = @"0.00";
    self.totalPriceLabel.text = [NSString stringWithFormat:@"合计：￥%.2f", 0.00];
    [self.tableView reloadData];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    [MobClick endLogPageView:@"ShoppingCart"];
    
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
//**********************************编辑的相关操作*************************************************
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete ;
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"取消选择了第%ld组 第%ld行",indexPath.section,indexPath.row);
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
