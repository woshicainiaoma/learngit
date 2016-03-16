//
//  CHFriendTrendsViewController.m
//  百思不得其姐
//
//  Created by 陈欢 on 16/2/19.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import "CHFriendTrendsViewController.h"
#import "CHRecommendViewController.h"
#import "CHLoginRegisterViewController.h"
@interface CHFriendTrendsViewController ()
- (IBAction)loginRegister;

@end

@implementation CHFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super viewDidLoad];
    
    // 设置导航栏标题
    self.navigationItem.title = @"我的关注";
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
    
    // 设置背景色
    self.view.backgroundColor = CHGlobalBg;
}

- (void)friendsClick
{
    CHRecommendViewController *vc = [[CHRecommendViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}




- (IBAction)loginRegister {
    CHLoginRegisterViewController *login = [[CHLoginRegisterViewController alloc] init];
    [self presentViewController:login animated:YES completion:nil];
}
@end
