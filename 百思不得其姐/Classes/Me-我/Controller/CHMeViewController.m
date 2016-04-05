//
//  CHMeViewController.m
//  百思不得其姐
//
//  Created by 陈欢 on 16/2/19.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import "CHMeViewController.h"
#import "CHMeCell.h"
#import "CHMeFooterView.h"
@interface CHMeViewController ()

@end

@implementation CHMeViewController

static NSString *CHMeId = @"me";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupNav];
    [self setuptableView];
    
}

- (void)settingClick
{
    CHLogFunc;
}

- (void)moonClick
{
    CHLogFunc;
}

- (void)setupNav
{
    self.navigationItem.title = @"我的";
    
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
    
    
}

- (void)setuptableView
{
   
    
    self.tableView.backgroundColor = CHGlobalBg;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[CHMeCell class] forCellReuseIdentifier:CHMeId];
    
    // 调整header和footer
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = CHTopicCellMargin ;
    
    // 调整inset
    self.tableView.contentInset = UIEdgeInsetsMake(CHTopicCellMargin - 35, 0, 0, 0);
    
    // 设置footerView
    self.tableView.tableFooterView = [[CHMeFooterView alloc] init];
   

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CHMeCell *cell = [tableView dequeueReusableCellWithIdentifier:CHMeId];
    
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"mine-moon-icon-click"];
        cell.textLabel.text = @"登录／注册";
        
    }else if(indexPath.section == 1)
    {
        cell.textLabel.text = @"离线下载";
    }
    return cell;
}











@end
