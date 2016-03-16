//
//  CHRecommendCategoryCell.m
//  百思不得其姐
//
//  Created by 陈欢 on 16/2/22.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import "CHRecommendCategoryCell.h"
#import "CHRecommendCategory.h"
@interface CHRecommendCategoryCell()


@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;


@end
@implementation CHRecommendCategoryCell

- (void)awakeFromNib {
    
    self.backgroundColor = CHRGBColor(244, 244, 244);
    self.selectedIndicator.backgroundColor = CHRGBColor(219, 21, 26);
}

- (void)setCategory:(CHRecommendCategory *)category

{
    _category = category;
    self.textLabel.text = category.name;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y ;
    //self.textLabel.width = 40;
   // self.textLabel.backgroundColor = [UIColor blueColor];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
   // self.textLabel.numberOfLines = 2;
    [self.textLabel sizeToFit];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    self.selectedIndicator.hidden = !selected;
    self.textLabel.textColor = selected ? self.selectedIndicator.backgroundColor : CHRGBColor(78, 78, 78);
}
@end
