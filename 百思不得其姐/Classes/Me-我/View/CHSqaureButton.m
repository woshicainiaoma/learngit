//
//  CHSqaureButton.m
//  百思不得其姐
//
//  Created by 陈欢 on 16/4/4.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import "CHSqaureButton.h"
#import "CHSquare.h"
#import "UIButton+WebCache.h"
@implementation CHSqaureButton

- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
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
    
    self.imageView.y = self.height *0.15;
    self.imageView.width = self.width *0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width *0.5;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxX(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

- (void)setSquare:(CHSquare *)square
{
    _square = square;
    
    [self setTitle:square.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
    
}
@end
