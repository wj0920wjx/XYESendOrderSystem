//
//  UtilsMacro.h
//  JY
//
//  Created by 王杰 on 2018/7/3.
//  Copyright © 2018年 飞鱼旅行. All rights reserved.
//

#ifndef UtilsMacro_h
#define UtilsMacro_h

#define BG_COLOR [UIColor colorWithHexString:@"56b8ff"]

//分割线颜色
#define LINE_COLOR [UIColor colorWithHexString:@"eeeeee"]
//价格颜色
#define PRICE_COLOR [UIColor colorWithHexString:@"ff4571"]
#define PRICE_COLOR2 [UIColor colorWithHexString:@"FC4F1E"]
//文字颜色
#define THREE_COLOR [UIColor colorWithHexString:@"333333"]
// 标准蓝
#define TINT_COLOR [UIColor colorWithHexString:@"0093fd"]
//边框基本颜色
#define BORDER_COLOR [UIColor colorWithHexString:@"DADFE2"]
// 渐变结束颜色
#define GRADUAL_END_COLOR [UIColor colorWithHexString:@"724ff6"]
#define COLOR_f3f3f3 [UIColor colorWithHexString:@"f3f3f3"]
#define COLOR_cccccc [UIColor colorWithHexString:@"cccccc"]
#define COLOR_ffffff [UIColor colorWithHexString:@"ffffff"]
#define TEXT_COLOR [UIColor colorWithHexString:@"3c4145"]
#define TEXT_COLOR_44 [UIColor colorWithHexString:@"3c4144"]
#define TEXT_COLOR_Red [UIColor colorWithHexString:@"#FF4E00"]

#pragma mark - UIColor宏定义
#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

#define UIColorFromRGB(rgbValue) UIColorFromRGBA(rgbValue, 1.0)

//
#define kPlaceholderAvatarImg [UIImage imageNamed:@"avatar_user"]
// 长方形的飞鱼图
#define kPlaceholder2To1Img [UIImage imageNamed:@"hPlaceholder@2t1"]
// 正方的飞鱼图
#define kPlaceholder1To1Img     [UIImage imageNamed:@"sPlaceholder@1t1"]

/**
 调用一个block,会判断block不为空
 */
#define BlockCallWithOneArg(block,arg)  if(block){block(arg);}

#define LocalizedString(x) NSLocalizedString(x, nil)

#define FYHTTPTOOL [LMJRequestManager sharedManager]

#define IsEmptyStr(str) ((str == nil) || [str isKindOfClass:[NSNull class]] || [str isEqualToString:@""]) //字符串为空

#endif /* UtilsMacro_h */
