//
//  CHPushGuideView.m
//  百思不得其姐
//
//  Created by 陈欢 on 16/2/24.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import "CHPushGuideView.h"

@implementation CHPushGuideView

+ (void)show
{
    NSString *key = @"CFBundleShortVersionString";
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (![currentVersion isEqualToString:sanboxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        CHPushGuideView *guideView = [CHPushGuideView guideView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

- (IBAction)close {
    
    [self removeFromSuperview];
}

+ (instancetype)guideView
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
    
}
@end
