//
//  AppDelegate.m
//  JY
//
//  Created by 王杰 on 2018/6/14.
//  Copyright © 2018年 飞鱼旅行. All rights reserved.
//

#import "JYAppDelegate.h"
//#import <NIMSDK/NIMSDK.h>
// 引入 JPush 功能所需头文件
#import "TMServerConfig.h"
#import "LMJIntroductoryPagesHelper.h"
#import "XYELoginViewController.h"
#import "HomeViewController.h"

// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#ifdef DEBUG
#define CHANNEL @"Development"
#define APSForProduction NO

#else
#define CHANNEL @"App Store"
#define APSForProduction YES

#endif

#define LAST_RUN_VERSION_KEY @"last_run_version_of_application"

// 后台版本号标示
//#define kAppVersionAlias @"100"


@interface JYAppDelegate ()

@end

@implementation JYAppDelegate

- (UIWindow *)window
{
    if(!_window)
    {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _window.backgroundColor = [UIColor RandomColor];
        [_window makeKeyAndVisible];
    }
    return _window;
}

- (BOOL) isFirstLoad{
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastRunVersion = [defaults objectForKey:LAST_RUN_VERSION_KEY];
    if (!lastRunVersion) {
        [defaults setObject:currentVersion forKey:LAST_RUN_VERSION_KEY];
        return YES;
    }else if (![lastRunVersion isEqualToString:currentVersion]) {
        [defaults setObject:currentVersion forKey:LAST_RUN_VERSION_KEY];
        return YES;
        
    }return NO;
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    _fyTab = [[JYTabViewController alloc] init];
//    self.window.rootViewController = _fyTab;
    UIStoryboard *sd = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (![LTUserManager getUserInfo]) {
        XYELoginViewController *lvc = [sd instantiateViewControllerWithIdentifier:@"XYELoginViewController"];
        LMJNavigationController *nvc = [[LMJNavigationController alloc] initWithRootViewController:lvc];
        self.window.rootViewController = nvc;
    }
    else{
        [[LTUserManager sharedManager] mj_setKeyValues:[LTUserManager getUserInfo]];
        HomeViewController *hvc = [[HomeViewController alloc] initWithStyle:UITableViewStylePlain];
        LMJNavigationController *nvc = [[LMJNavigationController alloc] initWithRootViewController:hvc];
        self.window.rootViewController = nvc;
    }
    
    //在这个方法里输入如下清除方法
    [application setApplicationIconBadgeNumber:0]; //清除角标
    [[UIApplication sharedApplication] cancelAllLocalNotifications];//清除APP所有通知消息
    
    /** App判断第一次启动的方法 */
//    if ([self isFirstLoad]) {
//        [LMJIntroductoryPagesHelper showIntroductoryPageView:@[@"guide1.jpg", @"guide2.jpg", @"guide3.jpg"]];
//    } else {
//
//        NSLog(@"不是第一次登录");
//    }
    
#ifdef DEBUG
    
    [FYConst sharedConfig].serverType = TMServerTypeProductionTest;
    //TMServerTypeProductionTest

#else
    
    [FYConst sharedConfig].serverType = TMServerTypeProductionOfficial;

#endif
    
    [TMServerConfig sharedConfig].serverType = [FYConst sharedConfig].serverType;
    return YES;
}

-(void)checkUpdate{
    [FYHTTPTOOL upload:FY_UPDATEVERSION parameters:@{@"version_platform":@"1"} formDataBlock:^(id<AFMultipartFormData> formData) {
    } progress:^(NSProgress *progress) {
        
    } completion:^(LMJBaseResponse *response) {
        if (response.code == 10001) {
        }
        else{
            
        }
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"%@",error);
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
