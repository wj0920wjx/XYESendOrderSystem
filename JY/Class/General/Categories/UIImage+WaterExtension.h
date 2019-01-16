//
//  UIImage+WaterExtension.h
//  JY
//
//  Created by 澳达国际 on 2018/11/1.
//  Copyright © 2018 飞鱼旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (WaterExtension)

+ (UIImage *)jx_WaterImageWithImage:(UIImage *)image waterImage:(UIImage *)waterImage waterImageRect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
