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

@property (nonatomic, assign, getter=isSina_v) BOOL Sina_v;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, copy) NSString *small_image;

@property (nonatomic, copy) NSString *middle_image;

@property (nonatomic, copy) NSString *large_image;

@property (nonatomic, assign) CHTopicType type;

@property (nonatomic, assign) NSInteger voicetime;

@property (nonatomic, assign) NSInteger videotime;

@property (nonatomic, assign) NSInteger playcount;

@property (nonatomic, assign) CGFloat pictureProgress;

@property (nonatomic, strong) NSArray *top_cmt;


@property (nonatomic, assign, readonly) CGFloat cellHeight;

@property (nonatomic, assign, readonly) CGRect pictureF;

@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;

@property (nonatomic, assign, readonly) CGRect voiceF;

@property (nonatomic, assign, readonly) CGRect videoF;
@end
