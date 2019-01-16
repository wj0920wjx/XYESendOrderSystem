//
//  GroundNumList.h
//  JY
//
//  Created by 澳达国际 on 2019/1/11.
//  Copyright © 2019 飞鱼旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class GroundNumSubList;
@interface GroundNumList : NSObject

@property (nonatomic, strong) NSMutableArray<GroundNumSubList *> *list;

@end

@interface GroundNumSubList : NSObject

/**
 名称
 */
@property (nonatomic, strong) NSString *depict;

/**
 编号
 */
@property (nonatomic, strong) NSString *fleet;

/**
 ID
 */
@property (nonatomic, strong) NSString *Id;

@end

NS_ASSUME_NONNULL_END
