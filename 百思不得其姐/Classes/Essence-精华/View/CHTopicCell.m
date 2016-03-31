//
//  CHTopicCell.m
//  百思不得其姐
//
//  Created by 陈欢 on 16/3/18.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import "CHTopicCell.h"
#import "CHTopic.h"
#import "UIImageView+WebCache.h"
#import "CHTopicPictureView.h"
#import "CHTopicVoiceView.h"
#import "CHTopicVideoView.h"
#import "CHUser.h"
#import "CHComment.h"

@interface CHTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;

@property (weak, nonatomic) IBOutlet UILabel *createTimeLable;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;
@property (weak, nonatomic) IBOutlet UILabel *text_label;

@property (nonatomic, weak) CHTopicPictureView *pictureView;

@property (nonatomic, weak) CHTopicVoiceView *voiceView;

@property (nonatomic, weak) CHTopicVideoView *videoView;
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@end

@implementation CHTopicCell

- (CHTopicPictureView *)pictureView
{
    if (!_pictureView) {
        CHTopicPictureView *pictureView = [CHTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (CHTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        CHTopicVoiceView *voiceView = [CHTopicVoiceView voiceView];
        
        [self.contentView addSubview:voiceView];
        _voiceView =voiceView;
    }
    return _voiceView;
}

- (CHTopicVideoView *)videoView
{
    if (!_videoView) {
        CHTopicVideoView *videoView = [CHTopicVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

- (void)awakeFromNib {
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setTopic:(CHTopic *)topic
{
    _topic = topic;
    
    
    self.sinaVView.hidden = !topic.isSina_v;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLable.text = topic.name;
    
    self.createTimeLable.text = topic.create_time;
    
    
    
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
    
    self.text_label.text = topic.text;
    
    if (topic.type == CHTopicTypePicture) {
        self.pictureView.hidden = NO;
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureF;
        
        self.videoView.hidden =YES;
        self.voiceView.hidden = YES;
    } else if (topic.type == CHTopicTypeVoice) {
        self.voiceView.hidden = NO;
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceF;
        self.pictureView.hidden =YES;
        self.videoView.hidden =YES;
    } else if (topic.type == CHTopicTypeVideo) {
        self.videoView.hidden = NO;
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoF;
        
        self.pictureView.hidden =YES;
        self.voiceView.hidden = YES;
    } else {
        
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }
    
    CHComment *cmt = [topic.top_cmt firstObject];
    if (cmt) {
        self.topCmtView.hidden = NO;
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@", cmt.user.username, cmt.content];
    }else {
        self.topCmtView.hidden = YES;
    }
        
    
    
}

- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    if (count > 10000){
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
    
}


- (void)setFrame:(CGRect)frame
{
    
    
    frame.origin.x = CHTopicCellMargin;
    frame.size.width -= 2 *CHTopicCellMargin;
    frame.size.height -= CHTopicCellMargin;
    frame.origin.y += CHTopicCellMargin;
    
    [super setFrame:frame];
}

















@end
