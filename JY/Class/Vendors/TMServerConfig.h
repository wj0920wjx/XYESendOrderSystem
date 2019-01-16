//
//  TMServerConfig.h
//  TravelMaster
//
//  Created by 许洋 on 2017/10/25.
//  Copyright © 2017年 遨游大师. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface TMServerConfig : NSObject
@property (nonatomic,assign)TMServerType serverType;
//@property (nonatomic,copy,readonly)NSString *kServerDomain;
@property (nonatomic,copy,readonly)NSString *kMapUrl;
@property (nonatomic,copy,readonly)NSString *kUmengAppKey;
@property (nonatomic,copy,readonly)NSString *kYXPushCertificateName;
@property (nonatomic,copy,readonly)NSString *kYXIMAppKey;
@property (nonatomic,copy,readonly)NSString *kOSSAccessKey;
@property (nonatomic,copy,readonly)NSString *kOSSSecretKey;
@property (nonatomic,copy,readonly)NSString *kOSSDomain;
@property (nonatomic,copy,readonly)NSString *kOSSPublicImageDomain;
@property (nonatomic,copy,readonly)NSString *kOSSPrivatelyImageDomain;
@property (nonatomic,copy,readonly)NSString *kOSSPublicBucketName;
@property (nonatomic,copy,readonly)NSString *kOSSPrivatelyBucketName;

@property (nonatomic,copy,readonly)NSString *kHomeWebUrl;

//腾讯 IM
@property (nonatomic,copy,readonly)NSString *kTXIMAppKey;
@property (nonatomic,copy,readonly)NSString *kTXIMAcountType;

@property (nonatomic, assign, readonly) BOOL useSSL;

+ (TMServerConfig *)sharedConfig;
@end
