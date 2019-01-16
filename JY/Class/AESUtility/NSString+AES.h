//
//  NSString+AES.h
//  JY
//
//  Created by 王杰 on 2018/9/13.
//  Copyright © 2018年 飞鱼旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AES)

/**
 加密

 @return 加密结果
 */
- (NSString*)aci_encryptWithAES;

/**
 解密

 @return 解密结果
 */
- (NSString*)aci_decryptWithAES;


/**
 jsonString转Dic

 @return 字典
 */
- (NSDictionary *)dictionaryWithJsonString;

@end
