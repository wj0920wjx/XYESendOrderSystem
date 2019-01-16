//
//  PlanUserInfo.h
//  JY
//
//  Created by 澳达国际 on 2019/1/11.
//  Copyright © 2019 飞鱼旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlanUserInfo : NSObject
//头像
@property (nonatomic, strong) NSString *plan_avatar;
@property (nonatomic, strong) NSString *plan_city;
@property (nonatomic, strong) NSString *plan_country;
@property (nonatomic, strong) NSString *plan_id;
@property (nonatomic, strong) NSString *plan_nick_name;
@property (nonatomic, strong) NSString *plan_phone;

@end

NS_ASSUME_NONNULL_END
