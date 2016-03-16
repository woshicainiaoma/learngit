//
//  CHLoginRegisterViewController.m
//  百思不得其姐
//
//  Created by 陈欢 on 16/2/24.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import "CHLoginRegisterViewController.h"

@interface CHLoginRegisterViewController ()
- (IBAction)back;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@end

@implementation CHLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)showLoginOrRegister:(UIButton *)button {
    
    [self.view endEditing:YES];
    
    if (self.loginViewLeftMargin.constant == 0) {
        self.loginViewLeftMargin.constant = -self.view.width;
        button.selected = YES;
    }else {
        self.loginViewLeftMargin.constant = 0;
        button.selected = NO;
    }
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}
@end
