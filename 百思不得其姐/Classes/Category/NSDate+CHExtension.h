//
//  NSDate+CHExtension.h
//  百思不得其姐
//
//  Created by 陈欢 on 16/3/22.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CHExtension)
- (NSDateComponents *)deltaFrom:(NSDate *)from;


- (BOOL)isThisYear;


- (BOOL)isToday;


- (BOOL)isYesterday;
@end
