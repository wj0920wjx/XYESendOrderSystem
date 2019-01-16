//
//  LMJRefreshTableViewController.h
//  PLMMPRJK
//
//  Created by 王杰 on 2017/4/11.
//  Copyright © 2018年 飞鱼旅行. All rights reserved.
//

#import "LMJTableViewController.h"
#import "LMJAutoRefreshFooter.h"
#import "LMJNormalRefreshHeader.h"

@interface LMJRefreshTableViewController : LMJTableViewController

- (void)loadMore:(BOOL)isMore;


// 结束刷新, 子类请求报文完毕调用
- (void)endHeaderFooterRefreshing;

@end
