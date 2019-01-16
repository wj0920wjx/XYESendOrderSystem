//
//  XYEAddOrderModel.h
//  JY
//
//  Created by 澳达国际 on 2019/1/11.
//  Copyright © 2019 飞鱼旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class XYEDirverInfoModel;
@class XYENoteModel;
@interface XYEAddOrderModel : NSObject

@property (nonatomic, strong) NSString *channel;
@property (nonatomic, strong) NSString *order_title;
@property (nonatomic, strong) NSString *channel_number;
@property (nonatomic, strong) NSString *client_name;
@property (nonatomic, strong) NSString *client_phone;
@property (nonatomic, strong) NSString *client_wx;
@property (nonatomic, strong) NSString *client_ww;
@property (nonatomic, strong) NSString *order_type;
@property (nonatomic, strong) NSString *fish_cost;
@property (nonatomic, strong) NSString *platform_cost;
@property (nonatomic, strong) NSString *local_cost;
@property (nonatomic, strong) NSString *plan_id;
@property (nonatomic, strong) NSString *start_time;
@property (nonatomic, strong) NSString *end_time;
@property (nonatomic, strong) NSString *ground_name;
@property (nonatomic, strong) NSString *ground_num;//
@property (nonatomic, strong) NSString *ground_name_num;

@property (nonatomic, strong) NSString *car;
@property (nonatomic, strong) NSString *car_suf;
@property (nonatomic, strong) NSString *adult;
@property (nonatomic, strong) NSString *child;
@property (nonatomic, strong) NSString *luggage;
@property (nonatomic, strong) NSString *childSeat;
@property (nonatomic, strong) NSString *airport_name;
@property (nonatomic, strong) NSString *flight_num;

/**
 接机
 */
@property (nonatomic, strong) NSString *delivered_site;

/**
 送机
 */
@property (nonatomic, strong) NSString *depart_site;

/**
 包车
 */
@property (nonatomic, strong) NSString *car_day;

//行程路线
@property (nonatomic, strong) NSString *car_stroke;


//单程接送
//民宿信息
@property (nonatomic, strong) NSString *homestay;
@property (nonatomic, strong) NSString *homestay_pop;
@property (nonatomic, strong) NSString *homestay_apartment;

//特色玩法
@property (nonatomic, strong) NSString *featureIntroduction;

@property (nonatomic, strong) NSString *order_country;
;
@property (nonatomic, strong) NSString *order_city;

/**
 备注信息
 */
@property (nonatomic, strong) NSString *order_notes;

/**
 订单详情
 */
@property (nonatomic, strong) NSString *additional_note;
@property (nonatomic, strong) NSString *ceo_audit_state;
@property (nonatomic, strong) NSString *ceo_name;
@property (nonatomic, strong) NSString *ceo_state;
@property (nonatomic, strong) NSString *ceo_time;
@property (nonatomic, strong) NSString *created_at;
@property (nonatomic, strong) NSString *follow_conversion;
@property (nonatomic, strong) NSString *follow_craise;
@property (nonatomic, strong) NSString *follow_in;
@property (nonatomic, strong) NSString *follow_rear;
@property (nonatomic, strong) NSString *give_motorman;
@property (nonatomic, strong) NSString *give_wx;
//id
@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *kf_creator;
@property (nonatomic, strong) NSString *manual_update;
@property (nonatomic, strong) NSMutableArray <XYENoteModel *>*note_list;
@property (nonatomic, strong) NSString *order_id;
@property (nonatomic, strong) NSString *order_no;
@property (nonatomic, strong) NSString *order_service_id;
@property (nonatomic, strong) NSString *order_state;
@property (nonatomic, strong) NSString *plan_complete_time;
@property (nonatomic, strong) NSString *plan_nick_name;
@property (nonatomic, strong) NSString *plan_receive_time;
@property (nonatomic, strong) NSString *principal_name;
@property (nonatomic, strong) NSString *principal_time;
@property (nonatomic, strong) NSString *principal_twice_name;
@property (nonatomic, strong) NSString *principal_twice_state;
@property (nonatomic, strong) NSString *principal_twice_time;
@property (nonatomic, strong) NSString *reason_cancel;
@property (nonatomic, strong) NSString *reason_cancel_name;
@property (nonatomic, strong) NSString *reason_cancel_time;
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, strong) NSString *trash_mark;
@property (nonatomic, strong) NSString *updated_at;
@property (nonatomic, strong) NSString *visit_mark;

@property (nonatomic, strong) XYEDirverInfoModel *driver_info;

@end

@interface XYEDirverInfoModel : NSObject

@property (nonatomic, strong) NSString *created_at;
@property (nonatomic, strong) NSString *driver_car_age;
@property (nonatomic, strong) NSString *driver_car_license;
@property (nonatomic, strong) NSString *driver_car_model;
@property (nonatomic, strong) NSString *driver_city;
@property (nonatomic, strong) NSString *driver_country;
@property (nonatomic, strong) NSString *driver_driving_license;
@property (nonatomic, strong) NSString *driver_group;
@property (nonatomic, strong) NSString *driver_license_type;
@property (nonatomic, strong) NSString *driver_insurance;
@property (nonatomic, strong) NSString *driver_mileage;
@property (nonatomic, strong) NSString *driver_name;
@property (nonatomic, strong) NSString *driver_phone;
@property (nonatomic, strong) NSString *driver_photos;
@property (nonatomic, strong) NSString *driver_sex;
@property (nonatomic, strong) NSString *driver_status;
@property (nonatomic, strong) NSString *driver_vehicle_travel_license;
@property (nonatomic, strong) NSString *driver_weixin;
@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *updated_at;

@end

@interface XYENoteModel : NSObject

@property (nonatomic, strong) NSString *admin_name;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *created_at;

@end

NS_ASSUME_NONNULL_END
