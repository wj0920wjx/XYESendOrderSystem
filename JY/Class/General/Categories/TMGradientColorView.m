//
//  TMGradientColorView.m
//  TravelMaster
//
//  Created by aodaguoji on 2017/12/11.
//  Copyright © 2017年 遨游大师. All rights reserved.
//

#import "TMGradientColorView.h"

@interface TMGradientColorView()

/**
 <#Description#>
 */
@property (nonatomic, strong) CAGradientLayer *gradientLayer;


@end

@implementation TMGradientColorView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _startColor = [UIColor whiteColor];
        _endColor = [UIColor blackColor];
//        _starPoint = CGPointMake(0, 0);
//        _endPoint = CGPointMake(1.0, 0);
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (CAGradientLayer *)gradientLayer {
    if (_gradientLayer) {
        _gradientLayer.colors = @[(__bridge id)_startColor.CGColor,(__bridge id)_endColor.CGColor];
        return _gradientLayer;
    }
    _gradientLayer = [CAGradientLayer layer];
    _gradientLayer.startPoint = CGPointMake(0, 0);
    _gradientLayer.endPoint = CGPointMake(1.0, 0);
    [self.layer insertSublayer:_gradientLayer atIndex:0];
    return _gradientLayer;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.superview sendSubviewToBack:self];
    self.cornerRadius = self.superview.cornerRadius;
    self.clipsToBounds = YES;
    
}

- (void)drawRect:(CGRect)rect {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    //创建CGMutablePathRef
    CGMutablePathRef path = CGPathCreateMutable();
    
    //绘制Path
    CGRect newRect = CGRectMake(0, 0, rect.size.width, rect.size.height);
    CGPathAddRect(path, NULL, newRect);
    CGPathCloseSubpath(path);
    NSArray *colors = @[(__bridge id) _startColor.CGColor, (__bridge id) _endColor.CGColor];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    CGRect pathRect = CGPathGetBoundingBox(path);
    //具体方向可根据需求修改
    CGPoint startPoint = CGPointMake(CGRectGetMinX(pathRect), CGRectGetMidY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMaxX(pathRect), CGRectGetMidY(pathRect));
//    CGPoint startPoint = _starPoint;
//    CGPoint endPoint = _endPoint;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    CGPathRelease(path);
}


@end
