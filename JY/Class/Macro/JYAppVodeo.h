//
//  JYAppVodeo.h
//  JY
//
//  Created by 王杰 on 2018/7/9.
//  Copyright © 2018年 飞鱼旅行. All rights reserved.
//

#ifndef JYAppVodeo_h
#define JYAppVodeo_h

#pragma mark -- 通知类宏定义 -- 收到通知
#define FYUPDATEORDERINFO @"FY_updateOrderInfo"

#pragma mark -- 通知类宏定义 -- 更新系统消息列表
#define FYUPDATESYSINFO @"FY_updateSysInfo"

#pragma mark -- 是否刷新订单
#define FYREFRESHORDER @"FY_Refresh"


#pragma mark -- 结构体
//进入app的状态
typedef enum : NSUInteger {
    FYFrontPush, //在前台状态收到推送通知
    FYBlockToFrontPush,//后台收到通知--点击打开app时到前台状态
} FYPushType;

/**
 需要加载的数据类型
 */
typedef enum : NSUInteger {
    
    //    0为全部，1为图片，2为段子，3为音频，4为视频
    JYTopicTypeAll = 0,
    JYTopicTypePicture = 1,
    JYTopicTypeWords = 2,
    JYTopicTypeVoice = 3,
    JYTopicTypeVideo = 4,
    
} JYTopicType;

typedef enum:NSInteger{
    TMServerTypeDevelopmentOfficial, //开发环境 正式服务器
    TMServerTypeDevelopmentTest, //开发环境 测试服务器
    TMServerTypeProductionOfficial, //生产环境 正式服务器 上传APPStore
    TMServerTypeProductionTest, //生产环境 测试服务器
} TMServerType;

//订单业务相关
typedef NS_ENUM(NSUInteger, MainOrderListType) {
    nomal = 0,
    mineOrderList,
};

typedef NS_ENUM(NSUInteger, OrderListType) {
    all            = 0, //全部
    waitConfirm    = 2,//待接单
    progress       = 3,//服务中
    waitClose      = 4,//待结算
    finish         = 5,//已结算
    cancel         = 6//取消
};

typedef NS_ENUM(NSUInteger, OrderListSorte) {
    serviceTime    = 1,//服务时间
    addTime        = 2//派单时间
};

typedef enum : NSUInteger {
    /** 民宿 */
    TMServiceTypeHomeStay,
    /** 包车 */
    TMServiceTypeCharteredCar,
    /** 接送机 */
    TMServiceTypeTransfer,
    /** 行程定制 */
    TMServiceTypeJourneyCustom,
    /** 线路游 */
    TMServiceTypeRoute,
} TMServiceType;

typedef enum : NSUInteger {
    /** 民宿 */
    TMProductTypeHomeStay = 1,
    /** 线路 */
    TMProductTypeRoute = 2,
    
} TMProductType;

typedef enum : NSUInteger {
    /** 0 待支付 */
    AFOrderStateWaitPay,
    /** 1 待飞鱼确认 */
    AFOrderStateAlreadyPay,
    /** 2 已取消 */
    AFOrderStateCancel,
    /** 3 飞鱼已确认*/
    AFOrderStateEnsure,
    /** 4 售后申请中 （已提交退款单待客服处理） */
    AFOrderStateRefunding,
    /** 5 已完成 */
    AFOrderStateComplete,
    /** 6 退款完成 */
    AFOrderStateRefundEnd,
} AFOrderState;

typedef enum : NSUInteger {
    AFAssignedServiceTypePick = 1, //接机
    AFAssignedServiceTypeGive = 2, // 送机
    AFAssignedServiceTypeCar = 3, // 包车
    AFAssignedServiceTypeOne = 4, // 单次用车
    AFAssignedServiceTypeHomestay = 5, // 民宿
    AFAssignedServiceTypeFeature = 6 // 特色玩法
} AFAssignedServiceType;

typedef enum : NSUInteger {
    AFAssignedServiceStateNone = 0, // 未派单
    AFAssignedServiceStateUnderway = 1, // 进行中
    AFAssignedServiceStateWait = 2, // 等待结算
    AFAssignedServiceStateFinish = 3, // 完成
    AFAssignedServiceStateDisputed = 4 // 维权中
} AFAssignedServiceState;

typedef enum : NSUInteger {
    AFAppOrderTypeStateWaitAccept = 2, // 待接单
    AFAppOrderTypeStateInService = 3, // 服务中
    AFAppOrderTypeStateInSettlement = 4, // 结算中
    AFAppOrderTypeStateCompleted = 5, // 已完成
    AFAppOrderTypeStateCancel = 6 // 已取消
} AFAppOrderTypeState;

typedef NS_ENUM(NSUInteger, PlanStatusType) { //认证状态
    FYCheckOff = 1, //未审核
    FYChecking = 2, //审核中
    FYCheckOn = 3, //已审核
    FYCheckFalse = 4,//审核失败
    FYBlacklist = -1 //黑名单
};

typedef NS_ENUM(NSUInteger, EarningType) {//个人中心服务类型
    FYEarningService = 0,
    FYOrderNumberService = 1,
    FYOtherService = 2,
    FYWithDrawService = 3,//提现
};

#endif /* JYAppVodeo_h */
