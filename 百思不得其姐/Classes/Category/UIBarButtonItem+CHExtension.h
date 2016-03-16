//
//  UIBarButtonItem+CHExtension.h
//  百思不得其姐
//
//  Created by 陈欢 on 16/2/18.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CHExtension)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
