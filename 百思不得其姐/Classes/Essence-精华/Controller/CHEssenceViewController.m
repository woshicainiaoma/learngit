//
//  CHEssenceViewController.m
//  百思不得其姐
//
//  Created by 陈欢 on 16/2/19.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import "CHEssenceViewController.h"
#import "CHRecommendTagsViewController.h"
#import "CHTopicViewController.h"
@interface CHEssenceViewController () <UIScrollViewAccessibilityDelegate>
/** 标签栏底部的红色指示器 */
@property (nonatomic, weak) UIView *indicatorView;
/** 当前选中的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;
/** 顶部的所有标签 */
@property (nonatomic, weak) UIView *titlesView;
/** 底部的所有内容 */
@property (nonatomic, weak) UIScrollView *contentView;


@end

@implementation CHEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    
    [self setupChildVces];
    
    [self setTitleView];
    
    [self setupContentView];
}

- (void)tagClick
{
    CHRecommendTagsViewController *tags = [[CHRecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:tags animated:YES];
}

- (void)setupChildVces
{
    CHTopicViewController *all = [[CHTopicViewController alloc] init];
    all.title = @"全部";
    all.type = CHTopicTypeAll;
    [self addChildViewController:all];
    
    CHTopicViewController *video = [[CHTopicViewController alloc] init];
    video.title = @"视频";
    video.type = CHTopicTypeVideo;
    [self addChildViewController:video];
    
    CHTopicViewController *voice = [[CHTopicViewController alloc] init];
    voice.title = @"声音";
    voice.type = CHTopicTypeVoice;
    [self addChildViewController:voice];
    
    CHTopicViewController *word = [[CHTopicViewController alloc] init];
    word.title = @"段子";
    word.type = CHTopicTypeWord;
    [self addChildViewController:word];
    
    CHTopicViewController *picture = [[CHTopicViewController alloc] init];
    picture.title = @"图片";
    picture.type = CHTopicTypePicture;
    [self addChildViewController:picture];
}

- (void)setupNav
{
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    // 设置背景色
    self.view.backgroundColor = CHGlobalBg;

}

- (void)setTitleView

{
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titleView.width = self.view.width;
    titleView.height = CHTitilesViewH;
    titleView.y = CHTitilesViewY;
    [self.view addSubview:titleView];
    self.titlesView = titleView;
    
    UIView *indicatorView = [[UIView alloc] init];
    
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = 1;
    indicatorView.y = titleView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    NSArray *title = @[@"全部",@"视频", @"声音", @"段子",@"图片"];
    
    CGFloat width = titleView.width / title.count;
    CGFloat height = titleView.height;
    
    for (NSInteger i = 0; i<title.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i *width;
        [button setTitle:title[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        //[button addTarget:self action:@selector(titleClick:(UIButton *)) forControlEvents:UIControlEventTouchUpOutside];
         [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:button];
        
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            /**
             *  让按钮内部lable根据文字内容计算尺寸
             */
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.center.x;
        }
        
    }
    [titleView addSubview:indicatorView];
}




    
- (void)titleClick:(UIButton *)button
    {
        self.selectedButton.enabled = YES;
        button.enabled = NO;
        self.selectedButton = button;
        
        [UIView animateWithDuration:0.25 animations:^{
            
            //CHLog(@"%@",NSStringFromCGRect(self.indicatorView.frame));
            

            
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
            
        }];
        
        CGPoint offset = self.contentView.contentOffset;
        offset.x = button.tag *self.contentView.width;
        [self.contentView setContentOffset:offset animated:YES];
    }


- (void)setupContentView
{
 
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc]init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width *self.childViewControllers.count, 00);
    self.contentView = contentView;
    
    [self scrollViewDidEndScrollingAnimation:contentView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    UITableViewController *vc = self.childViewControllers[index];
    
    vc.view.x = scrollView.contentOffset.x ;
    vc.view.y = 0;
    vc.view.height = scrollView.height;
    
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
}


























@end
