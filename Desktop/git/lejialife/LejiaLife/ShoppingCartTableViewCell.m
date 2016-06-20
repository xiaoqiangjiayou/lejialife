//
//  ShoppingCartTableViewCell.m
//  LejiaLife
//
//  Created by 张强 on 16/4/18.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "ShoppingCartTableViewCell.h"

@implementation ShoppingCartTableViewCell

- (void)awakeFromNib {
    
}
-(instancetype)initWithIndexPath:(NSIndexPath *)myIndexPath{
    if (self=[super init]) {
        [self creatCell:myIndexPath];
    }
    return self;
}

-(void)creatCell:(NSIndexPath *)myIndexPath{
    UIView *backgroundVIew=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 127)];
    backgroundVIew.backgroundColor=[UIColor whiteColor];
    [self addSubview:backgroundVIew];
    _rememberBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, 47.5, 20, 20)];
    [_rememberBtn.layer setBorderWidth:2];
    [_rememberBtn.layer setBorderColor:[UIColor groupTableViewBackgroundColor].CGColor];
    _rememberBtn.layer.cornerRadius=10;
    _rememberBtn.clipsToBounds=YES;
    NSLog(@"0000000000000000000  %ld",(long)_rememberBtn.tag);
    [backgroundVIew addSubview:_rememberBtn];
    _imagV=[[UIImageView alloc]initWithFrame:CGRectMake(50, 25, 81, 65)];
    [backgroundVIew addSubview:_imagV];
    _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(151, 25, 200, 15)];
    _nameLabel.font=[UIFont systemFontOfSize:13];
    [backgroundVIew addSubview:_nameLabel];
    _descriptionLabel=[[UILabel alloc]initWithFrame:CGRectMake(151, 43, 200, 13)];
    _descriptionLabel.font=[UIFont systemFontOfSize:10.0];
    _descriptionLabel.textColor=[UIColor colorWithRed:140.0/250.0 green:140.0/250.0 blue:140.0/250.0 alpha:1];
    [backgroundVIew addSubview:_descriptionLabel];
    _reduceBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _reduceBtn.frame=CGRectMake(151, 73, 35, 27) ;
    _reduceBtn.layer.cornerRadius=2.5;
    [_reduceBtn.layer setBorderWidth:1];
    [_reduceBtn.layer setBorderColor:[UIColor colorWithRed:140.0/250.0 green:140.0/250.0 blue:140.0/250.0 alpha:1].CGColor];
    [_reduceBtn setTitle:@"-" forState:UIControlStateNormal];
    [_reduceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[_reduceBtn addTarget:self action:@selector(reduceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundVIew addSubview:_reduceBtn];
    
    _addBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.frame=CGRectMake(241, 73, 35, 27) ;
    _addBtn.layer.cornerRadius=2.5;
    [_addBtn.layer setBorderWidth:1];
    [_addBtn setTitle:@"+" forState:UIControlStateNormal];
    [_addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_addBtn.layer setBorderColor:[UIColor blackColor].CGColor];
    //[_addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundVIew addSubview:_addBtn];
    
    _numberLabel=[[UILabel alloc]initWithFrame:CGRectMake(185, 73, 57, 27)];
    [_numberLabel.layer setBorderWidth:1];
    _numberLabel.textAlignment=NSTextAlignmentCenter;
    [_numberLabel.layer setBorderColor:[UIColor blackColor].CGColor];
    [backgroundVIew addSubview:_numberLabel];
    
    _priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(148, 26, 100, 75)];
    _priceLabel.font=[UIFont systemFontOfSize:15.0];
    _priceLabel.textColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    _priceLabel.textAlignment=NSTextAlignmentLeft;
    [backgroundVIew addSubview:_priceLabel];
}
-(void)layoutSubviews{

}
//-(void)reduceBtnClick:(UIButton *)sender{
//    NSString *Labletext = self.numberLabel.text;
//    int newLabeTextNumber = [Labletext intValue];
//    newLabeTextNumber =newLabeTextNumber-1;
//    self.addBtn.layer.borderColor=[UIColor blackColor].CGColor;
//    if (newLabeTextNumber<=1) {
//        newLabeTextNumber=1;
//        self.reduceBtn.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
//    }
//    NSString *newLableText = [NSString stringWithFormat:@"%d",newLabeTextNumber];
//    self.numberLabel.text= newLableText;
//}
//-(void)addBtnClick:(UIButton *)sender{
//    NSString *Labletext = self.numberLabel.text;
//    int newLabeTextNumber = [Labletext intValue];
//    newLabeTextNumber =newLabeTextNumber+1;
//    self.reduceBtn.layer.borderColor=[UIColor blackColor].CGColor;
//    int a=100;
//    if (newLabeTextNumber>=a) {
//        newLabeTextNumber=a;
//        self.addBtn.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
//    }
//    NSString *newLableText = [NSString stringWithFormat:@"%d",newLabeTextNumber];
//    self.numberLabel.text= newLableText;
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
