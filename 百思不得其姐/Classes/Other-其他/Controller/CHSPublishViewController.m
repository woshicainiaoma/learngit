//
//  CHSPublishViewController.m
//  百思不得其姐
//
//  Created by 陈欢 on 16/3/25.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import "CHSPublishViewController.h"
#import "CHVerticalButton.h"



@interface CHSPublishViewController ()

@end

@implementation CHSPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.view.userInteractionEnabled = NO;
    
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    
    sloganView.y = CHScreenH * 0.2;
    sloganView.centerX = CHScreenW * 0.5;
    [self.view addSubview:sloganView];
    
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (CHScreenH - 2 * buttonH) * 0.5;
    CGFloat buttonStartX = 20;
    CGFloat xMargin = (CHScreenW - 2 * buttonStartX - maxCols * buttonW) / (maxCols - 1);
    for (int i = 0; i<images.count; i++) {
        CHVerticalButton *button = [[CHVerticalButton alloc] init];
        // 设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        // 设置frame
        button.width = buttonW;
        button.height = buttonH;
        int row = i / maxCols;
        int col = i % maxCols;
        button.x = buttonStartX + col * (xMargin + buttonW);
        button.y = buttonStartY + row * buttonH;
        
        
        
        
        
        
        [self.view addSubview:button];
    }
}

- (IBAction)cancel {
    [self dismissViewControllerAnimated:NO completion:nil];
    
    
}

@end