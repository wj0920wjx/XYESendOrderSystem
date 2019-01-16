//
//  TMGradientColorView.h
//  TravelMaster
//
//  Created by aodaguoji on 2017/12/11.
//  Copyright © 2017年 遨游大师. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMGradientColorView : UIView
/**
 开始颜色 默认FFFFFF
 */
@property (nonatomic, strong) UIColor *startColor;
/**
 结束颜色 默认000000
 */
@property (nonatomic, strong) UIColor *endColor;


//@property (nonatomic, assign) CGPoint starPoint;
//@property (nonatomic, assign) CGPoint endPoint;
@end
