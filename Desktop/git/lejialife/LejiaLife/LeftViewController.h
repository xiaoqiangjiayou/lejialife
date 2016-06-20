//
//  LeftViewController.h
//  LejiaLife
//
//  Created by 张强 on 16/4/13.
//  Copyright © 2016年 张强. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LeftViewController;
@protocol SwitchDelegate <NSObject>
-(void)switchView:(LeftViewController*)view row:(NSInteger)row;
@end
@interface LeftViewController : UIViewController
@property(nonatomic,weak)id<SwitchDelegate>delegate;
@property(nonatomic,copy)void(^chuanzhi)(UIColor *);
@end
