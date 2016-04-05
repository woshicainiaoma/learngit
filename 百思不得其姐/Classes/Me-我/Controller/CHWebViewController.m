//
//  CHWebViewController.m
//  百思不得其姐
//
//  Created by 陈欢 on 16/4/4.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import "CHWebViewController.h"

@interface CHWebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation CHWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (IBAction)back:(id)sender {
    [self.webView reload];
}
- (IBAction)go:(id)sender
{
    [self.webView goForward];
}
- (IBAction)refresh:(id)sender {
    
    [self.webView reload];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}
@end
