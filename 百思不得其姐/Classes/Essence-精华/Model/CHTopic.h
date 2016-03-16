//
//  CHTopic.h
//  百思不得其姐
//
//  Created by 陈欢 on 16/2/26.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHTopic : NSObject



@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *profile_image;

@property (nonatomic, copy) NSString *create_time;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, assign) NSInteger ding;

@property (nonatomic, assign) NSInteger cai;

@property (nonatomic, assign) NSInteger repost;

@property (nonatomic, assign) NSInteger comment;
@end
