//
//  CHTopicPictureView.m
//  百思不得其姐
//
//  Created by 陈欢 on 16/3/22.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import "CHTopicPictureView.h"
#import "CHTopic.h"
#import "UIImageView+WebCache.h"
#import "CHProgressView.h"
#import "CHShowPictureViewController.h"

@interface CHTopicPictureView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;

@property (weak, nonatomic) IBOutlet CHProgressView *progressView;


@end

@implementation CHTopicPictureView

+ (instancetype)pictureView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    //self.imageView.userInteractionEnabled = YES;
   // [self.imageView addGestureRecognizer:[[UIGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}
- (IBAction)lookBig:(id)sender {
    [self showPicture];
}
     
- (void)showPicture
     {
         CHLogFunc;
         CHShowPictureViewController *showPicture = [[CHShowPictureViewController alloc] init];
         showPicture.topic = self.topic;
         [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
     }

- (void)setTopic:(CHTopic *)topic
{
    _topic = topic;
   // [self.progressView setProgress:topic.pictureProgress animated:NO];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                self.progressView.hidden =NO;
                CGFloat progress = 1.0 * receivedSize / expectedSize;
               // [self.progressView setProgress:topic.pictureProgress animated:YES];
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                self.progressView.hidden = YES;
                
                if (topic.isBigPicture == NO)  return ;
                
                UIGraphicsBeginImageContextWithOptions(topic.pictureF.size, YES, 0.0);
                
                CGFloat width = topic.pictureF.size.width;
                CGFloat height = width * image.size.height / image.size.width;
                [image drawInRect:CGRectMake(0, 0, width, height)];
                self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
                
                UIGraphicsEndImageContext();
                
            }];
    
    NSString *extension = topic.large_image.pathExtension;

    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    
    if (topic.isBigPicture) {
        self.seeBigButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }else {
        self.seeBigButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
    }
    
}
    
@end
