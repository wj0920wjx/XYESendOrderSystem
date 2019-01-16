//
//  UILabel+Extension.h
//  趣呀
//
//  Created by 闫闫冬云 on 2017/9/2.
//  Copyright © 2017年 huizhaodao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (DYExtension)

/**
 *修改label.text 颜色
 */
-(void)dyChangeColor:(UIColor*)color RangeText:(NSString*)rangeStr;
/**
 *修改label.text字体 大小
 */
-(void)dyChangeFont:(CGFloat)font RangeText:(NSString *)rangeStr;
/**
 *修改label.text的字体 大小 + 加粗
 */
-(void)dyChangeFont:(CGFloat)font fontWidth:(CGFloat)width RangeText:(NSString *)rangeStr;
/**
 *修改label.text字体 大小 + 颜色
 */
-(void)dyChangeFont:(CGFloat)font color:(UIColor*)color RangeText:(NSString *)rangeStr;
/**
 *获得label.text 高度
 */
- (CGFloat)dyGetHeightByWidth:(CGFloat)width title:(NSString *)title font:(CGFloat)fontSize;
/**
 *修改label.text 宽度
 */
- (CGFloat)dyGetWidthWithTitle:(NSString *)title font:(CGFloat)fontSize;
/**
 *  改变行间距
 */
- (void)dyChangeLineWithSpace:(float)space;

/**
 *  改变字间距
 */
- (void)dyChangeWordWithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
- (void)dyChangeSpaceWithLineSpace:(float)lineSpace WordSpace:(float)wordSpace;


@end
