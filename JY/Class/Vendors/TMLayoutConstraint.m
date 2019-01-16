//
//  TMLayoutConstraint.m
//  TravelMaster
//
//  Created by aodaguoji on 2017/10/17.
//  Copyright © 2017年 遨游大师. All rights reserved.
//

#import "TMLayoutConstraint.h"

@implementation TMLayoutConstraint


- (CGFloat)constant {
    if (self.isHeightScale) {
        return super.constant * Ratio_height;
    } else {
        return super.constant * Ratio_width;
    }
    
}

@end
