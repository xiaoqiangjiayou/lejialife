//
//  TabbarModel.m
//  LejiaLife
//
//  Created by 张强 on 16/3/21.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "TabbarModel.h"

@implementation TabbarModel
//初始化 modle的类方法
+ (instancetype)modelWithTitle:(NSString*)title imageName:(NSString*)imageName className:(NSString*)className
{
    //self 代表类本身
    return [[self alloc] initWithTitle:title imageName:imageName className:className];
}

//初始化modle的实例方法
- (id)initWithTitle:(NSString*)title imageName:(NSString*)imageName className:(NSString*)className
{
    //self 代表对象本身
    if (self = [super init]) {
        
        _title     = title;
        _imageName = imageName;
        _className = className;
        
        //self.title 会调用其setter方法，由于调用的是方法，子类可能重写改方法，一旦重写调用的是子类的方法，这里init一般是对自己的成员进行初始化，如果需要对自己的继承的成员初始化一般时调用super init
        //        self.title = title;
        //        self.imageName = imageName;
        //        self.className = className;
    }
    return self;
}

- (UIImage*)normalImage{
    return  [UIImage imageNamed:self.imageName];
}
@end
