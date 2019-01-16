//
//  UILabel+Extension.m
//  趣呀
//
//  Created by 闫闫冬云 on 2017/9/2.
//  Copyright © 2017年 huizhaodao. All rights reserved.
//

#import "UILabel+DYExtension.h"

@implementation UILabel (DYExtension)
-(void)dyChangeColor:(UIColor*)color RangeText:(NSString*)rangeStr {
    if (!(color&&self.text&&self.text.length>0.0&&rangeStr&&rangeStr.length>0.0)) {
        return;
    }
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSRange Range = NSMakeRange([[noteStr string] rangeOfString:rangeStr].location, [[noteStr string] rangeOfString:rangeStr].length);
    //需要设置的位置
    [noteStr addAttribute:NSForegroundColorAttributeName value:color range:Range];
    //设置颜色
    [self setAttributedText:noteStr];
}
-(void)dyChangeFont:(CGFloat)font RangeText:(NSString *)rangeStr {
    if (!(font&&self.text&&self.text.length>0.0&&rangeStr&&rangeStr.length>0.0)) {
        return;
    }
    //label  需要操作的Label
    //font   该字符的字号
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSRange stringRange = NSMakeRange([[noteStr string] rangeOfString:rangeStr].location, [[noteStr string] rangeOfString:rangeStr].length); //该字符串的位置
    [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:stringRange];
    [self setAttributedText: noteStr];
}
-(void)dyChangeFont:(CGFloat)font fontWidth:(CGFloat)width RangeText:(NSString *)rangeStr{
    if (!(font&&self.text&&self.text.length>0.0&&rangeStr&&rangeStr.length>0.0&&width)) {
        return;
    }
    //label  需要操作的Label
    //font   该字符的字号
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSRange stringRange = NSMakeRange([[noteStr string] rangeOfString:rangeStr].location, [[noteStr string] rangeOfString:rangeStr].length); //该字符串的位置
    [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font weight:width] range:stringRange];
    [self setAttributedText: noteStr];

}
-(void)dyChangeFont:(CGFloat)font color:(UIColor*)color RangeText:(NSString *)rangeStr{
    if (!(color&&font&&self.text&&self.text.length>0.0&&rangeStr&&rangeStr.length>0.0)) {
        return;
    }
    //label  需要操作的Label
    //font   该字符的字号
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSRange stringRange = NSMakeRange([[noteStr string] rangeOfString:rangeStr].location, [[noteStr string] rangeOfString:rangeStr].length); //该字符串的位置
    [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:stringRange];
    [noteStr addAttribute:NSForegroundColorAttributeName value:color range:stringRange];
    [self setAttributedText: noteStr];
    
    
}
- (CGFloat)dyGetHeightByWidth:(CGFloat)width title:(NSString *)title font:(CGFloat)fontSize
{
    if (!(width&&title.length&&fontSize)) {
        return 0;
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}

- (CGFloat)dyGetWidthWithTitle:(NSString *)title font:(CGFloat)fontSize {
    if (!(title.length&&fontSize)) {
        return 0;
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = [UIFont systemFontOfSize:fontSize];
    [label sizeToFit];
    return label.frame.size.width+5;
}

- (void)dyChangeLineWithSpace:(float)space {
    
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    
    self.attributedText = attributedString;
    [self sizeToFit];
    
}

- (void)dyChangeWordWithSpace:(float)space {
    
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
    [self sizeToFit];
    
}

- (void)dyChangeWithLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
    [self sizeToFit];
    
}

@end
