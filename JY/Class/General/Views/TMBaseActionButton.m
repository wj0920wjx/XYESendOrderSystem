//
//  TMBaseActionButton.m
//  TravelMaster
//
//  Created by aodaguoji on 2017/12/5.
//  Copyright © 2017年 遨游大师. All rights reserved.
//

#import "TMBaseActionButton.h"

@interface TMBaseActionButton()
/**
 样式
 */
@property (nonatomic, assign) TMBaseActionButtonStyle style;


@end

@implementation TMBaseActionButton




- (instancetype)initWithTitle:(NSString *)title buttonStyle:(TMBaseActionButtonStyle)style {
    CGRect frame = CGRectMake(0, 0, kWidth(120), kWidth(40));
    self = [super initWithFrame:frame];
    if (self) {
        
        self.style = style;
        
        if (StringNotNullAndEmpty(title)) {
            [self setTitle:title forState:UIControlStateNormal];
            self.titleLabel.font = [UIFont systemFontOfSize:font(14) weight:UIFontWeightRegular];
        }
    }
    return self;
}

- (void)setStyle:(TMBaseActionButtonStyle)style {
    _style = style;
    if (style == TMBaseActionButtonStyleBlueText) {
        [self blueStyle];
    }else {
        [self WhiteStyle];
    }
}
- (void)jx_setTouchUpInsideBlock:(void (^)(UIButton *))touchUpInsideBlock {
    self.touchUpInsideBlock = touchUpInsideBlock;
}


- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
//    [self tm_gradientBackgroundColor:backgroundColor endColor:backgroundColor];
}

- (void)enableTitleColor:(UIColor *)color {
    [self setTitleColor:color forState:UIControlStateNormal];
}

- (void)enableBorderColor:(UIColor *)color {
    self.layer.borderColor = color.CGColor;
}


- (void)setTouchUpInsideBlock:(void (^)(UIButton *))touchUpInsideBlock {
    _touchUpInsideBlock = touchUpInsideBlock;
    [self addTarget:self action:@selector(selfToucUpInside) forControlEvents:UIControlEventTouchUpInside];
}

- (void)selfToucUpInside {
    BlockCallWithOneArg(self.touchUpInsideBlock, self);
}


- (void)WhiteStyle {
//    [self tm_gradientBackgroundColor:BG_COLOR endColor:UIColorFromRGB(0x724FF6)];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)blueStyle {
    [self setTitleColor:BG_COLOR forState:UIControlStateNormal];
    self.layer.borderWidth = 1;
    self.layer.borderColor = BG_COLOR.CGColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.cornerRadius = self.height / 2;
    self.layer.masksToBounds = YES;
}


- (void)setXibStyle:(int)xibStyle {
    self.style = xibStyle;
}
- (int)xibStyle {
    return self.style;
}

@end
