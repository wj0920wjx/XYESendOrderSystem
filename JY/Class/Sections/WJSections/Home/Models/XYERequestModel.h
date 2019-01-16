//
//  XYERequestModel.h
//  JY
//
//  Created by 澳达国际 on 2019/1/9.
//  Copyright © 2019 飞鱼旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYERequestModel : NSObject

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger limit;

/**
 订单ID
 */
@property (nonatomic, strong) NSString *order_id;

/**
 订单类型
 */
@property (nonatomic, strong) NSString *order_type;

/**
 订单标题
 */
@property (nonatomic, strong) NSString *order_title;

/**
 飞鱼ID
 */
@property (nonatomic, strong) NSString *plan_id;

/**
 飞鱼昵称
 */
@property (nonatomic, strong) NSString *plan_nick_name;

/**
 客户名称
 */
@property (nonatomic, strong) NSString *client_name;

/**
 客户手机号码
 */
@property (nonatomic, strong) NSString *client_phone;

/**
 客户微信
 */
@property (nonatomic, strong) NSString *client_wx;

/**
 渠道编号
 */
@property (nonatomic, strong) NSString *channel_number;

/**
 客服名称
 */
@property (nonatomic, strong) NSString *kf_creator;

/**
 地接编号
 */
@property (nonatomic, strong) NSString *ground_name_num;

/**
 开始时间
 */
@property (nonatomic, strong) NSString *start_time;

/**
 服务结束时间
 */
@property (nonatomic, strong) NSString *end_time;

/**
 状态：1未派单2待接单3服务中4结算中5已完成6已取消7结算中：主管待审核 8结算中CEO待审核 9已取消：未派单10已取消：已派单
 */
@property (nonatomic, strong) NSString *choose_type;

/**
 国家
 */
@property (nonatomic, strong) NSString *order_country;

/**
 城市
 */
@property (nonatomic, strong) NSString *order_city;

/**
 已取消订单处理标记  0 全部 1未标记 2已标记
 */
@property (nonatomic, strong) NSString *trash_mark;

/**
 0 默认添加顺序  1 服务开始时间正序  2 服务开始时间倒序  3派单开始时间正序  4派单开始时间倒序
 */
@property (nonatomic, strong) NSString *sequence;

@property (nonatomic, strong) NSString *principal_ktime;
@property (nonatomic, strong) NSString *principal_etime;
@property (nonatomic, strong) NSString *created_at_ktime;
@property (nonatomic, strong) NSString *created_at_etime;

@end

NS_ASSUME_NONNULL_END
