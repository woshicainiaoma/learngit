//
//  CHTagTextField.m
//  百思不得其姐
//
//  Created by 陈欢 on 16/4/5.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import "CHTagTextField.h"

@implementation CHTagTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.placeholder = @"多个标签用逗号或者换行隔开";

        [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        self.height = CHTagH;

    }
    return self;
}

- (void)deleteBackward
{
    !self.deleteBlock ? : self.deleteBlock();
    [super deleteBackward];
}
@end
