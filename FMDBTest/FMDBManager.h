//
//  FMDBManager.h
//  FMDBTest
//
//  Created by apple on 16/4/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>
#import "User.h"

@interface FMDBManager : NSObject

@property (nonatomic,strong)FMDatabase * db;

+(instancetype)shareManager;

/**
 *  创建数据库
 */
-(void)createFMDB;

/**
 *  插入数据
 *
 *  @param user <#user description#>
 */
-(void)insertData:(User *)user;

/**
 *  修改数据
 *
 *  @param user  <#user description#>
 *  @param key   <#key description#>
 *  @param value <#value description#>
 */
-(void)updateData:(User *)user;

/**
 *  删除数据
 *
 *  @param user <#user description#>
 */
-(void)deleteData:(User *)user;

/**
 *  查询数据
 */

-(NSArray *)searchData:(User *)user;

@end
