//
//  CHMeViewController.m
//  百思不得其姐
//
//  Created by 陈欢 on 16/2/19.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import "CHMeViewController.h"

@interface CHMeViewController ()

@end

@implementation CHMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    
    // 设置导航栏右边的按钮
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
    
    // 设置背景色
    self.view.backgroundColor = CHGlobalBg;
}

- (void)settingClick
{
    CHLogFunc;
}

- (void)moonClick
{
    CHLogFunc;
}


@end
