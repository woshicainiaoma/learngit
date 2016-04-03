//
//  CHCommentCell.m
//  百思不得其姐
//
//  Created by 陈欢 on 16/4/3.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import "CHCommentCell.h"
#import "CHComment.h"
#import "UIImageView+WebCache.h"
#import "CHUser.h"

@interface CHCommentCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLable;
@property (weak, nonatomic) IBOutlet UILabel *contentlable;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLable;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;
@end


@implementation CHCommentCell

- (void)setComment:(CHComment *)comment
{
    _comment = comment;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.contentlable.text = comment.content;
    self.usernameLable.text = comment.user.username;
    self.likeCountLable.text = [NSString stringWithFormat:@"%zd", comment.like_count];
    
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"zd", comment.voicetime] forState:UIControlStateNormal];
    }
    self.voiceButton.hidden = YES;
}

@end
