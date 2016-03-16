//
//  CHRecommendUserCell.m
//  百思不得其姐
//
//  Created by 陈欢 on 16/2/22.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import "CHRecommendUserCell.h"
#import "CHRecommendUser.h"
#import "UIImageView+WebCache.h"

@interface CHRecommendUserCell()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLable;
@property (weak, nonatomic) IBOutlet UILabel *fansCountable;
@end

@implementation CHRecommendUserCell

- (void)setUser:(CHRecommendUser *)user
{
    _user = user;
    self.screenNameLable.text = user.screen_name;
    self.fansCountable.text = [NSString stringWithFormat:@"%zd人关注", user.fans_count];
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}


@end
