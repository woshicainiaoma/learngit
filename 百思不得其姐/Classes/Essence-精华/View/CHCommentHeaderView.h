//
//  CHCommentHeaderView.h
//  百思不得其姐
//
//  Created by 陈欢 on 16/4/3.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHCommentHeaderView : UITableViewHeaderFooterView

@property (nonatomic, copy) NSString *title;

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;
@end
