//
//  XYEPlanInfo.h
//  JY
//
//  Created by 澳达国际 on 2019/1/11.
//  Copyright © 2019 飞鱼旅行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlanUserInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYEPlanInfo : NSObject

@property (nonatomic, strong) NSMutableArray<PlanUserInfo *> *list;

@end

NS_ASSUME_NONNULL_END
