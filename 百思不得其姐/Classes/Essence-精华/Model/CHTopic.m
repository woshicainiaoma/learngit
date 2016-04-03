//
//  CHTopic.m
//  百思不得其姐
//
//  Created by 陈欢 on 16/2/26.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import "CHTopic.h"
#import "CHUser.h"
#import "CHComment.h"

@implementation CHTopic

{
    CGFloat _cellHeight;
    CGRect _pictureF;
}

+ (NSDictionary *)replacedKeyFromPropertyName

{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2",
             @"ID" : @"id",
             @"top_cmt" : @"top_cmt[0]"
             };
}

+ (NSDictionary *)objectClassInArray
{
    return @{@"top_cmt" : @"CHComment"};
}

- (NSString *)create_time

{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    
    NSDate *create = [fmt dateFromString:_create_time];
    
    if (create.isThisYear) {
        if (create.isToday) {
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) {
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else {
                return @"刚刚";
            }
        } else if (create.isYesterday) {
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:create];
        } else {
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:create];
        }
    } else { 
        return _create_time;
    }


}

- (CGFloat)cellHeight
{
    
    
    if (!_cellHeight) {
      //  CHLog(@"\nbeigin---\n%@\n%@\n%@\end",self.small_image,self.middle_image,self.large_image);
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * CHTopicCellMargin, MAXFLOAT);
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        _cellHeight = CHTopicCellTextY + textH + CHTopicCellBottomBarH + 2 *CHTopicCellMargin;
        
        if (self.type == CHTopicTypePicture) {
        
            
        
            CGFloat pictureW = maxSize.width;
            
            CGFloat pictureH = pictureW * self.height / self.width;
             
            if (pictureH >= CHTopicCellPictureMaxH) {
                pictureH = CHTopicCellPictureBreakH;
                self.bigPicture = YES;
            }
            CGFloat pictureX = CHTopicCellMargin;
            CGFloat pictyreY = CHTopicCellTextY + textH + CHTopicCellMargin;
            _pictureF = CGRectMake(pictureX, pictyreY, pictureW, pictureH);
            _cellHeight += pictureH +CHTopicCellMargin ;
            
        }else if (self.type == CHTopicTypeVoice){
            CGFloat voiceX = CHTopicCellMargin;
            CGFloat voiceY = CHTopicCellTextY + textH + CHTopicCellMargin;
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = voiceW * self.height / self.width;
            _voiceF = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            
            _cellHeight += voiceH + CHTopicCellMargin;
            
        } else if (self.type == CHTopicTypeVideo) {
            
            CGFloat videoX = CHTopicCellMargin;
            CGFloat videoY = CHTopicCellTextY + textH + CHTopicCellMargin;
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW * self.height / self.width;
            _videoF = CGRectMake(videoX, videoY, videoW, videoH);
            
            _cellHeight += videoH + CHTopicCellMargin;

            
        }
        
       // CHComment *cmt = [self.top_cmt];
        if (self.top_cmt) {
            NSString *content = [NSString stringWithFormat:@"%@ : %@", self.top_cmt.user.username, self.top_cmt.content];
            
            CGFloat contentH = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
            _cellHeight += CHTopicCellTopCmtTitleH + contentH + 20 ;
        }
        
       // _cellHeight += CHTopicCellBottomBarH + CHTopicCellMargin;
        
        
        

        
   }
    return _cellHeight;
}
@end
