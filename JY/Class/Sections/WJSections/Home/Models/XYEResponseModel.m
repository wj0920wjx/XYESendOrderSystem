//
//  XYEResponseModel.m
//  JY
//
//  Created by 澳达国际 on 2019/1/9.
//  Copyright © 2019 飞鱼旅行. All rights reserved.
//

#import "XYEResponseModel.h"

@implementation XYEResponseModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"list" : [XYEResponseSubModel class]};
}

@end

@implementation XYEResponseSubModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"Id" : @"id"
             };
}

@end
