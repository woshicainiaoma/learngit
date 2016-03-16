//
//  CHRecommendViewController.m
//  百思不得其姐
//
//  Created by 陈欢 on 16/2/22.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import "CHRecommendViewController.h"
#import "CHRecommendCategory.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"
#import "CHRecommendCategoryCell.h"
#import "CHRecommendUserCell.h"
#import "MJRefresh.h"
#import "CHRecommendUser.h"

#define CHSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

@interface CHRecommendViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *categories;
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation CHRecommendViewController

static  NSString * const CHCategoryId = @"category";
static NSString * const CHUserId = @"user";

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self setupRefresh];
    
    [self loadCategories];
    
    
    
    
    //[SVProgressHUD showWithStatus:@"正在加载。。。。"];
    
    //[SVProgressHUD  showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    
    
}


- (void)loadCategories
{
    [SVProgressHUD showWithStatus:@"正在加载。。。。"];
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"a"] = @"category";
    parmas[@"c"] = @"subscribe";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parmas progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        self.categories = [CHRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.categoryTableView reloadData];
       
        // 默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败请稍后"];
    }];
}

- (void)setupTableView
{
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CHRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:CHCategoryId];
    
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CHRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:CHUserId];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    
    self.userTableView.rowHeight = 70;
    
    
    self.title = @"推荐关注";
    
    self.view.backgroundColor  =CHGlobalBg;

}


- (void)setupRefresh
{
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    
    self.userTableView.mj_footer.hidden = YES;
    
    
}

- (void)loadNewUsers
{
    CHRecommendCategory *rc = self.categories[self.categoryTableView.indexPathForSelectedRow.row] ;
    rc.currentPage = 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(rc.id);
    params[@"page"] = @(rc.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
        NSArray *users = [CHRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // NSArray *users = [CHRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
       

       [rc.users removeAllObjects];
        
         CHLog(@"%@", users);
        [rc.users addObjectsFromArray:users];
       CHLog(@"%@", rc.users);
        
        rc.total = [responseObject[@"total"] integerValue];
        
        
        if (self.params != params) return;
        
        
        [self.userTableView reloadData];
        
        
        [self.userTableView.mj_header endRefreshing];
        
        
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        if (self.params != params) return ;
        
        [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
        
        [self.userTableView.mj_header endRefreshing];
        
    }];
    
}

- (void)loadMoreUsers
{
    CHRecommendCategory *category = CHSelectedCategory;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(++category.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      
        NSArray *users = [CHRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [category.users addObjectsFromArray:users];
        
        
        if (self.params != params) return ;
        [self.userTableView reloadData];
        
        [self checkFooterState];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return ;
        
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
        
        [self.userTableView.mj_footer endRefreshing];
        
        
    }];
}

- (void)checkFooterState
{
    CHRecommendCategory *rc = CHSelectedCategory;
    
    self.userTableView.mj_footer.hidden = (rc.users.count == 0);
    
    
    if (rc.users.count == rc.total) {
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }else {
        [self.userTableView.mj_footer endRefreshing];
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    if (tableView == self.categoryTableView)
        return self.categories.count;
    
    [self checkFooterState];
    return [CHSelectedCategory users].count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (tableView == self.categoryTableView) {
        CHRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CHCategoryId];
        
        cell.category = self.categories[indexPath.row];
        return cell;
    }else {
        
        CHRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:CHUserId];
        cell.user = [CHSelectedCategory users][indexPath.row];
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    
    CHRecommendCategory *c = self.categories[indexPath.row];
    if (c.users.count) {
        [self.userTableView reloadData];
    }else {
        [self.userTableView reloadData];
        [self.userTableView.mj_header beginRefreshing];
    }
}



- (void)dealloc
{
    [self.manager.operationQueue cancelAllOperations];
    
    [SVProgressHUD dismiss];
}







@end
