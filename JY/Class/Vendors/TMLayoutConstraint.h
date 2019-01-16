//
//  TMLayoutConstraint.h
//  TravelMaster
//
//  Created by aodaguoji on 2017/10/17.
//  Copyright © 2017年 遨游大师. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Standard_width 375
#define Standard_hight 667
#define Screen_width [UIScreen mainScreen].bounds.size.width
#define Screen_height [UIScreen mainScreen].bounds.size.height
#define Ratio_width (Screen_width/Standard_width)
#define Ratio_height (Screen_height/Standard_hight)

//typedef enum : NSUInteger {
//    TMLayoutConstraintWidthScale = 0, //根据宽度缩放
//    TMLayoutConstraintHeightScale = 1, // 根据高度缩放
//} TMLayoutConstraintSytle;

IB_DESIGNABLE
@interface TMLayoutConstraint : NSLayoutConstraint
/**
 比例样式 默认为根据宽度缩放
 */
@property (nonatomic, assign) IBInspectable BOOL isHeightScale;



@end
