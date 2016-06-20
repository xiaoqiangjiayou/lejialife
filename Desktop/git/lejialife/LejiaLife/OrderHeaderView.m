//
//  OrderHeaderView.m
//  LejiaLife
//
//  Created by 张强 on 16/5/13.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "OrderHeaderView.h"

@implementation OrderHeaderView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self creatHeaderView];
    }
    return self;
}
-(void)creatHeaderView{
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    backgroundView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 15, SCREEN_WIDTH, 35)];
    backView.backgroundColor=[UIColor whiteColor];
    _orderNumberLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH/2-20, 10)];
    _orderNumberLabel.font=[UIFont systemFontOfSize:10];
    //_orderNumberLabel.text=@"订单号123123123";
    _orderNumberLabel.textColor=[UIColor blackColor];
    [backView addSubview:_orderNumberLabel];
    _stateLabel=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-80, 0, 70, 30)];
    _stateLabel.textColor=[UIColor whiteColor];
    _stateLabel.textAlignment=NSTextAlignmentCenter;
    _stateLabel.font=[UIFont systemFontOfSize:13];
    _stateLabel.backgroundColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
    [backView addSubview:_stateLabel];
    [backgroundView addSubview:backView];
    [self setBackgroundView:backgroundView];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
