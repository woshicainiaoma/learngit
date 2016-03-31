//
//  CHComment.h
//  百思不得其姐
//
//  Created by 陈欢 on 16/3/31.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CHUser;
@interface CHComment : NSObject

@property (nonatomic, assign) NSInteger voicetime;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) NSInteger like_count;

@property (nonatomic, strong) CHUser *user;
@end
