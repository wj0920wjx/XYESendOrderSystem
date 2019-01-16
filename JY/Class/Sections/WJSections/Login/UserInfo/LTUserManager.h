//
//  LTUserManager.h
//  LoveTrave
//
//  Created by 澳达国际 on 2018/11/30.
//  Copyright © 2018 澳达国际. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class UserinfoModel;
@interface LTUserManager : NSObject

/**
 用户信息
 */
@property (nonatomic, strong)UserinfoModel *userInfo;

/**
 登录token
 */
@property (nonatomic, strong) NSString *token;

/**
 权限数据
 */
@property (nonatomic, strong) NSArray *permissions;


/**
 单例对象

 @return LTUserManager
 */
+ (LTUserManager *)sharedManager;

/**
 检测用户状态

 @return 是否登录
 */
+(BOOL)checkUserStatus;

/**
 *  获取用户信息
 *
 *  @return 用户信息json
 */
+ (id)getUserInfo;

/**
 *  设置用户信息
 *
 *  @param userInfoDict 用户信息json
 */
+ (void)setUserInfo:(NSDictionary *)userInfoDict;

/**
 移除用户信息
 */
+ (void)removeUserInfo;

/**
 重置用户信息
 */
+(void)resetUserInfo;

/**
 更新用户信息
 */
-(void)updateUserInfo;

/**
 前往登录页面
 */
-(void)gotoLogin;


/**
 首次启动

 @return <#return value description#>
 */
- (BOOL) isFirstLoad;

/**
 获取照片地址

 @param url <#url description#>
 @return <#return value description#>
 */
+(NSString *)getImageVideoUrl:(NSString *)url;

#pragma mark ---- 获取图片第一帧
/**
 <#Description#>

 @param url <#url description#>
 @param size <#size description#>
 @return <#return value description#>
 */
+ (UIImage *)firstFrameWithVideoURL:(NSURL *)url size:(CGSize)size;

#pragma mark -- 上传图片/视频


@end

@interface UserinfoModel : NSObject

/**
 用户名
 */
@property (nonatomic, strong)NSString *name;

/**
 用户ID
 */
@property (nonatomic, strong)NSString *userId;

/**
 头像
 */
@property (nonatomic, strong)NSString *avatar;

/**
 分组名称
 */
@property (nonatomic, strong)NSString *group;

/**
 组ID
 */
@property (nonatomic, strong)NSString *group_id;

/**
 手机号码
 */
@property (nonatomic, strong)NSString *phone;

/**
 sex
 */
@property (nonatomic, strong)NSString *sex;

/**
 账户名称
 */
@property (nonatomic, strong)NSString *account;

@end

NS_ASSUME_NONNULL_END
