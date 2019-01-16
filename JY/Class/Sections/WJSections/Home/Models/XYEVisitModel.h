//
//  XYEVisitModel.h
//  JY
//
//  Created by 澳达国际 on 2019/1/16.
//  Copyright © 2019 飞鱼旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class XYEVisitSubModel;
@interface XYEVisitModel : NSObject

@property (nonatomic, strong) NSMutableArray <XYEVisitSubModel *>*list;

@end

@interface XYEVisitSubModel : NSObject

@property (nonatomic, strong) NSString *admin_name;
@property (nonatomic, strong) NSString *created_at;
@property (nonatomic, strong) NSString *text;

@end

NS_ASSUME_NONNULL_END
