//
//  LMJEasyBlankPageView.h
//  iOSProject
//
//  Created by 王杰 on 2017/12/29.
//  Copyright © 2017年 王杰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LMJEasyBlankPageViewTypeNoData,
    LMJEasyBlankPageViewTypeAuthority
} LMJEasyBlankPageViewType;

@interface LMJEasyBlankPageView : UIView
- (void)configWithType:(LMJEasyBlankPageViewType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(UIButton *sender))block;
@end


@interface UIView (LMJConfigBlank)
- (void)configBlankPage:(LMJEasyBlankPageViewType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block;
@end
