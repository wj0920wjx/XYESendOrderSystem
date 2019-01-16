//
//  TMOSSConfig.h
//  FrameDemo
//
//  Created by 许洋 on 2017/12/25.
//  Copyright © 2017年 许洋. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_OPTIONS(NSInteger, TMOSSUploadType) {
    TMOSSUploadTypeNone                 = (1 << 0), // 没有
    TMOSSUploadTypeServiceHomestay      = (1 << 1), // 民宿
    TMOSSUploadTypeServiceRoute         = (1 << 2), // 线路
    TMOSSUploadTypeServiceCustom        = (1 << 3), // 形成定制
    TMOSSUploadTypeServiceCar           = (1 << 4), // 包车
    TMOSSUploadTypeUserAvaterC          = (1 << 5), // 头像 C端
    TMOSSUploadTypeUserAvaterB          = (1 << 6), // 头像 B端
    TMOSSUploadTypeUserDailyC           = (1 << 7), // 日常照 C
    TMOSSUploadTypeUserDailyB           = (1 << 8), // 日常照 B
    
    TMOSSUploadTypeUserPapers           = (1 << 9), // 身份证
    TMOSSUploadTypeUserDrive            = (1 << 10), // 驾驶证
    TMOSSUploadTypeUserDriving          = (1 << 11), // 驾驶证
    TMOSSUploadTypeUserEstate           = (1 << 12), // 房产证
    TMOSSUploadTypeUserGuide            = (1 << 13), // 导游证
};
@interface TMOSSConfig : NSObject

/**
 上传类型 线路 民宿 行程定制 用户
 */
@property (nonatomic, assign) TMOSSUploadType uploadType;

/**
 URL 是否HTTPS
 */
@property (nonatomic, assign,getter=isHttps) BOOL https;

/**
 主域名
 */
@property (nonatomic, copy) NSString *OSSDomain;

/**
 OSS bucketName
 */
@property (nonatomic, copy) NSString *bucketName;

/**
 文件夹名称+文件名称 时间戳+6位随机数
 */
@property (nonatomic, copy) NSString *objectKey;

/**
 图片地址域名
 */
@property (nonatomic, copy) NSString *imageUrlDomin;

/**
 OSS 存放文件夹名称
 */
@property (nonatomic, copy) NSString *fileGroupName;


@property (nonatomic, copy) NSString *filePrefix;

/**
 根据objectKey 返回完整的图片地址

 @param objectKey <#objectKey description#>
 @return <#return value description#>
 */
-(NSString *)imgUrlForObjectKey:(NSString *)objectKey;

@end
