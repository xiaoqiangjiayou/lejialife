//
//  GrayPageControl.m
//  LejiaLife
//
//  Created by 张强 on 16/4/5.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "GrayPageControl.h"

@implementation GrayPageControl

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id) initWithFrame:(CGRect)frame

{
    
    self = [super initWithFrame:frame];
    
    
//    activeImage = [UIImage imageNamed:@"RedPoint.png"];
//    
//    inactiveImage = [[UIImage imageNamed:@"BluePoint.png"] retain];
    
    
    
    return self;
    
}


-(void) updateDots
{
    
    for (int i=0; i<[self.subviews count]; i++) {
        
        UIImageView* dot = [self.subviews objectAtIndex:i];
        dot.layer.cornerRadius=6;
        
        CGSize size;
        
        size.height = 12;     //自定义圆点的大小
        
        size.width = 12;      //自定义圆点的大小
        
        [dot setFrame:CGRectMake(15*i + i*size.width, dot.frame.origin.y, size.width, size.width)];
        
        if (i==self.currentPage)dot.backgroundColor=[UIColor colorWithRed:214.0/250.0 green:44.0/250.0 blue:44.0/250.0 alpha:1];
        
        else dot.backgroundColor=[UIColor groupTableViewBackgroundColor];
        
    }
    
}

-(void) setCurrentPage:(NSInteger)page

{
    
    [super setCurrentPage:page];
    
    [self updateDots];
    
}
@end
