//
//  YFEasyHUD.h
//  BabyWatcher
//
//  Created by YesterdayFinder on 16/2/21.
//  Copyright © 2016年 Bruce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

#define YFHUD_DEFAULT_DELAY 1.5

@interface YFEasyHUD : NSObject

+ (void)showIndicator;

+ (void)showIndicatorAddedTo:(UIViewController *)controller;

+ (void)showIndicatorWithDelay:(NSTimeInterval)delay;

+ (void)showIndicatorWithDefaultDelay;

+ (void)showIndicatorViewWithMsg:(NSString *)msg;

+ (void)showIndicatorViewWithMsg:(NSString *)msg detail:(NSString *)detail;

+ (void)showMsg:(NSString *)msg;

+ (void)showMsgWithDefaultDelay:(NSString *)msg;

+ (void)showMsg:(NSString *)msg details:(NSString *)details;
    
+ (void)showMsg:(NSString *)msg lastTime:(NSTimeInterval)delay;

+ (void)showMsg:(NSString *)msg details:(NSString *)details lastTime:(NSTimeInterval)delay;

+ (void)hideHud;

@end
