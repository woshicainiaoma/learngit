//
//  CHTopWindowViewController.m
//  百思不得其姐
//
//  Created by 陈欢 on 16/4/3.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import "CHTopWindowViewController.h"

@interface CHTopWindowViewController ()
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;
@property (nonatomic, assign) BOOL statusBarHidden;

@end

@implementation CHTopWindowViewController

static UIWindow *window_;


+ (void)initialize
{
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(0, 0, CHScreenW, 20);
    window_.backgroundColor = [UIColor clearColor];
    window_.windowLevel = UIWindowLevelAlert;
    CHTopWindowViewController *topWindowVC = [[CHTopWindowViewController alloc]init];
    window_.rootViewController = topWindowVC;
    
    
    //[window_ makeKeyAndVisible];
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
    
}

+ (void)hide
{
    window_.hidden = YES;
}

+ (void)show
{
    window_.hidden = NO;
}
+ (void)windowClick
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [self searchScrollViewInView:window];
}

+ (void)searchScrollViewInView:(UIView *)superview
{
    for (UIScrollView *subview in superview.subviews) {
    
        if ([subview isKindOfClass:[UIScrollView class]] && subview.isShowingOnKeyWindow) {
            CGPoint offset = subview.contentOffset;
            offset.y = - subview.contentInset.top;
            [subview setContentOffset:offset animated:YES];
        }
        
        
        [self searchScrollViewInView:subview];
    }
}

#pragma mark - 状态栏控制
- (BOOL)prefersStatusBarHidden
{
    return self.statusBarHidden;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.statusBarStyle;
}

#pragma mark - setter
- (void)setStatusBarHidden:(BOOL)statusBarHidden
{
    _statusBarHidden = statusBarHidden;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle
{
    _statusBarStyle = statusBarStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}
@end
