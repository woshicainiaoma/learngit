//
//  CHTopicPictureView.h
//  百思不得其姐
//
//  Created by 陈欢 on 16/3/22.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CHTopic;

@interface CHTopicPictureView : UIView

+ (instancetype)pictureView;

@property (nonatomic, strong) CHTopic *topic;
@end
