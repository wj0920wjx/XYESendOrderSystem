//
//  XYECountryModel.m
//  JY
//
//  Created by 澳达国际 on 2019/1/10.
//  Copyright © 2019 飞鱼旅行. All rights reserved.
//

#import "XYECountryModel.h"

@implementation XYECountryModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.list = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

+(NSDictionary *)mj_objectClassInArray{
    return @{@"list" : [XYECityModel class]};
}

@end

@implementation XYECityModel

@end
