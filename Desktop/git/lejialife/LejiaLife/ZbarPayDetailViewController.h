//
//  ZbarPayDetailViewController.h
//  LejiaLife
//
//  Created by 张强 on 16/6/3.
//  Copyright © 2016年 张强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFFNumericKeyboard.h"
@interface ZbarPayDetailViewController : UIViewController<AFFNumericKeyboardDelegate>
@property(nonatomic,copy)NSString *titleStr;
@end
