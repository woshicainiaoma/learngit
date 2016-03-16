//
//  CHNewViewController.m
//  百思不得其姐
//
//  Created by 陈欢 on 16/2/19.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import "CHNewViewController.h"

@interface CHNewViewController ()

@end

@implementation CHNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    // 设置背景色
    self.view.backgroundColor = CHGlobalBg;
}

- (void)tagClick
{
    
}


@end
