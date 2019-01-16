//
//  XYEAddOrderViewController.h
//  JY
//
//  Created by 澳达国际 on 2019/1/11.
//  Copyright © 2019 飞鱼旅行. All rights reserved.
//

#import "LMJBaseViewController.h"
#import "XYEAddOrderModel.h"

typedef NS_ENUM(NSUInteger, EditType) {
    defaultType = 0, //添加接口
    updateType,
    resetCommitType,
};

NS_ASSUME_NONNULL_BEGIN

@interface XYEAddOrderViewController : LMJBaseViewController

@property (nonatomic, strong) XYEAddOrderModel *model;

@property (nonatomic, assign) EditType type;

@end

NS_ASSUME_NONNULL_END
