//
//  FMDBManager.m
//  FMDBTest
//
//  Created by apple on 16/4/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "FMDBManager.h"
#import "User.h"

#import <FMDatabase.h>
#import <FMDatabaseQueue.h>
#import <FMDB.h>

@implementation FMDBManager

+(instancetype)shareManager
{
    static FMDBManager * manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [[FMDBManager alloc] init];
    });
    return manager;
}
/**
 *  创建数据库
 */
-(void)createFMDB
{
//    self.db  = [FMDatabase databaseWithPath:@"/tmp/tmp.db"];
    NSString * doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * filePath = [doc stringByAppendingPathComponent:@"tmp.sqlite"];
    
    NSLog(@"%@",filePath);
    
//    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:filePath];
    self.db = [FMDatabase databaseWithPath:filePath];
    
    if ([self.db open]) {
        BOOL result = [self.db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL);"];
        if (result) {
            NSLog(@"创建成功");
        }else
        {
            NSLog(@"创建失败");
        }
    }
}
/**
 *  插入数据
 *
 *  @param user <#user description#>
 */
-(void)insertData:(User *)user
{
    BOOL result = [self.db executeUpdateWithFormat:@"INSERT INTO t_student (name, age) VALUES (%@, %d);",user.name,(int)user.age];
    if (result) {
        NSLog(@"插入成功");
    }else
    {
        NSLog(@"插入失败");
    }
}

/**
 *  修改数据
 *
 *  @param user  <#user description#>
 */
-(void)updateData:(User *)user
{
    BOOL result = [self.db executeUpdateWithFormat:@"UPDATE t_student SET age = %d  WHERE name = %@ ",(int)user.age,user.name];
    if (result) {
        NSLog(@"修改成功");
    }else
    {
        NSLog(@"修改失败");
    }
}

/**
 *  删除数据
 *
 *  @param user <#user description#>
 */
-(void)deleteData:(User *)user
{
    BOOL result = [self.db executeUpdateWithFormat:@"DELETE FROM t_student WHERE name = %@ ",user.name];
    if (result) {
        NSLog(@"删除成功");
    }else
    {
        NSLog(@"删除失败");
    }
}

/**
 *  查询数据
 *
 *  @param user <#user description#>
 *
 *  @return <#return value description#>
 */
-(NSArray *)searchData:(User *)user
{
    NSMutableArray * dataSource = [[NSMutableArray alloc] init];
    FMResultSet * set = [self.db executeQueryWithFormat:@"SELECT * FROM t_student WHERE name = %@ ",user.name];
    while ([set next]) {
        User * newuser = [[User alloc] init];
        newuser.age =  [set intForColumn:@"age"];
        newuser.name = [set stringForColumn:@"name"];
        [dataSource addObject:newuser];
    }
    return dataSource;
}

@end
