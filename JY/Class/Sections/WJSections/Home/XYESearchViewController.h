//
//  XYESearchViewController.h
//  JY
//
//  Created by 澳达国际 on 2019/1/10.
//  Copyright © 2019 飞鱼旅行. All rights reserved.
//

#import "LMJBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SearchDicBlock)(NSMutableDictionary *searchDic);

@interface XYESearchViewController : LMJBaseViewController

@property (nonatomic, copy)SearchDicBlock block;

/**
 搜索条件字典
 */
@property (nonatomic, strong) NSMutableDictionary *searchDic;

@end

NS_ASSUME_NONNULL_END
