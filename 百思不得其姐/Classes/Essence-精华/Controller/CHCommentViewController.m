//
//  CHCommentViewController.m
//  百思不得其姐
//
//  Created by 陈欢 on 16/3/31.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import "CHCommentViewController.h"
#import "CHCommentCell.h"
#import "CHTopicCell.h"
#import "CHTopic.h"
#import "MJRefresh.h"
#import "CHComment.h"
#import "MJExtension.h"
#import "CHCommentHeaderView.h"
#import "AFNetworking.h"

static NSString * const CHCommentId = @"comment";

@interface CHCommentViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSapce;

@property (nonatomic, strong) NSArray *hotComments;

@property (nonatomic, strong) NSMutableArray *latestComments;

@property (nonatomic, strong) CHComment *save_top_cmt;
@end

@implementation CHCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    
    [self setupHeader];
    
    [self setupRefresh];
}
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadNewComments
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.hotComments = [CHComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        self.latestComments = [CHComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];

    }];
}

- (void)setupHeader
{
    UIView *header = [[UIView alloc] init];
    
    if (self.topic.top_cmt) {
        self.save_top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }
    CHTopicCell *cell = [CHTopicCell cell];
    cell.topic = self.topic;
    cell.size = CGSizeMake(CHScreenW, self.topic.cellHeight);
    [header addSubview:cell];
    
    header.height = self.topic.cellHeight + CHTopicCellMargin;
    
    self.tableView.tableHeaderView = header;
    
}

- (void)setupBasic
{
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.backgroundColor = CHGlobalBg;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CHCommentCell class]) bundle:nil   ] forCellReuseIdentifier:CHCommentId];
}

- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    CGRect frame= [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    self.bottomSapce.constant = CHScreenH - frame.origin.y;
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (self.save_top_cmt) {
        self.topic.top_cmt = self.save_top_cmt;
        
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }
}


- (NSArray *)commentsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.latestComments;
    }
    return self.latestComments;
}

- (CHComment *)commentInIndexPath:(NSIndexPath *)indexPath
{
    return [self commentsInSection:indexPath.section][indexPath.row];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latesCount = self.latestComments.count;
    if (hotCount) return 2;
    if (latesCount) return 1;
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latesCount = self.latestComments.count;
    if (section == 0) {
        return hotCount ? hotCount : latesCount;
    }
    return latesCount;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CHCommentHeaderView *header = [CHCommentHeaderView headerViewWithTableView:tableView];
    
    NSInteger hotCount = self.hotComments.count;
    if (section == 0) {
        header.title = hotCount ? @"最热评论" : @"最新评论";
    }else {
        header.title = @"最新评论";
    }
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CHCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CHCommentId];
    
    cell.comment = [self commentInIndexPath:indexPath];
    
    
    
    return cell;
}













@end
