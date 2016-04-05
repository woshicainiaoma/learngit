//
//  CHAddTagViewController.h
//  百思不得其姐
//
//  Created by 陈欢 on 16/4/5.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHAddTagViewController : UIViewController

@property (nonatomic, copy) void (^tagsBlock)(NSArray *tags);


@property (nonatomic, strong) NSArray *tags;

@end
