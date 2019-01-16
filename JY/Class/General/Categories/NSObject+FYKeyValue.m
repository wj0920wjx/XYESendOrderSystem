//
//  NSObject+FYKeyValue.m
//  JY
//
//  Created by 王杰 on 2018/9/14.
//  Copyright © 2018年 飞鱼旅行. All rights reserved.
//

#import "NSObject+FYKeyValue.h"

@implementation NSObject (FYKeyValue)

+ (instancetype)fy_objectWithKeyValues:(id)keyValues{
    return [self mj_objectWithKeyValues:keyValues];
}

@end
