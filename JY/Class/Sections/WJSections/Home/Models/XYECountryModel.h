//
//  XYECountryModel.h
//  JY
//
//  Created by 澳达国际 on 2019/1/10.
//  Copyright © 2019 飞鱼旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class XYECityModel;
@interface XYECountryModel : NSObject

@property (nonatomic, strong) NSMutableArray<XYECityModel *> *list;

@end

@interface XYECityModel : NSObject

@property (nonatomic, strong) NSString *coun_id;
@property (nonatomic, strong) NSString *coun_name;

@end

NS_ASSUME_NONNULL_END
