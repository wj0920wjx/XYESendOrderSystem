//
//  LMJRequestBaseViewController.h
//  PLMMPRJK
//
//  Created by 王杰 on 2017/4/24.
//  Copyright © 2018年 飞鱼旅行. All rights reserved.
//

#import "LMJTextViewController.h"
#import "Reachability.h"

@class LMJRequestBaseViewController;
@protocol LMJRequestBaseViewControllerDelegate <NSObject>

@optional
#pragma mark - 网络监听
/*
 NotReachable = 0,
 ReachableViaWiFi = 2,
 ReachableViaWWAN = 1,
 ReachableVia2G = 3,
 ReachableVia3G = 4,
 ReachableVia4G = 5,
 */
- (void)networkStatus:(NetworkStatus)networkStatus inViewController:(LMJRequestBaseViewController *)inViewController;

@end



@interface LMJRequestBaseViewController : LMJTextViewController<LMJRequestBaseViewControllerDelegate>

#pragma mark - 加载框
- (void)showLoading;

- (void)dismissLoading;

@end
