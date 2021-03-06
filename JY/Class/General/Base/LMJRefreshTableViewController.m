//
//  LMJRefreshTableViewController.m
//  PLMMPRJK
//
//  Created by 王杰 on 2017/4/11.
//  Copyright © 2018年 飞鱼旅行. All rights reserved.
//

#import "LMJRefreshTableViewController.h"


@interface LMJRefreshTableViewController ()

@end

@implementation LMJRefreshTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LMJWeakSelf(self);
    LMJNormalRefreshHeader *header = [LMJNormalRefreshHeader headerWithRefreshingBlock:^{
        [weakself loadIsMore:NO];
    }];
    header.stateLabel.textColor = [UIColor baseColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor baseColor];
    header.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    self.tableView.mj_header = header;
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself loadIsMore:YES];
    }];
    footer.stateLabel.textColor = [UIColor baseColor];
    footer.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    self.tableView.mj_footer = footer;
    self.tableView.mj_footer.automaticallyChangeAlpha = YES;
//    self.tableView.mj_footer.automaticallyHidden = YES;
    
    
//    [self.tableView.mj_header beginRefreshing];
}


// 内部方法
- (void)loadIsMore:(BOOL)isMore
{
    // 控制只能下拉或者上拉
    if (isMore) {
        ![self.tableView.mj_header isRefreshing] ?: [self.tableView.mj_header endRefreshing];
    }else
    {
        ![self.tableView.mj_footer isRefreshing] ?: [self.tableView.mj_footer endRefreshing];
    }
    [self loadMore:isMore];
}

// 结束刷新
- (void)endHeaderFooterRefreshing
{
    NSLog(@"tableview----------------endHeaderFooterRefreshing");
    // 结束刷新状态
    ![self.tableView.mj_header isRefreshing] ?: [self.tableView.mj_header endRefreshing];
    ![self.tableView.mj_footer isRefreshing] ?: [self.tableView.mj_footer endRefreshing];
    
}

// 子类需要调用调用
- (void)loadMore:(BOOL)isMore
{
    //        NSAssert(0, @"子类必须重载%s", __FUNCTION__);
}


@end











