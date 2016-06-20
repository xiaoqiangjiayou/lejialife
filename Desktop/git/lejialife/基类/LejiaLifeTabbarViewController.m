//
//  LejiaLifeTabbarViewController.m
//  LejiaLife
//
//  Created by 张强 on 16/3/21.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "LejiaLifeTabbarViewController.h"
#import "TabbarModel.h"
@interface LejiaLifeTabbarViewController ()
@property(nonatomic)NSMutableArray *tabBarModelArray;
@end

@implementation LejiaLifeTabbarViewController


- (id)init{
    if (self = [super init]) {
        [self configTabBarModel];
        [self createContentViewControllers];
    }
    return self;
}
- (void)configTabBarModel
{
    self.tabBarModelArray = [NSMutableArray array];
    TabbarModel *homeModel = [TabbarModel modelWithTitle:@"首页" imageName:@"home page_icon" className:@"HomeViewController"];
    TabbarModel *store = [TabbarModel modelWithTitle:@"商城" imageName:@"mall_icon.png" className:@"StoreViewController"];
    TabbarModel *perimeter = [TabbarModel modelWithTitle:@"周边" imageName:@"periphery_icon" className:@"PerimeterViewController"];
    [self.tabBarModelArray addObject:homeModel];
    [self.tabBarModelArray addObject:store];
    [self.tabBarModelArray addObject:perimeter];
}

//创建内容控制器
- (void)createContentViewControllers
{
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (int idx = 0; idx < self.tabBarModelArray.count; idx++) {
        TabbarModel *model = [self.tabBarModelArray objectAtIndex:idx];
        NSString *className = model.className;
        UIViewController *viewController = [[NSClassFromString(className) alloc] init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewController];
        
        //配置在tabbar上的内容
        nav.tabBarItem.title = model.title;
        nav.tabBarItem.image = [model normalImage];
        [viewControllers addObject:nav];
    }
    
    //设置tabBar的底层的图片
    //self.tabBar.backgroundImage = [UIImage imageNamed:@"首页-底部背景@2x.png"];
    self.tabBar.backgroundColor=[UIColor colorWithRed:231/255 green:232/255 blue:233/255 alpha:1.0];
   // self.tabBar.backgroundImage.
    //tabBar选中时，图片会使用tabBar的tintColor进行渲染,设置tintColoer
    self.tabBar.tintColor = [UIColor redColor];
    self.viewControllers    = viewControllers;
}

@end
