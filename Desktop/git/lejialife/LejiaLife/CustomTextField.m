//
//  CustomTextField.m
//  LejiaLife
//
//  Created by 张强 on 16/6/3.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//控制placeHolder的位置，左右缩20

-(CGRect)placeholderRectForBounds:(CGRect)bounds

{


    
    //return CGRectInset(bounds, 20, 0);
    
    CGRect inset = CGRectMake(bounds.origin.x+100, bounds.origin.y, bounds.size.width -10, bounds.size.height);//更好理解些
    
    return inset;
    
}
@end
