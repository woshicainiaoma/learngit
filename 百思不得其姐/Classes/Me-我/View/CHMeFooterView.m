//
//  CHMeFooterView.m
//  百思不得其姐
//
//  Created by 陈欢 on 16/4/4.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import "CHMeFooterView.h"
#import "AFNetworking.h"
#import "CHSquare.h"
#import "CHSqaureButton.h"
#import "MJExtension.h"
#import "CHWebViewController.h"
@implementation CHMeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
    
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSArray *sqaures = [CHSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            
            [self createSquares:sqaures];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
        
    }
    return self;
}

- (void)createSquares:(NSArray *)sqaures
{
    int maxCols = 4;
    
    CGFloat buttonW = CHScreenW / maxCols;
    CGFloat buttonH = buttonW;
    
    for (int i = 0; i<sqaures.count; i++) {
        CHSqaureButton *button = [CHSqaureButton buttonWithType:UIButtonTypeCustom];
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.square = sqaures[i];
        [self addSubview:button];
        
        int col = i % maxCols;
        int row = i / maxCols;
        
        button.x = col * buttonW;
        button.y = row * buttonH;
        button.width = buttonW;
        button.height = buttonH;
        
        NSUInteger rows = (sqaures.count + maxCols - 1) / maxCols;
        
        
        self.height = rows * buttonH ;
        
        
        [self setNeedsDisplay];

    }
}


- (void)buttonClick:(CHSqaureButton *)button
{
    if (![button.square.url hasPrefix:@"http"]) return;
    
    CHWebViewController *web = [[CHWebViewController alloc] init];
    web.url = button.square.url;
    web.title = button.square.name;
    
    // 取出当前的导航控制器
    UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)tabBarVc.selectedViewController;
    [nav pushViewController:web animated:YES];
}



@end
