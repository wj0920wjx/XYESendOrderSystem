//
//  AESUtility.m
//  JY
//
//  Created by 王杰 on 2018/9/12.
//  Copyright © 2018年 飞鱼旅行. All rights reserved.
//

#import "AESUtility.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"

#define MD5Key          @"uydsdfv5235232852fcx"

@implementation AESUtility

+ (NSString *) AESMD5Encrypt:(NSDictionary *)content{
    NSString *currentTimeStr = [self currentTimeStr];
    NSDictionary *dic = @{@"content":content,@"time":currentTimeStr,@"sign":[[NSString stringWithFormat:@"%@%@%@",[content jsonStringEncoded],currentTimeStr,MD5Key] md5]};
    
    NSString *paramter = [dic jsonStringEncoded];
    NSString *aes = [paramter aci_encryptWithAES];
    
    return aes;
}

//获取当前时间戳
+ (NSString *)currentTimeStr{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970];// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

@end
