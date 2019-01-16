//
//  TMBaseActionButton.h
//  TravelMaster
//
//  Created by aodaguoji on 2017/12/5.
//  Copyright © 2017年 遨游大师. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TMBaseActionButtonStyle) {
    TMBaseActionButtonStyleWhiteText = 0,
    TMBaseActionButtonStyleBlueText = 1,
};

typedef void(^JXButtonActionBlock)(UIButton *button);

IB_DESIGNABLE
@interface TMBaseActionButton : UIButton

- (instancetype)initWithTitle:(NSString *)title buttonStyle:(TMBaseActionButtonStyle)style;


@property (nonatomic,assign) IBInspectable int xibStyle;


/**
 点击回调
 */
@property (nonatomic, copy) JXButtonActionBlock touchUpInsideBlock;

- (void)jx_setTouchUpInsideBlock:(void (^)(UIButton *))touchUpInsideBlock;

- (void)enableTitleColor:(UIColor *)color;
- (void)enableBorderColor:(UIColor *)color;
- (void)setBackgroundColor:(UIColor *)backgroundColor;
@end
