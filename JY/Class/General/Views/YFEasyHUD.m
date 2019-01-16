//
//  YFEasyHUD.m
//  BabyWatcher
//
//  Created by YesterdayFinder on 16/2/21.
//  Copyright © 2016年 Bruce. All rights reserved.
//

#import "YFEasyHUD.h"

static MBProgressHUD *_hud;

@implementation YFEasyHUD

+ (void)showIndicator {
    [self showIndicatorViewWithMsg:@""];
}

+ (void)showIndicatorAddedTo:(UIViewController *)controller {
    [_hud hideAnimated:YES];
    _hud = nil;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:controller.view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    _hud = hud;
}

+ (void)showIndicatorWithDelay:(NSTimeInterval)delay {
    [_hud hideAnimated:YES];
    _hud = nil;
    MBProgressHUD *hud = [self createHUD];
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:delay];
}

+ (void)showIndicatorWithDefaultDelay {
    [self showIndicatorWithDelay:YFHUD_DEFAULT_DELAY];
}

+ (void)showIndicatorViewWithMsg:(NSString *)msg {
    [self showIndicatorViewWithMsg:msg detail:@""];
}

+ (MBProgressHUD *)createHUD {
    return [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
}

+ (void)showIndicatorViewWithMsg:(NSString *)msg detail:(NSString *)detail {
    [_hud hideAnimated:YES];
    _hud = nil;
    MBProgressHUD *hud = [self createHUD];
    hud.label.text = msg;
    hud.detailsLabel.text = detail;
    hud.removeFromSuperViewOnHide = YES;
    _hud = hud;
}

+ (void)showMsg:(NSString *)msg {
    [_hud hideAnimated:YES];
    _hud = nil;
    MBProgressHUD *hud = [self createHUD];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = msg;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    _hud = hud;
}

+ (void)showMsg:(NSString *)msg details:(NSString *)details {
    [self showMsg:msg details:details lastTime:YFHUD_DEFAULT_DELAY];
}

+ (void)showMsg:(NSString *)msg lastTime:(NSTimeInterval)delay {
    [self showMsg:msg details:@"" lastTime:delay];
}

+ (void)showMsg:(NSString *)msg details:(NSString *)details lastTime:(NSTimeInterval)delay {
    [_hud hideAnimated:YES];
    _hud = nil;
    MBProgressHUD *hud = [self createHUD];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = msg;
    hud.detailsLabel.text = details;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:delay];
}

+ (void)showMsgWithDefaultDelay:(NSString *)msg {
    [_hud hideAnimated:YES];
    _hud = nil;
    MBProgressHUD *hud = [self createHUD];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = msg;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:YFHUD_DEFAULT_DELAY];
}

+ (void)hideHud {
    if (_hud) {
        [_hud hideAnimated:YES];
        _hud = nil;
    }
}

@end
