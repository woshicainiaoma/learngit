//
//  CHWordTableViewController.m
//  百思不得其姐
//
//  Created by 陈欢 on 16/2/26.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import "CHWordTableViewController.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "CHTopic.h"
@interface CHWordTableViewController ()

@property (nonatomic, strong) NSMutableArray *topics;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, copy) NSString *maxtime;

@property (nonatomic, strong) NSDictionary *params;


@end

@implementation CHWordTableViewController
- (NSMutableArray *)topics
{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setTabbel];
    
    [self setupRefresh];
    
}
- (void)setTabbel
{
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = CHTitilesViewH + CHTitilesViewY;
    // CHLog(@"%@",NSStringFromCGRect(vc.view.frame));
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}


- (void)loadNewTopics
{
    [self.tableView.mj_footer endRefreshing];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"29";
    self.params =params;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != params) return ;
        self.topics = [CHTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
        self.page = 0;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return ;
        [SVProgressHUD showErrorWithStatus:@"网络连接错误!!!"];
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreTopics
{
    
    
    [self.tableView.mj_header endRefreshing];
    
    self.page++;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"29";
    params[@"page"] = @(self.page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (self.params != params)
            return ;
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        NSArray *newTopics = [CHTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.topics addObjectsFromArray:newTopics];
        
        [self reloadInputViews];
        
        [self.tableView.mj_footer endRefreshing];
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return ;
        
        [self.tableView.mj_footer endRefreshing];
        
        self.page--;
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    CHTopic *topic = self.topics[indexPath.row];
    cell.textLabel.text = topic.name;
    cell.detailTextLabel.text = topic.text;
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    
    return cell;
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
//{
//    return 100;
//}
//


























@end
