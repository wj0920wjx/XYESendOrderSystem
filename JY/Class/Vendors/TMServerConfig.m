//
//  TMServerConfig.m
//  TravelMaster
//
//  Created by 许洋 on 2017/10/25.
//  Copyright © 2017年 遨游大师. All rights reserved.
//

#import "TMServerConfig.h"
#define kServerConfig @"kServerConfig"

@implementation TMServerConfig
static id sharedInstance=nil;
+ (TMServerConfig *)sharedConfig {
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
        _serverType = TMServerTypeDevelopmentTest;
    }
    return self;
}
// 18.6.26 更换成 map.feiyutour.com
- (NSString *)kMapUrl{
    switch (self.serverType) {
        case TMServerTypeDevelopmentOfficial:{
            return @"http://map.aoyoudashi.com";
        }break;
        case TMServerTypeDevelopmentTest:{
            return @"http://mapp.aoyoudashi.com";
        }break;
        case TMServerTypeProductionOfficial:{
            return @"http://map.aoyoudashi.com";
        }break;
        case TMServerTypeProductionTest:{
            return @"http://mapp.aoyoudashi.com";
        }break;
    }
}

- (NSString *)kUmengAppKey{
    switch (self.serverType) {
        case TMServerTypeDevelopmentOfficial:{
            return @"5ac1d988a40fa34cba00004d";
        }break;
        case TMServerTypeDevelopmentTest:{
            return @"5ac1d988a40fa34cba00004d";
        }break;
        case TMServerTypeProductionOfficial:{
            return @"5ac1d988a40fa34cba00004d";
        }break;
        case TMServerTypeProductionTest:{
            return @"5ac1d988a40fa34cba00004d";
        }break;
    }
}

- (NSString *)kYXIMAppKey{
    switch (self.serverType) {
        case TMServerTypeDevelopmentOfficial:{
            return @"95a880ea1c40003933911961ac5cd219";
        }break;
        case TMServerTypeDevelopmentTest:{
            return @"0880c79f8d91cbeeffdcdbcec2b018f5";
        }break;
        case TMServerTypeProductionOfficial:{
            return @"95a880ea1c40003933911961ac5cd219";
        }break;
        case TMServerTypeProductionTest:{
            return @"0880c79f8d91cbeeffdcdbcec2b018f5";
        }break;
    }
}

- (BOOL)useSSL {

    switch (self.serverType) {
        case TMServerTypeDevelopmentOfficial:{
            return YES;
        }break;
        case TMServerTypeDevelopmentTest:{
            return NO;
        }break;
        case TMServerTypeProductionOfficial:{
            return YES;
        }break;
        case TMServerTypeProductionTest:{
            return NO;
        }break;
    }
}

//- (NSString *)kServerDomain{
////    return @"www.feiyutour.com";
//    switch (self.serverType) {
//        case TMServerTypeDevelopmentOfficial:{
////            TMBaseEngineInstance.useSSL = YES;
//            return @"www.feiyutour.com";
//        }break;
//        case TMServerTypeDevelopmentTest:{
////            TMBaseEngineInstance.useSSL = NO;
//            return @"demo.feiyutour.com";
//        }break;
//        case TMServerTypeProductionOfficial:{
////            TMBaseEngineInstance.useSSL = YES;
//            return @"www.feiyutour.com";
//        }break;
//        case TMServerTypeProductionTest:{
////            TMBaseEngineInstance.useSSL = NO;
//            return @"demo.feiyutour.com";
//        }break;
//    }
//}


-(NSString *)kYXPushCertificateName{
    switch (self.serverType) {
        case TMServerTypeDevelopmentOfficial:{
            return @"alphaFishPushDevYX";
        }break;
        case TMServerTypeDevelopmentTest:{
            return @"alphaFishPushDevYX";
        }break;
        case TMServerTypeProductionOfficial:{
            return @"alphaFishPushProYX";
        }break;
        case TMServerTypeProductionTest:{
            return @"alphaFishPushDevYX";
        }break;
    }
}
-(NSString *)kOSSAccessKey{
    return @"LTAImteJO6BtizoR";
}
-(NSString *)kOSSSecretKey{
    return @"lXOeEzNaWnn2x9kP4hUiuc8z6rmEI1";
}
-(NSString *)kOSSDomain{
    return @"oss-cn-beijing.aliyuncs.com";
}
-(NSString *)kOSSPrivatelyBucketName{
    switch (self.serverType) {
        case TMServerTypeDevelopmentOfficial:{
            return @"feiyu-privately";
        }break;
        case TMServerTypeDevelopmentTest:{
            return @"feiyu-privatelypro";
        }break;
        case TMServerTypeProductionOfficial:{
            return @"feiyu-privately";
        }break;
        case TMServerTypeProductionTest:{
            return @"feiyu-privatelypro";
        }break;
    }
}
-(NSString *)kOSSPublicBucketName{
    switch (self.serverType) {
        case TMServerTypeDevelopmentOfficial:{
            return @"feiyu-public";
        }break;
        case TMServerTypeDevelopmentTest:{
//            return @"feiyu-public";
            return @"feiyu-publicpro";
        }break;
        case TMServerTypeProductionOfficial:{
            return @"feiyu-public";
        }break;
        case TMServerTypeProductionTest:{
            return @"feiyu-publicpro";
        }break;
    }
}
-(NSString *)kOSSPublicImageDomain{
    switch (self.serverType) {
        case TMServerTypeDevelopmentOfficial:{
            return @"image.feiyutour.com";
        }break;
        case TMServerTypeDevelopmentTest:{
            return @"imagep.feiyutour.com";
        }break;
        case TMServerTypeProductionOfficial:{
            return @"image.feiyutour.com";
        }break;
        case TMServerTypeProductionTest:{
            return @"imagep.feiyutour.com";
        }break;
    }
}
-(NSString *)kOSSPrivatelyImageDomain{
    switch (self.serverType) {
        case TMServerTypeDevelopmentOfficial:{
            return @"paperword.feiyutour.com";
        }break;
        case TMServerTypeDevelopmentTest:{
            return @"paperwordp.feiyutour.com";
        }break;
        case TMServerTypeProductionOfficial:{
            return @"paperword.feiyutour.com";
        }break;
        case TMServerTypeProductionTest:{
            return @"paperwordp.feiyutour.com";
        }break;
    }
}
-(NSString *)kTXIMAppKey{
    switch (self.serverType) {
        case TMServerTypeDevelopmentOfficial:{
            return @"1400055704";
        }break;
        case TMServerTypeDevelopmentTest:{
            return @"1400079728";
        }break;
        case TMServerTypeProductionOfficial:{
            return @"1400055704";
        }break;
        case TMServerTypeProductionTest:{
            return @"1400079728";
        }break;
    }
}
-(NSString *)kTXIMAcountType{
    switch (self.serverType) {
        case TMServerTypeDevelopmentOfficial:{
            return @"20496";
        }break;
        case TMServerTypeDevelopmentTest:{
            return @"24640";
        }break;
        case TMServerTypeProductionOfficial:{
            return @"20496";
        }break;
        case TMServerTypeProductionTest:{
            return @"24640";
        }break;
    }
}
-(NSString *)kHomeWebUrl{
    switch (self.serverType) {
        case TMServerTypeDevelopmentOfficial:{
            return @"https://www.feiyutour.com/h5/bHome";
        }break;
        case TMServerTypeDevelopmentTest:{
            return @"http://demo.feiyutour.com/h5/bHome";
        }break;
        case TMServerTypeProductionOfficial:{
            return @"https://www.feiyutour.com/h5/bHome";
        }break;
        case TMServerTypeProductionTest:{
            return @"http://demo.feiyutour.com/h5/bHome";
        }break;
    }
}
@end
