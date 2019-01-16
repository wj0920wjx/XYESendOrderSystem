//
//  GroundNumList.m
//  JY
//
//  Created by 澳达国际 on 2019/1/11.
//  Copyright © 2019 飞鱼旅行. All rights reserved.
//

#import "GroundNumList.h"

@implementation GroundNumList

+(NSDictionary *)mj_objectClassInArray{
    return @{@"list" : [GroundNumSubList class]};
}

@end

@implementation GroundNumSubList

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"Id":@"id"
             };
}

@end
