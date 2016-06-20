//
//  LocationPickerVC.m
//  YouZhi
//
//  Created by roroge on 15/4/9.
//  Copyright (c) 2015年 com.roroge. All rights reserved.
//

#import "LocationPickerVC.h"
#import "Header.h"
#import "MBHelper.h"
@interface LocationPickerVC () <UIPickerViewDataSource, UIPickerViewDelegate,UITextFieldDelegate,UITextViewDelegate>
//view
@property (strong, nonatomic) IBOutlet UIPickerView *myPicker;
@property (strong, nonatomic) IBOutlet UIView *pickerBgView;
@property (strong, nonatomic) UIView *maskView;
@property(nonatomic)UIImageView *imagV;
@property(nonatomic)UILabel *placeHolderLabel;
//data
@property (strong, nonatomic) NSDictionary *pickerDic;
@property (strong, nonatomic) NSArray *provinceArray;
@property (strong, nonatomic) NSArray *cityArray;
@property (strong, nonatomic) NSArray *townArray;
@property (strong, nonatomic) NSArray *selectedArray;

@end

@implementation LocationPickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getPickerData];
    [self initView];
    [self creatTitleView];
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
    titleLabel.text=@"编辑地址";
    titleLabel.font=[UIFont systemFontOfSize:20.0f];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.textColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    [TitleVIew addSubview:titleLabel];
    [self creatButtomViews];
}
//返回上一页
-(void)Btnreturn{
    [self.navigationController popViewControllerAnimated:YES];
}
//底部视图
-(void)creatButtomViews{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 49) ;
    btn.backgroundColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    [self.view addSubview:btn];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:16];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)saveBtnClick{
    if (_nameTextField.text==nil||_phoneNumberTextField.text==nil||_detailAddressTextView.text==nil) {
        [MBHelper showHUDViewWithTextForFooterView:@"请将信息填写完整"withHUDColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.36]withDur:1.0];
    }else{
        NSDictionary *dic=[[NSDictionary alloc]init];
        if (self.addressId!=nil) {
            dic=@{@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginToken"],@"id":_addressId,@"name":_nameTextField.text,@"location":_detailAddressTextView.text,@"phoneNumber":_phoneNumberTextField.text,@"province":[self.provinceArray objectAtIndex:[self.myPicker selectedRowInComponent:0]],@"city":[self.cityArray objectAtIndex:[self.myPicker selectedRowInComponent:1]],@"county":[self.townArray objectAtIndex:[self.myPicker selectedRowInComponent:2]]};
        }else{
            dic=@{@"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginToken"],@"name":_nameTextField.text,@"location":_detailAddressTextView.text,@"phoneNumber":_phoneNumberTextField.text,@"province":[self.provinceArray objectAtIndex:[self.myPicker selectedRowInComponent:0]],@"city":[self.cityArray objectAtIndex:[self.myPicker selectedRowInComponent:1]],@"county":[self.townArray objectAtIndex:[self.myPicker selectedRowInComponent:2]]};
        }
        [[NetDataEngin sharedInstance]requestHomeParamter:dic Atpage:nil WithURL:EDITADDRESS success:^(id responsData) {
            NSLog(@"保存成功");
            [MBHelper showHUDViewWithTextForFooterView:@"地址保存成功" withHUDColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.36]withDur:1.0];
            [self.navigationController popViewControllerAnimated:YES];
        } failed:^(NSError *error) {
            [MBHelper showHUDViewWithTextForFooterView:@"地址保存失败" withHUDColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.36]withDur:1.0];
        }];
    }
}
#pragma mark - init view
- (void)initView {
    if (_location==nil) {
        //TextView占位符
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
        _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH/2, 20)];
        _placeHolderLabel.font = [UIFont systemFontOfSize:14.0f];
        _placeHolderLabel.backgroundColor = [UIColor clearColor];
            _placeHolderLabel.text = @"请输入详细地址";
            _placeHolderLabel.textColor = [UIColor colorWithRed:140.0/250.0 green:140.0/250.0 blue:140.0/250.0 alpha:1];
        [_detailAddressTextView addSubview:_placeHolderLabel];
    }else{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
        _detailAddressTextView.text=self.location;
        _detailAddressTextView.textColor=[UIColor blackColor];
    }
    if (_name==nil) {
        _nameTextField.placeholder=@"名字";
        //设置开始编辑时候，提供清空按钮
        _nameTextField.clearsOnBeginEditing=YES;
    }else{
        _nameTextField.text=self.name;
    }
    _nameTextField.borderStyle=UITextBorderStyleNone;
    _nameTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    _nameTextField.delegate=self;
    
    if (_phoneNumber==nil) {
        _phoneNumberTextField.placeholder=@"手机号";
        //设置开始编辑时候，提供清空按钮
        _phoneNumberTextField.clearsOnBeginEditing=YES;
    }else{
        _phoneNumberTextField.text=_phoneNumber;
    }
    _phoneNumberTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    _phoneNumberTextField.delegate=self;
    _phoneNumberTextField.borderStyle=UITextBorderStyleNone;
    _phoneNumberTextField.keyboardType=UIKeyboardTypePhonePad;
    UILabel *lintLabel1=[[UILabel alloc]initWithFrame:CGRectMake(0, _phoneNumberTextField.frame.size.height-1+64, SCREEN_WIDTH, 1)];
    lintLabel1.backgroundColor=[UIColor colorWithRed:232.0/250.0 green:232.0/250.0 blue:232.0/250.0 alpha:1];
    [_nameTextField addSubview:lintLabel1];
    
    UILabel *lintLabel2=[[UILabel alloc]initWithFrame:CGRectMake(0, _phoneNumberTextField.frame.size.height*3-1+64+_detailAddressTextView.frame.size.height, SCREEN_WIDTH, 1)];
    lintLabel2.backgroundColor=[UIColor colorWithRed:232.0/250.0 green:232.0/250.0 blue:232.0/250.0 alpha:1];
    [self.view addSubview:lintLabel2];
    if (_province==nil&&_city==nil&&_country==nil) {
        _locationLabel.text=@"省   市    区县";
        _locationLabel.textColor=[UIColor colorWithRed:232.0/250.0 green:232.0/250.0 blue:232.0/250.0 alpha:1];
    }else{
        _locationLabel.text=[NSString stringWithFormat:@"%@%@%@",_province,_city,_country];
        _locationLabel.textColor=[UIColor blackColor];
    }
    
    _imagV=[[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width-30, 10, 10, 20)];
    _imagV.image=[UIImage imageNamed:@"choice_iconn.png"];
    [self.locationBtn addSubview:_imagV];
    self.maskView = [[UIView alloc] initWithFrame:kScreen_Frame];
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0;
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMyPicker)]];
    self.pickerBgView.width = kScreen_Width;
}
//输入框要编辑的时候

- (void)textChanged:(NSNotification *)notification

{
    [_placeHolderLabel removeFromSuperview];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //注销成为第一响应者；键盘就会消失
    //    [textField resignFirstResponder];
    //这种方式也可以让键盘消失。
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}
//即将开始编辑的代理方法。
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    _detailAddressTextView.text=nil;
    return YES;
}
//即将结束编辑
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSLog(@"ceshi");
    if (textField==self.phoneNumberTextField) {
        if ([self validateMobile:self.phoneNumberTextField.text]==YES) {
            NSLog(@"***************************正确");
        }else{
            [MBHelper showHUDViewWithTextForFooterView:@"请输入正确的电话号码"withHUDColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.36]withDur:1.0];
        }
        
    }
    NSLog(@"textFieldShouldEndEditing");
    return YES;
}
- (BOOL)validateMobile:(NSString *)mobile
{
    if (mobile.length != 11) {
        return NO;
    }
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^1[3|4|5|6|7|8|9][0-9]\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
#pragma mark - get data
- (void)getPickerData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
    self.pickerDic = [[NSDictionary alloc] initWithContentsOfFile:path];
    self.provinceArray = [self.pickerDic allKeys];
    self.selectedArray = [self.pickerDic objectForKey:[[self.pickerDic allKeys] objectAtIndex:0]];
    
    if (self.selectedArray.count > 0) {
        self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
    }
    if (self.cityArray.count > 0) {
        self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
    }
}

#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinceArray.count;
    } else if (component == 1) {
        return self.cityArray.count;
    } else {
        return self.townArray.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [self.provinceArray objectAtIndex:row];
    } else if (component == 1) {
        return [self.cityArray objectAtIndex:row];
    } else {
        return [self.townArray objectAtIndex:row];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        return 110;
    } else if (component == 1) {
        return 100;
    } else {
        return 110;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.selectedArray = [self.pickerDic objectForKey:[self.provinceArray objectAtIndex:row]];
        if (self.selectedArray.count > 0) {
            self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
        } else {
            self.cityArray = nil;
        }
        if (self.cityArray.count > 0) {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
        } else {
            self.townArray = nil;
        }
    }
    [pickerView selectedRowInComponent:1];
    [pickerView reloadComponent:1];
    [pickerView selectedRowInComponent:2];
    
    if (component == 1) {
        if (self.selectedArray.count > 0 && self.cityArray.count > 0) {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:row]];
        } else {
            self.townArray = nil;
        }
        [pickerView selectRow:1 inComponent:2 animated:YES];
    }
    
    [pickerView reloadComponent:2];
}

#pragma mark - private method
- (IBAction)showMyPicker:(id)sender {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.pickerBgView];
    self.maskView.alpha = 0;
    self.pickerBgView.top = self.view.height;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0.3;
        self.pickerBgView.bottom = self.view.height;
    }];
}

- (void)hideMyPicker {
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0;
        self.pickerBgView.top = self.view.height;
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
        [self.pickerBgView removeFromSuperview];
    }];
}

#pragma mark - xib click

- (IBAction)cancel:(id)sender {
    [self hideMyPicker];
}

- (IBAction)ensure:(id)sender {
    self.imagV.hidden=YES;
    NSString *str=[NSString stringWithFormat:@"%@%@%@",[self.provinceArray objectAtIndex:[self.myPicker selectedRowInComponent:0]],[self.cityArray objectAtIndex:[self.myPicker selectedRowInComponent:1]],[self.townArray objectAtIndex:[self.myPicker selectedRowInComponent:2]]];
    _locationLabel.text=str;
    _locationLabel.textColor=[UIColor blackColor];
    [self hideMyPicker];
}

@end
