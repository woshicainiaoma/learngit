//
//  UIBarButtonItem+CHExtension.m
//  百思不得其姐
//
//  Created by 陈欢 on 16/2/18.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import "UIBarButtonItem+CHExtension.h"

@implementation UIBarButtonItem (CHExtension)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc]initWithCustomView:button];
}
@end
