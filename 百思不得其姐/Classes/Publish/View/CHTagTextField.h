//
//  CHTagTextField.h
//  百思不得其姐
//
//  Created by 陈欢 on 16/4/5.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHTagTextField : UITextField

@property (nonatomic, copy) void (^deleteBlock)();
@end
