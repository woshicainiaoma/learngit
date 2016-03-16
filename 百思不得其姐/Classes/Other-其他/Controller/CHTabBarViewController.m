//
//  CHTabBarViewController.m
//  百思不得其姐
//
//  Created by 陈欢 on 16/2/19.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import "CHTabBarViewController.h"
#import "CHEssenceViewController.h"
#import "CHFriendTrendsViewController.h"
#import "CHMeViewController.h"
#import "CHNewViewController.h"
#import "CHTabBar.h"
#import "CHNavigationController.h"
@interface CHTabBarViewController ()

@end

@implementation CHTabBarViewController



+ (void)initialize
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateHighlighted];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupChildVc:[[CHEssenceViewController alloc]init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    
    [self setupChildVc:[[CHNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self setupChildVc:[[CHFriendTrendsViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setupChildVc:[[CHMeViewController alloc] init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
  
    // 更换tabBar
   [self setValue:[[CHTabBar alloc] init] forKeyPath:@"tabBar"];


}
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置文字和图片
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    //vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1.0];
    CHNavigationController *nav = [[CHNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

@end
