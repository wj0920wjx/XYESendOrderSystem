//
//  LMJAutoRefreshFooter.m
//  PLMMPRJK
//
//  Created by 王杰 on 2017/4/11.
//  Copyright © 2018年 飞鱼旅行. All rights reserved.
//

#import "LMJAutoRefreshFooter.h"

@implementation LMJAutoRefreshFooter

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUIOnce];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUIOnce];
}

- (void)setupUIOnce
{
    self.automaticallyChangeAlpha = YES;
//    self.automaticallyHidden = YES;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

@end
