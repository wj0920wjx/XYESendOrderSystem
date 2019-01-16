//
//  XYEPlanInfo.m
//  JY
//
//  Created by 澳达国际 on 2019/1/11.
//  Copyright © 2019 飞鱼旅行. All rights reserved.
//

#import "XYEPlanInfo.h"

@implementation XYEPlanInfo

+(NSDictionary *)mj_objectClassInArray{
    return @{@"list" : [PlanUserInfo class]};
}

@end
