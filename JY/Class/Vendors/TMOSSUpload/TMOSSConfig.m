//
//  TMOSSConfig.m
//  FrameDemo
//
//  Created by 许洋 on 2017/12/25.
//  Copyright © 2017年 许洋. All rights reserved.
//

#import "TMOSSConfig.h"
#import "TMServerConfig.h"

@implementation TMOSSConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        _https = NO;
    }
    return self;
}
- (NSString *)bucketName{
    if ([self isPrivateType]) {
        _bucketName = [TMServerConfig sharedConfig].kOSSPrivatelyBucketName;
    }else{
        _bucketName = [TMServerConfig sharedConfig].kOSSPublicBucketName;
    }
    return _bucketName;
}
-(NSString *)imageUrlDomin{
    
    
    if ([self isPrivateType]) {
        _bucketName = [TMServerConfig sharedConfig].kOSSPrivatelyImageDomain;
    }else{
        _bucketName = [TMServerConfig sharedConfig].kOSSPublicImageDomain;
    }
    return _bucketName;
}

- (BOOL)isPrivateType {
    switch (_uploadType) {
        case TMOSSUploadTypeUserDrive:
        case TMOSSUploadTypeUserGuide:
        case TMOSSUploadTypeUserEstate:
        case TMOSSUploadTypeUserDriving:
        case TMOSSUploadTypeUserPapers:
            return YES;
            break;
            
        default:
            return NO;
            break;
    }
}


-(NSString *)filePrefix{
    switch (_uploadType) {
        case TMOSSUploadTypeNone:
            _filePrefix = @"";
            break;
        case TMOSSUploadTypeUserAvaterB:
        case TMOSSUploadTypeUserDailyB:
            _filePrefix = @"B";
            break;
        case TMOSSUploadTypeUserAvaterC:
        case TMOSSUploadTypeUserDailyC:
            _filePrefix = @"C";
            break;
        case TMOSSUploadTypeServiceCustom:
            _filePrefix = @"XCDZ";
            break;
        case TMOSSUploadTypeServiceRoute:
            _filePrefix = @"XL";
            break;
        case TMOSSUploadTypeServiceHomestay:
            _filePrefix = @"MS";
            break;
        case TMOSSUploadTypeServiceCar:
            _filePrefix = @"QC";
            break;
        case TMOSSUploadTypeUserPapers:
            _filePrefix = @"";
            break;
            
        default:
            _filePrefix = @"";
            break;
    }
    return _filePrefix;
}
-(NSString *)fileGroupName{
    switch (_uploadType) {
        case TMOSSUploadTypeUserDailyC:
        case TMOSSUploadTypeUserDailyB:{
            _fileGroupName = @"user/daily/";
            break;
        }
        case TMOSSUploadTypeUserAvaterC:
        case TMOSSUploadTypeUserAvaterB:{
            _fileGroupName = @"user/avater/";
            break;
        }
        case TMOSSUploadTypeServiceRoute:{
            _fileGroupName = @"service/line/";
            break;
        }
        case TMOSSUploadTypeServiceHomestay:{
            _fileGroupName = @"service/homestay/";
            break;
        }
        case TMOSSUploadTypeServiceCustom:{
            _fileGroupName = @"service/custom/";
            break;
        }
        case TMOSSUploadTypeServiceCar:{
            _fileGroupName = @"service/car/";
            break;
        }
        case TMOSSUploadTypeUserPapers:{
            _fileGroupName = @"paperword/";
            break;
        }
        case TMOSSUploadTypeUserDrive: {
            _fileGroupName = @"drive/";
            break;
        }
        case TMOSSUploadTypeUserDriving: {
            _fileGroupName = @"driving/";
            break;
        }
        case TMOSSUploadTypeUserEstate: {
            _fileGroupName = @"estate/";
            break;
        }
        case TMOSSUploadTypeUserGuide: {
            _fileGroupName = @"guide/";
            break;
        }
        case TMOSSUploadTypeNone: {
            _fileGroupName = @"ohter/";
            break;
        }

    }
    return _fileGroupName;
}
- (NSString *)objectKey{
    
    double time = [[NSDate date] timeIntervalSince1970];//时间戳
    int randomNumber =100000 +  (arc4random() % 900000);//6位数随机数
    return [NSString stringWithFormat:@"%@%@%.0f%d.jpg",self.fileGroupName,self.filePrefix,time,randomNumber];
}
- (NSString *)OSSDomain{
    return [NSString stringWithFormat:@"%@%@",_https ? @"https://":@"http://",[TMServerConfig sharedConfig].kOSSDomain];
}
-(NSString *)imgUrlForObjectKey:(NSString *)objectKey{
    return [NSString stringWithFormat:@"%@%@/%@",_https ? @"https://":@"http://",self.imageUrlDomin,objectKey];
}
@end
