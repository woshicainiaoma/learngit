//
//  CHCommentHeaderView.m
//  百思不得其姐
//
//  Created by 陈欢 on 16/4/3.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import "CHCommentHeaderView.h"
@interface CHCommentHeaderView()

@property (nonatomic, weak) UILabel *lable;
@end

@implementation CHCommentHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"header";
    CHCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        header = [[CHCommentHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = CHGlobalBg;
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CHRGBColor(67, 67, 67);
        label.width = 200;
        label.x = CHTopicCellMargin;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        self.lable = label;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.lable.text =title;
}
@end
