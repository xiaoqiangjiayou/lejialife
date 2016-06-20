//
//  OrderFootView.m
//  LejiaLife
//
//  Created by 张强 on 16/5/13.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "OrderFootView.h"

@implementation OrderFootView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self creatFooterView];
    }
    return self;
}
-(void)creatFooterView{
    _totalLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH/2+20, 10)];
    _totalLabel.font=[UIFont systemFontOfSize:10];
    _totalLabel.textColor=[UIColor blackColor];
    //_totalLabel.text=@"合计：1231231231积分";
    _totalLabel.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:_totalLabel];
    _cancleBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _cancleBtn.frame=CGRectMake(SCREEN_WIDTH/3-20, 50, SCREEN_WIDTH/3, 30);
    _cancleBtn.layer.borderWidth=1;
    _cancleBtn.layer.cornerRadius=3;
    _cancleBtn.layer.borderColor=[UIColor grayColor].CGColor;
    [self.contentView addSubview:_cancleBtn];
    _payBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _payBtn.frame=CGRectMake(SCREEN_WIDTH/3*2-10, 50, SCREEN_WIDTH/3, 30);
    _payBtn.layer.borderWidth=1;
    _payBtn.layer.cornerRadius=3;
    _payBtn.layer.borderColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1].CGColor;
    [self.contentView addSubview:_payBtn];
    _envelopeLabe=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+20, 20, SCREEN_WIDTH/2-20, 10)];
    _envelopeLabe.font=[UIFont systemFontOfSize:9];
    _envelopeLabe.textColor=[UIColor blackColor];
    _envelopeLabe.textAlignment=NSTextAlignmentRight;
    self.contentView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:_envelopeLabe];
    UILabel *lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-40, 1)];
    lineLabel.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self setBackgroundView:self.contentView];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
