//
//  AddressViewController.m
//  LejiaLife
//
//  Created by 张强 on 16/5/5.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "AddressViewController.h"
#import "AddressTableViewCell.h"
#import "GoshoppingViewController.h"
#import "LocationPickerVC.h"
#import "AddressModel.h"
@interface AddressViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic)UITableView *tableView;
@property(nonatomic,retain)NSMutableArray <AddressModel *>*datasouceArray;
@property(nonatomic,retain)NSMutableArray *rememberArray;
@property(nonatomic,copy)NSString *OldId;
@property(nonatomic,copy)NSString *NewId;
@end

@implementation AddressViewController
-(void)viewWillAppear:(BOOL)animated{
    self.view.backgroundColor=[UIColor colorWithRed:232.0/250.0 green:232.0/250.0 blue:232.0/250.0 alpha:1];
    [self creatTitleView];
    [self creatButtomViews];
    [self.view addSubview:self.tableView];
    [self fetch];
    [self.tableView reloadData];
    [MobClick beginLogPageView:@"addressController"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
//获取本地数据
-(void)fetch{
        NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginToken"];
        NSDictionary *dic=@{@"token":token};
        [[NetDataEngin sharedInstance]requestHomeParamter:dic Atpage:nil WithURL:ADDRESSLIST success:^(id responsData) {
            NSDictionary *responsDatadic=responsData;
            NSInteger status=[responsDatadic[@"status"] integerValue];
            if (status==200) {
                NSLog(@"获取地址成功");
                self.datasouceArray=[NSMutableArray arrayWithArray:[AddressModel parseResponsData:responsData] ];
                self.rememberArray=[NSMutableArray array];
                for (AddressModel *model in self.datasouceArray) {
                    if (model.state==1) {
                        [self.rememberArray addObject:model.addressId];
                    }else{
                    
                    }
                }
                [self.tableView reloadData];
            }else if (status==204){
                NSLog(@"密码错误");
            }else if (status==205){
                NSLog(@"该手机号未注册");
            }
        } failed:^(NSError *error) {
            
        }];
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
    titleLabel.text=@"收货地址";
    titleLabel.font=[UIFont systemFontOfSize:20.0f];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.textColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    [TitleVIew addSubview:titleLabel];
}
//返回上一页
-(void)Btnreturn{
    if (self.isGoshoppingPush==YES) {
        for (UINavigationController *nav in self.navigationController.viewControllers) {
            if ([nav isKindOfClass:[GoshoppingViewController class]]) {
                [self.navigationController popToViewController:nav animated:YES];
            }
        }
    }else{
    [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}
//底部视图
-(void)creatButtomViews{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 49) ;
    btn.backgroundColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    [self.view addSubview:btn];
    [btn setTitle:@"新建地址" forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:16];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)addBtnClick{
    LocationPickerVC *picker=[[LocationPickerVC alloc]init];
    [self.navigationController pushViewController:picker animated:YES];
}
//**************************************代理方法*******************************************************
-(UITableView*)tableView{
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49) style:UITableViewStylePlain];
        _tableView.backgroundColor=[UIColor colorWithRed:232.0/250.0 green:232.0/250.0 blue:232.0/250.0 alpha:1];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}
//-(void)tableViewEdit{
//    self.tableView.editing=YES;
//}


#pragma Mark ------代理方法-------------------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datasouceArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"xxx" ];
    if (cell==nil) {
        cell=[[AddressTableViewCell alloc]init];
    }
    AddressModel *model=[self.datasouceArray objectAtIndex:indexPath.row];
    if (model.state==0) {
        [cell.rememberBtn setBackgroundImage:[UIImage imageNamed:@"unchecked_icon"] forState:UIControlStateNormal];
    }else {
        [cell.rememberBtn setBackgroundImage:[UIImage imageNamed:@"selected_icon"] forState:UIControlStateNormal];
    }
    cell.phoneNumberLabel.text=model.phoneNumber;
    cell.nameLabel.text=model.name;
    cell.locationLabel.text=[NSString stringWithFormat:@"%@%@%@",model.province,model.city,model.county];
    cell.rememberBtn.tag=100+indexPath.row;
    [cell.rememberBtn addTarget:self action:@selector(cellRememberBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.editBtn.tag=100+indexPath.row;
    [cell.editBtn  addTarget:self action:@selector(celleditBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.deleteBtn.tag=100+indexPath.row;
    [cell.deleteBtn  addTarget:self action:@selector(celldeleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
//标记button点击方法
-(void)cellRememberBtnClick:(UIButton*)sender{
    if (_isGoshoppingPush==YES) {
        [sender setBackgroundImage:[UIImage imageNamed:@"unchecked_icon"] forState:UIControlStateNormal];
        NSLog(@"%ld",sender.tag);
        [self.rememberArray addObject:self.datasouceArray[sender.tag-100].addressId];
        if (self.rememberArray.count==2) {
            self.OldId=[self.rememberArray objectAtIndex:0];
            if ([self.rememberArray objectAtIndex:0]==[self.rememberArray objectAtIndex:1]) {
                self.OldId=nil;
                [self.rememberArray removeObjectAtIndex:0];
            }else{
                [self.rememberArray removeObjectAtIndex:0];
                self.NewId=self.datasouceArray[sender.tag-100].addressId;
            }
        }else if(self.rememberArray.count==1){
            self.OldId=nil;
            [self.rememberArray addObject:self.datasouceArray[sender.tag-100].addressId];
            self.NewId=self.datasouceArray[sender.tag-100].addressId;
        }
        NSDictionary *dic=[[NSDictionary alloc]init];
        if (self.OldId==nil) {
            dic=@{@"newId":self.NewId};
        }else{
            dic=@{@"oldId":self.OldId,@"newId":self.NewId};
        }
        [[NetDataEngin sharedInstance]requestHomeParamter:dic Atpage:nil WithURL:EDITORDERADDRESS success:^(id responsData) {
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
        }];
        
    }else{
        [sender setBackgroundImage:[UIImage imageNamed:@"unchecked_icon"] forState:UIControlStateNormal];
        NSLog(@"%ld",sender.tag);
        [self.rememberArray addObject:self.datasouceArray[sender.tag-100].addressId];
        if (self.rememberArray.count==2) {
            self.OldId=[self.rememberArray objectAtIndex:0];
            if ([self.rememberArray objectAtIndex:0]==[self.rememberArray objectAtIndex:1]) {
                self.OldId=nil;
                [self.rememberArray removeObjectAtIndex:0];
            }else{
                [self.rememberArray removeObjectAtIndex:0];
                self.NewId=self.datasouceArray[sender.tag-100].addressId;
            }
        }else if(self.rememberArray.count==1){
            self.OldId=nil;
            [self.rememberArray addObject:self.datasouceArray[sender.tag-100].addressId];
            self.NewId=self.datasouceArray[sender.tag-100].addressId;
        }
        NSDictionary *dic=[[NSDictionary alloc]init];
        if (self.OldId==nil) {
            dic=@{@"newId":self.NewId};
        }else{
            dic=@{@"oldId":self.OldId,@"newId":self.NewId};
        }
        [[NetDataEngin sharedInstance]requestHomeParamter:dic Atpage:nil WithURL:CHANGEDEFAULTADDRESS success:^(id responsData) {
            [self fetch];
        } failed:^(NSError *error) {
        }];
    }
}
-(void)celleditBtnClick:(UIButton*)sender{
    LocationPickerVC *picker=[[LocationPickerVC alloc]init];
    AddressModel *model=[self.datasouceArray objectAtIndex:sender.tag-100];
    picker.addressId=self.datasouceArray[sender.tag-100].addressId;
    picker.location=self.datasouceArray[sender.tag-100].location;
    picker.name=self.datasouceArray[sender.tag-100].name;
    picker.phoneNumber=self.datasouceArray[sender.tag-100].phoneNumber;
    picker.province=model.province;
    picker.city=model.city;
    picker.country=model.county;
    [self.navigationController pushViewController:picker animated:YES];
}
-(void)celldeleteBtnClick:(UIButton*)sender{
    NSDictionary *dic=[[NSDictionary alloc]init];
    dic=@{@"id":self.datasouceArray[sender.tag-100].addressId};
    [[NetDataEngin sharedInstance]requestHomeParamter:dic Atpage:nil WithURL:DELETETADDRESS success:^(id responsData) {
        [self fetch];
    } failed:^(NSError *error) {
    }];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    [MobClick endLogPageView:@"addressController"];
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
