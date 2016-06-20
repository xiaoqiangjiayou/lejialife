//
//  AutoScrollView.h
//  AutoScoll
//
//  Created by lijinghua on 15/8/19.
//  Copyright (c) 2015年 lijinghua. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^Block)(UIViewController* vc);
typedef void(^BLOCK)(NSInteger tag);
@interface AutoScrollView : UIView
@property(nonatomic)UIImageView *centerImageView;
- (id)initWithFrame:(CGRect)frame imageArray:(NSArray*)imageArray;
@property(nonatomic,copy)Block block;
@property(nonatomic,copy)BLOCK tblock;


//@property(nonatomic,retain)NSArray *imageArray;
@end
