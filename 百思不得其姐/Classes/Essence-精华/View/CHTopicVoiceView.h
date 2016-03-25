//
//  CHTopicVoiceView.h
//  百思不得其姐
//
//  Created by 陈欢 on 16/3/25.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CHTopic;

@interface CHTopicVoiceView : UIView

+ (instancetype)voiceView;

@property (nonatomic, strong) CHTopic *topic;
@end
