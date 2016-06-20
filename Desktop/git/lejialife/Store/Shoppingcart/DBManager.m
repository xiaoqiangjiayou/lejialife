//
//  DBManager.m
//  LejiaLife
//
//  Created by 张强 on 16/4/15.
//  Copyright © 2016年 张强. All rights reserved.
//

#import "DBManager.h"
#import "FMDatabase.h"
@interface DBManager ()
@property(nonatomic)FMDatabase *db;
@end
@implementation DBManager
+ (instancetype)manager
{
    static DBManager *s_dbManager = nil;
    //内部加锁，目的为了防止多线程不安全
    @synchronized(self) {
        if (s_dbManager == nil) {
            s_dbManager = [[DBManager alloc]init];
        }
    }
    return s_dbManager;
}
- (NSString *)getDatabasePath
{
    NSString *dbPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/goods.sqlite"];
    NSLog(@"%@",dbPath);
    return dbPath;
}
- (id)init{
    if (self = [super init]) {
        //使用文件路径，初始化db，本质上sqlite也是一个文件
        //使用DBMS来操作管理这个文件
        self.db = [[FMDatabase alloc]initWithPath:[self getDatabasePath]];
        //打开数据库，注意：当数据库文件不存在的时候，调用打开操作会生成该数据库文件，有就直接打开
        if ([self.db open]) {
            //创建存储数据的表Person
            [self createGoodsTable];
        }
    }
    return self;
}
-(void)createGoodsTable{
    //使用sql语句生成表
    NSString *sql = @"CREATE TABLE IF NOT EXISTS Goods(g_SQLid INTEGER PRIMARY KEY AUTOINCREMENT,detailId TEXT,name TEXT,Image TEXT,price TEXT,description TEXT,numbers TEXT,productSpecsId TEXT)";
    //执行sql语句
    if([self.db executeUpdate:sql])
    {
        NSLog(@"创建表成功");
    }else{
        NSLog(@"创建表失败");
    }
}

//添加一个商品
- (void)addGoods:(GoodsModel*)goods
{
    //NSLog(@"%d%d%@")
    //❓为占位符号，当执行sql语句的时候，需要执行的时候把数值填充上
    NSString *sql = @"INSERT INTO Goods(detailId,name,Image,price,description,numbers,productSpecsId) values(?,?,?,?,?,?,?)";
    BOOL bRet = [self.db executeUpdate:sql,goods.detailId,goods.name,goods.imageurl,goods.price,goods.Description,goods.numbers,goods.productSpecsId];
    if (bRet) {
        NSLog(@"插入成功");
    }else{
        NSLog(@"插入纪录失败");
    }
}

//更新一个商品
- (void)updateGoods:(GoodsModel*)goods
{
    NSString *sql = @"UPDATE Goods SET name = ?,image = ?,price=?,description=?,numbers=? WHERE detailId = ?AND productSpecsId=?";
    BOOL bRet = [self.db executeUpdate:sql,goods.name,goods.imageurl,goods.price,goods.Description,goods.numbers,goods.detailId,goods.productSpecsId];
    if (bRet) {
        NSLog(@"更新成功");
    }else{
        NSLog(@"跟新纪录失败");
    }
}

//删除一个商品
- (void)deleteGoods:(GoodsModel*)Goods
{
    NSString *sql = @"DELETE FROM Goods WHERE detailId = ? AND productSpecsId=?";
    BOOL bRet = [self.db executeUpdate:sql,Goods.detailId,Goods.productSpecsId];
    if (bRet) {
        NSLog(@"删除记录成功");
    }else{
        NSLog(@"删除纪录失败");
    }
}
//


//查看商品是否存在
- (BOOL)isGoodsExists:(GoodsModel*)Goods
{
    NSString *sql = @"SELECT * FROM Goods WHERE detailId = ? AND productSpecsId=?";
    FMResultSet *resultSet = [self.db executeQuery:sql,Goods.detailId,Goods.productSpecsId];
    BOOL isExists = resultSet.next;
    [resultSet close];
    NSLog(@"已存在，不加入");
    return isExists;

}
//读取所有的商品
- (NSArray*)readAllGoods
{
    NSMutableArray *allGoods = [NSMutableArray array];
    NSString *sql = @"SELECT * FROM Goods";
    //查询语句使用的是executeQuery
    FMResultSet *resultSet = [self.db executeQuery:sql];
    //调用一次next操作，返回一行纪录，接着是下一行，一直持续下去，遍历完返回nil
    while (resultSet.next) {
        GoodsModel *good = [[GoodsModel alloc]init];
        //通过typeForCloumn:表字段名 来获取一行中某个字段对应的值，根据类型调用 intForColumn，stringForColumn，dataForColumn
        good.detailId = [resultSet stringForColumn:@"detailId"];
        good.name=[resultSet stringForColumn:@"name"];
        good.imageurl     = [resultSet stringForColumn:@"image"];
        good.price      = [resultSet stringForColumn:@"price"];
        good.Description      = [resultSet stringForColumn:@"description"];
        good.numbers      = [resultSet stringForColumn:@"numbers"];
        good.productSpecsId=[resultSet stringForColumn:@"productSpecsId"];
        [allGoods addObject:good];
    }
    
    //释放保存记录的内存，防止内存泄漏
    [resultSet close];
    return allGoods;
}

//事务：批量操作数据库，譬如大量插入操作。。。
//为了原子性（要么全部成功，要么全部失败），同时使事务可以提高批量操作的效率
//isFlag；yes  使用事务
//isFlag；no   不使用事务
//-(void)insertManyGoods:(BOOL)isFlag{
//    
//    if (isFlag) {
//        //
//        //        NSData *start=[NSData data];
//        [self.db beginTransaction];
//        for (int index=0; index<10; index++) {
//            GoodsModel *g=[[GoodsModel alloc]init];
//            g.name=index;
//            p.name=[NSString stringWithFormat:@"%d",index];
//            [self addPerson:p];
//        }//提交
//        [self.db commit];
//        //        NSDate *end=[NSDate date];
//        //计算两个时间之间的秒数
//        //        NSTimeInterval usingSec=[end timeIntervalSinceDate:start];
//    }else{
//        //不使用事务
//        for (int index=0; index<10; index++) {
//            PersonModel *p=[[PersonModel alloc]init];
//            p.age=index;
//            p.name=[NSString stringWithFormat:@"%d",index];
//            [self addPerson:p];
//        }
//    }
//    
//}

@end
