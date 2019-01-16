//
//  UIColor+Extension.m
//  iTrends
//
//  Created by wujin on 12-6-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

+(UIColor *)colorWithHexString: (NSString *) hexString alpha:(CGFloat)alpha{
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat  red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = alpha;
            red   = [self colorComponentFrom: colorString start: 0 length: 1 Case:1];
            green = [self colorComponentFrom: colorString start: 1 length: 1 Case:2];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1 Case:3];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1 Case:0];
            red   = [self colorComponentFrom: colorString start: 1 length: 1 Case:1];
            green = [self colorComponentFrom: colorString start: 2 length: 1 Case:2];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1 Case:3];
            break;
        case 6: // #RRGGBB
            alpha = alpha;
            red   = [self colorComponentFrom: colorString start: 0 length: 2 Case:1];
            green = [self colorComponentFrom: colorString start: 2 length: 2 Case:2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2 Case:3];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2 Case:0];
            red   = [self colorComponentFrom: colorString start: 2 length: 2 Case:1];
            green = [self colorComponentFrom: colorString start: 4 length: 2 Case:2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2 Case:3];
            break;
        default:
            return nil;
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];

}
+ (UIColor *) colorWithHexString: (NSString *) hexString {
    return [self colorWithHexString:hexString alpha:1.0f];
}

+(NSString*)stringWithColor:(UIColor *)color
{
    if (color==nil) {
        return @"";
    }
    
    CGFloat r,g,b,a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    
    //rgba
    return [NSString stringWithFormat:@"[%d,%d,%d,%f]",(int)(r*255),(int)(g*255),(int)(b*255),a];
}

+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length Case:(int) ARGB{
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    switch (ARGB) {
        case 0://alpha
            return hexComponent / 255.0;

            break;
        case 1://red
           
            return ( hexComponent )/ 255.0;

            break;
        case 2://green
            return (hexComponent)/ 255.0;
 
            break;
        case 3://blue
            return (hexComponent) / 255.0;
 
            break;
        default:
            break;
    }
    return 0;
}

+ (UIColor*)baseGreyColor{
    return [UIColor colorWithHexString:@"EFF2F4"];
}

+ (UIColor*)textColor{
    return [UIColor colorWithHexString:@"3c4145"];
}

+ (UIColor*)baseColor{
    return [UIColor colorWithHexString:@"0093fd"];
}

+ (UIColor*)baseRedColor{
    return [UIColor colorWithHexString:@"FF3202"];
}
+ (UIColor*)baseGreenColor{
    return RGBColor(29, 186, 90);
}
+ (UIColor*)baseyelloColor{
    return RGBColor(253, 130, 35);
}
+ (UIColor*)shadowColor{
    return [UIColor colorWithHexString:@"A8AAB5"];
}
+ (UIColor*)maskColor{
    return [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
}

//static let textColor = UIColor(hexString: "3c4145")!
//// app 主色调
//static let baseColor = UIColor(hexString: "0093fd")!
//// 基本灰
//static let baseGreyColor = UIColor(hexString: "EFF2F4")!
//
//// 基本阴影颜色
//static let shadowColor = UIColor(hexString: "A8AAB5", alpha: 1)
//// 基本遮罩颜色
//static let maskColor = UIColor(white: 0.5, alpha: 0.5)
//// 中度灰色
//static let mediumGreyColor = UIColor(hexString: "C8D1D8", alpha: 1)
////橙色
//static let orangeColor = UIColor(hexString: "C8D1D8", alpha: 1)


-(BOOL)isEqualToColor:(UIColor*)color{
    if(CGColorEqualToColor(self.CGColor, color.CGColor))
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

@end
