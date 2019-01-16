
#import <Foundation/Foundation.h>

#pragma mark -- appID

// App ID
UIKIT_EXTERN NSString *const kTMAppId;

/* 极光推送 key- and -secret*/
UIKIT_EXTERN NSString *const FY_JPUSHAppKey;
UIKIT_EXTERN NSString *const FY_JPUSHSecret;

#pragma mark -- 接口
//订单列表接口
UIKIT_EXTERN NSString *const FY_ORDER_LIST;

//选择派单区域国家城市
UIKIT_EXTERN NSString *const FY_CHOOSEREGION;

//获取车队后缀
UIKIT_EXTERN NSString *const FY_SHOWCARLIST;

//获取地接编号
UIKIT_EXTERN NSString *const FY_GROUNDCOUNT;

//获取地接列表
UIKIT_EXTERN NSString *const FY_GROUNFLEET;

//选择飞鱼信息
UIKIT_EXTERN NSString *const FY_CHOOSEPLAN;

//创建订单
UIKIT_EXTERN NSString *const FY_ORDERCREATE;

//更新订单
UIKIT_EXTERN NSString *const FY_ORDERUPDATE;

//登录
UIKIT_EXTERN NSString *const FY_LOGIN;

//获取回访记录列表
UIKIT_EXTERN NSString *const FY_GETVISITLIST;

//添加回访记录
UIKIT_EXTERN NSString *const FY_VISIT;

//客服主管进行派单操作
UIKIT_EXTERN NSString *const FY_PRINCIPAL;

//主管服务接口
UIKIT_EXTERN NSString *const FY_PRINCIPALAUDIT;

//CEO审核已服务订单
UIKIT_EXTERN NSString *const FY_CEOAUDIT;

//取消订单
UIKIT_EXTERN NSString *const FY_CANCEL;

//已取消订单二次处理标记
UIKIT_EXTERN NSString *const FY_TRASHMARK;

//详情
UIKIT_EXTERN NSString *const FY_SHOWDETAIL;

//私有库
UIKIT_EXTERN NSString *const FY_GETSTSTOKEN;

//更新
UIKIT_EXTERN NSString *const FY_UPDATEVERSION;

#pragma mark -- 通知
// tableviewcontroller dealloc 通知
UIKIT_EXTERN NSString *const FYTableViewControllerDeallocNotification;

//获取新的首页数据 // banner
UIKIT_EXTERN NSString *const FY_NEWHOMEDATA;

@interface FYConst : NSObject

@property (nonatomic,assign)TMServerType serverType;

@property (nonatomic,copy,readonly)NSString *kServerDomain;//服务器地址s

+ (FYConst *)sharedConfig;

@end
