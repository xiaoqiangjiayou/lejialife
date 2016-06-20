//
//  OrderFootTwoView.m
//  LejiaLife
//
//  Created by 张强 on 16/5/18.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "OrderFootTwoView.h"

@implementation OrderFootTwoView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self creatFooterView];
    }
    return self;
}
-(void)creatFooterView{
    self.contentView.backgroundColor=[UIColor whiteColor];
    _totalLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH/2, 10)];
    _totalLabel.font=[UIFont systemFontOfSize:10];
    _totalLabel.textColor=[UIColor blackColor];
    [self.contentView addSubview:_totalLabel];
    _envelopeLabe=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+20, 25, SCREEN_WIDTH/2-30, 10)];
    _envelopeLabe.textAlignment=NSTextAlignmentRight;
    _envelopeLabe.font=[UIFont systemFontOfSize:9];
    _envelopeLabe.textColor=[UIColor blackColor];
    [self.contentView addSubview:_envelopeLabe];
    UILabel *lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-40, 1)];
    lineLabel.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self setBackgroundView:lineLabel];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
