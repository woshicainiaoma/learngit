//
//  CHTextField.m
//  百思不得其姐
//
//  Created by 陈欢 on 16/2/24.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import "CHTextField.h"

static NSString * const CHPlacerholderColorKeyPath = @"_placeholderLabel.textColor";

@implementation CHTextField

- (void)awakeFromNib
{
    self.tintColor = self.textColor;
    
    [self resignFirstResponder];
}

-(BOOL)becomeFirstResponder
{
    [self setValue:self.textColor forKeyPath:CHPlacerholderColorKeyPath];
    
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    [self setValue:[UIColor grayColor] forKeyPath:CHPlacerholderColorKeyPath];
    
    return [super resignFirstResponder];
}





@end
