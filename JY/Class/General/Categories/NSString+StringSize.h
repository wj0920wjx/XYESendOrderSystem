//
//  NSString+StringSize.h
//  TravelMaster
//
//  Created by 飞鱼之家 on 16/9/22.
//  Copyright © 2016年 飞鱼之家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringSize)
/**
 *  简单计算textsize
 *
 *  @param width 传入特定的宽度
 *  @param font  字体
 */
- (CGSize)sizeWithLabelWidth:(CGFloat)width font:(UIFont *)font;


/**
 计算attr高度

 @param lineSpeace 间距
 @param font 字体大小
 @param width 宽度
 @return 高度
 */
-(CGFloat)heightWithSpeace:(CGFloat)lineSpeace withFont:(UIFont*)font withWidth:(CGFloat)width;

-(CGFloat)heightWithParagraph:(NSMutableParagraphStyle *)paragraph withFont:(UIFont*)font withWidth:(CGFloat)width;
/**
 计算字符串字符数
 */
-(NSUInteger)textLength: (NSString *) text;
@end
