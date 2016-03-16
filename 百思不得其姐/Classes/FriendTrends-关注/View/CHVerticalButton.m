//
//  CHVerticalButton.m
//  百思不得其姐
//
//  Created by 陈欢 on 16/2/24.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import "CHVerticalButton.h"

@implementation CHVerticalButton

- (void)setup

{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}


- (instancetype)initWithFrame:(CGRect)frame


{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.height;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

@end
