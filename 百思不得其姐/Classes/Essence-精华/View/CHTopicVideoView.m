//
//  CHTopicVideoView.m
//  百思不得其姐
//
//  Created by 陈欢 on 16/3/25.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import "CHTopicVideoView.h"
#import "CHTopic.h"
#import "UIImageView+WebCache.h"
#import "CHShowPictureViewController.h"

@interface CHTopicVideoView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLable;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLable;

@end


@implementation CHTopicVideoView

+ (instancetype)videoView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

- (void)showPicture
{
    
    CHShowPictureViewController *showPicture = [[CHShowPictureViewController alloc] init];
    showPicture.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}

- (void)setTopic:(CHTopic *)topic
{
    
    _topic = topic;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    self.playcountLable.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    
    
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.videotimeLable.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
     
}
@end
