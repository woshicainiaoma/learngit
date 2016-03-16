//
//  CHRecommendCategory.h
//  百思不得其姐
//
//  Created by 陈欢 on 16/2/22.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHRecommendCategory : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSMutableArray *users;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, assign) NSInteger currentPage;
@end
