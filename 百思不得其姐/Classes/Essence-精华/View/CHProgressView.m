//
//  CHProgressView.m
//  百思不得其姐
//
//  Created by 陈欢 on 16/3/22.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import "CHProgressView.h"

@implementation CHProgressView

- (void)awakeFromNib
{
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
    
    NSString *text = [NSString stringWithFormat:@"%.0f%%", progress *100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

@end
