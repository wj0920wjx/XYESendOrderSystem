//
//  LMJConst.m
//  iOSProject
//
//  Created by 王杰 on 2018/1/11.
//  Copyright © 2018年 王杰. All rights reserved.
//

#import "FYConst.h"

#pragma mark -- appID

// App ID
NSString * const kTMAppId     = @"1372460781";

/* 极光推送 key- and -secret*/
NSString * const FY_JPUSHAppKey     = @"2ece8cbc1b6f38ebb702b304";
NSString * const FY_JPUSHSecret     = @"43b66b81bd90a22d5ae19b22";

#pragma mark -- 接口
//订单列表接口
NSString *const FY_ORDER_LIST      = @"/admin/order/index";

//登录           --   重构接口
NSString *const FY_LOGIN           = @"/admin/user/login";

//获取回访记录列表
NSString *const FY_GETVISITLIST    = @"/admin/order/getVisitList";

//添加回访记录
NSString *const FY_VISIT           = @"/admin/order/visit";

//客服主管进行派单操作
NSString *const FY_PRINCIPAL       = @"/admin/order/principal";

//主管服务接口
NSString *const FY_PRINCIPALAUDIT  = @"/admin/order/principalAudit";

//CEO审核已服务订单
NSString *const FY_CEOAUDIT        = @"/admin/order/ceoAudit";

//取消订单
NSString *const FY_CANCEL          = @"/admin/order/cancel";

//已取消订单二次处理标记
NSString *const FY_TRASHMARK       = @"/admin/order/trashMark";

//详情
NSString *const FY_SHOWDETAIL      = @"/admin/order/show";

//选择派单区域国家城市
NSString *const FY_CHOOSEREGION    = @"/admin/order/chooseRegion";

//获取车队后缀
NSString *const FY_SHOWCARLIST     = @"/admin/common/showCar";

//获取地接编号
NSString *const FY_GROUNDCOUNT     = @"/admin/order/groundCount";

//获取地接列表
NSString *const FY_GROUNFLEET      = @"/admin/order/fleet";

//选择飞鱼信息
NSString *const FY_CHOOSEPLAN      = @"/admin/order/choosePlan";

//创建订单
NSString *const FY_ORDERCREATE     = @"/admin/order/create";

//更新订单
NSString *const FY_ORDERUPDATE     = @"/admin/order/update";

//私有库
NSString *const FY_GETSTSTOKEN    = @"/admin/order/getSosToken";

//更新
NSString *const FY_UPDATEVERSION  = @"/admin/order/updateVersion";

#pragma mark -- 通知
// tableviewcontroller dealloc 通知
NSString *const FYTableViewControllerDeallocNotification = @"FYTableViewControllerDeallocNotification";


@implementation FYConst

static id sharedInstance=nil;
+ (FYConst *)sharedConfig {
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _serverType = TMServerTypeDevelopmentOfficial;
    }
    return self;
}

- (NSString *)kServerDomain{
    switch (self.serverType) {
        case TMServerTypeDevelopmentOfficial:{
//            return @"http://116.62.158.253:8000";
            return @"https://apip.feiyutour.com/api";

        }break;
        case TMServerTypeDevelopmentTest: {
            return @"https://apip.feiyutour.com/api";
            break;
        }
        case TMServerTypeProductionOfficial:{
            return @"https://apip.feiyutour.com/api";
        }break;
        case TMServerTypeProductionTest: {
            return @"https://apip.feiyutour.com/api";
            break;
        }
    }
}

@end
