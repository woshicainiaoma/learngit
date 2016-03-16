//
//  CHRecommendCategory.m
//  百思不得其姐
//
//  Created by 陈欢 on 16/2/22.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import "CHRecommendCategory.h"

@implementation CHRecommendCategory
- (NSMutableArray *)users
{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}
@end
