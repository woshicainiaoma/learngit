//
//  CHShowPictureViewController.m
//  百思不得其姐
//
//  Created by 陈欢 on 16/3/23.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import "CHShowPictureViewController.h"
#import "CHTopic.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "CHProgressView.h"

@interface CHShowPictureViewController ()
@property (weak, nonatomic) IBOutlet CHProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation CHShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UIGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    
    CGFloat pictureW = screenW;
    CGFloat pictureH = pictureW * self.topic.height / self.topic.width;
    if (pictureH > screenH) {
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
        
    }else {
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.centerY = screenH * 0.5;
    }
    
    //[self.progressView setProgress:self.topic.pictureProgress animated:YES];
    
    [imageView sd_setImageWithURL:self.topic.large_image placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        //[self.progressView setProgress:1.0 * receivedSize / expectedSize animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
}

- (IBAction)back {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (IBAction)save {
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片下载没有完成"];
        return;
    }
    
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
    }
}



@end
