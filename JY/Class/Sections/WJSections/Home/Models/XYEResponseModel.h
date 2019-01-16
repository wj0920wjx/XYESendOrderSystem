//
//  XYEResponseModel.h
//  JY
//
//  Created by 澳达国际 on 2019/1/9.
//  Copyright © 2019 飞鱼旅行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYECostModel.h"

NS_ASSUME_NONNULL_BEGIN

@class XYEResponseSubModel;
@interface XYEResponseModel : NSObject

/**
 价格
 */
@property (nonatomic, strong) XYECostModel *cost_list;

@property (nonatomic, strong) NSMutableArray<XYEResponseSubModel *> *list;

/**
 限制数量
 */
@property (nonatomic, assign) NSInteger limit;

/**
 页码
 */
@property (nonatomic, assign) NSInteger page;

/**
 总条数
 */
@property (nonatomic, assign) NSInteger total;

@end

//价格
@interface XYEResponseSubModel : NSObject

@property (nonatomic, strong) NSString *additional_note;
@property (nonatomic, strong) NSString *car;
@property (nonatomic, strong) NSString *car_suf;
@property (nonatomic, strong) NSString *ceo_audit_state;
@property (nonatomic, strong) NSString *ceo_name;
@property (nonatomic, strong) NSString *ceo_state;
@property (nonatomic, strong) NSString *ceo_time;
@property (nonatomic, strong) NSString *channel;
@property (nonatomic, strong) NSString *channel_name;
@property (nonatomic, strong) NSString *channel_number;
@property (nonatomic, strong) NSString *client_name;
@property (nonatomic, strong) NSString *client_phone;
@property (nonatomic, strong) NSString *client_ww;
@property (nonatomic, strong) NSString *client_wx;
@property (nonatomic, strong) NSString *created_at;
@property (nonatomic, strong) NSString *end_time;
@property (nonatomic, strong) NSString *fish_cost;
@property (nonatomic, strong) NSString *follow_conversion;
@property (nonatomic, strong) NSString *follow_craise;
@property (nonatomic, strong) NSString *follow_in;
@property (nonatomic, strong) NSString *follow_rear;
@property (nonatomic, strong) NSString *give_motorman;
@property (nonatomic, strong) NSString *give_wx;
@property (nonatomic, strong) NSString *ground_name;
@property (nonatomic, strong) NSString *ground_name_num;
@property (nonatomic, strong) NSString *ground_num;
@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *kf_creator;
@property (nonatomic, strong) NSString *local_cost;
@property (nonatomic, strong) NSString *manual_update;
@property (nonatomic, strong) NSString *order_city;
@property (nonatomic, strong) NSString *order_country;
@property (nonatomic, strong) NSString *order_no;
@property (nonatomic, strong) NSString *order_notes;
@property (nonatomic, strong) NSString *order_service_id;
@property (nonatomic, strong) NSString *order_state;
@property (nonatomic, strong) NSString *order_state_name;
@property (nonatomic, strong) NSString *order_title;
@property (nonatomic, strong) NSString *order_type;
@property (nonatomic, strong) NSString *plan_complete_time;
@property (nonatomic, strong) NSString *plan_id;
@property (nonatomic, strong) NSString *plan_nick_name;
@property (nonatomic, strong) NSString *plan_receive_time;
@property (nonatomic, strong) NSString *platform_cost;
@property (nonatomic, strong) NSString *principal_name;
@property (nonatomic, strong) NSString *principal_time;
@property (nonatomic, strong) NSString *principal_twice_name;
@property (nonatomic, strong) NSString *principal_twice_state;
@property (nonatomic, strong) NSString *principal_twice_time;
@property (nonatomic, strong) NSString *reason_cancel;
@property (nonatomic, strong) NSString *reason_cancel_name;
@property (nonatomic, strong) NSString *reason_cancel_time;
@property (nonatomic, strong) NSString *start_time;
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, strong) NSString *trash_mark;
@property (nonatomic, strong) NSString *updated_at;
@property (nonatomic, strong) NSString *visit_mark;

@end


NS_ASSUME_NONNULL_END
