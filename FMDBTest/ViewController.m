//
//  ViewController.m
//  FMDBTest
//
//  Created by apple on 16/4/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "FMDBManager.h"
#import "User.h"

@interface ViewController ()
{
    FMDBManager * _manager;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _manager = [FMDBManager shareManager];
    [_manager createFMDB];
    User * user = [[User alloc] init];
    user.name = @"小白";
    user.age = 10;
    [_manager insertData:user];
    user.age = 20;
    [_manager updateData:user];
    [_manager deleteData:user];
    user.name = @"小李";
    [_manager insertData:user];
    [_manager insertData:user];
    NSArray * arr =  [_manager searchData:user];
    for (User * newuser in arr) {
        NSLog(@"姓名:%@,年龄:%ld",newuser.name,newuser.age);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
