//
//  UIColor+Extension.h
//  iTrends
//
//  Created by wujin on 12-6-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBAColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface UIColor (Extension)

+ (UIColor *) colorWithHexString: (NSString *) hexString;
+(UIColor *)colorWithHexString: (NSString *) hexString alpha:(CGFloat)alpha;
+ (NSString*) stringWithColor:(UIColor*)color;
+ (UIColor*)baseGreyColor;
+ (UIColor*)textColor;
+ (UIColor*)baseColor;
+ (UIColor*)baseRedColor;
+ (UIColor*)shadowColor;
+ (UIColor*)maskColor;
+ (UIColor*)baseGreenColor;
+ (UIColor*)baseyelloColor;
-(BOOL)isEqualToColor:(UIColor*)color;

@end
