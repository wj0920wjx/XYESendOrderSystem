//
//  LMJTableViewController.h
//  PLMMPRJK
//
//  Created by 王杰 on 2017/4/11.
//  Copyright © 2018年 飞鱼旅行. All rights reserved.
//

#import "LMJBaseViewController.h"

@interface LMJTableViewController : LMJBaseViewController<UITableViewDelegate, UITableViewDataSource>

// 这个代理方法如果子类实现了, 必须调用super
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView NS_REQUIRES_SUPER;

/** <#digest#> */
@property (weak, nonatomic) UITableView *tableView;

// tableview的样式, 默认plain
- (instancetype)initWithStyle:(UITableViewStyle)style;

@end
