//
//  LoginViewController.h
//  LejiaLife
//
//  Created by 张强 on 16/4/28.
//  Copyright © 2016年 张强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property(nonatomic)BOOL isLoginToken;
@property (nonatomic, copy) void(^loginBlock)(void);
@property (nonatomic, copy) void(^notLoginBlock)(void);
@property(nonatomic,copy) void(^LoginUpdateBlock)(void);

@end
