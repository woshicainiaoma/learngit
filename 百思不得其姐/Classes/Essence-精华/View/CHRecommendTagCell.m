//
//  CHRecommendTagCell.m
//  百思不得其姐
//
//  Created by 陈欢 on 16/2/22.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import "CHRecommendTagCell.h"
#import "CHRecommendTag.h"
#import "UIImageView+WebCache.h"
@interface CHRecommendTagCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;
@end
@implementation CHRecommendTagCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setRecommendTag:(CHRecommendTag *)recommendTag
{
    _recommendTag = recommendTag;
    
    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.themeNameLabel.text = recommendTag.theme_name;
    NSString *subNumber = nil;
    if (recommendTag.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人订阅", recommendTag.sub_number];
    } else { // 大于等于10000
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅", recommendTag.sub_number / 10000.0];
    }
    self.subNumberLabel.text = subNumber;
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 5;
    frame.size.width  -= 2 * frame.origin.x;
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
