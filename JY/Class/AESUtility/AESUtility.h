//
//  AESUtility.h
//  JY
//
//  Created by 王杰 on 2018/9/12.
//  Copyright © 2018年 飞鱼旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AESUtility : NSObject

/**
 sign -- md5加密

 @param content 参数
 @return 加签名后的数据
 */
+ (NSString *) AESMD5Encrypt:(NSDictionary *)content;

//获取当前时间戳
+ (NSString *)currentTimeStr;

@end
