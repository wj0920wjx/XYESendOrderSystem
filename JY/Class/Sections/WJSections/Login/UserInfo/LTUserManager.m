//
//  LTUserManager.m
//  LoveTrave
//
//  Created by 澳达国际 on 2018/11/30.
//  Copyright © 2018 澳达国际. All rights reserved.
//

#import "LTUserManager.h"
#import <AVFoundation/AVFoundation.h>
#import "XYELoginViewController.h"

#define LAST_RUN_VERSION_KEY @"last_run_version_of_application"
#define kAppPersonUserInfo @"userInfo"

@implementation LTUserManager

static id userManager=nil;
static dispatch_once_t predicate;

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"userInfo" : @"info"
             };
}

+ (LTUserManager *)sharedManager{
    dispatch_once(&predicate, ^{
        userManager = [[self alloc] init];
    });
    return userManager;
}

+(BOOL)checkUserStatus{
    NSString *token = [LTUserManager sharedManager].token;
    if (!StringIsNullOrEmpty(token)) {
        return YES;
    }
    return NO;
}

-(NSString *)imageBaseUrl{
    return @"http://img.cdn.ailschn.com";
}

+(NSString *)getImageVideoUrl:(NSString *)url{
    if ([url contains:@"http"]) {
        return url;
    }
    else{
        return [NSString stringWithFormat:@"%@/%@",[LTUserManager sharedManager].imageBaseUrl,url];
    }
}

#pragma mark ---- 获取图片第一帧
+ (UIImage *)firstFrameWithVideoURL:(NSURL *)url size:(CGSize)size
{
    // 获取视频第一帧
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:opts];
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    generator.appliesPreferredTrackTransform = YES;
    generator.maximumSize = CGSizeMake(size.width, size.height);
    NSError *error = nil;
    CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(0, 10) actualTime:NULL error:&error];
    {
        return [UIImage imageWithCGImage:img];
    }
    return nil;
}

-(void)updateUserInfo{
    NSDictionary *userInfoDict = [self mj_JSONObject];
    [[NSUserDefaults standardUserDefaults] setObject:userInfoDict forKey:kAppPersonUserInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)getUserInfo {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kAppPersonUserInfo];
}


+ (void)setUserInfo:(NSDictionary *)userInfoDict {
    [[NSUserDefaults standardUserDefaults] setObject:userInfoDict forKey:kAppPersonUserInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)removeUserInfo {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kAppPersonUserInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)resetUserInfo{
    [LTUserManager removeUserInfo];
    [[LTUserManager sharedManager] clear];
}

-(void)clear{
    predicate = 0;
}

- (BOOL) isFirstLoad{
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastRunVersion = [defaults objectForKey:LAST_RUN_VERSION_KEY];
    if (!lastRunVersion) {
        [defaults setObject:currentVersion forKey:LAST_RUN_VERSION_KEY];
        return YES;
    }else if (![lastRunVersion isEqualToString:currentVersion]) {
        [defaults setObject:currentVersion forKey:LAST_RUN_VERSION_KEY];
        return YES;
        
    }return NO;
    
}

-(void)gotoLogin{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIStoryboard *sd = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        XYELoginViewController *welcomVC = [sd instantiateViewControllerWithIdentifier:@"XYELoginViewController"];
        LMJNavigationController *nvc = [[LMJNavigationController alloc] initWithRootViewController:welcomVC];

        [[[[UIApplication sharedApplication] delegate] window].rootViewController presentViewController:nvc animated:YES completion:nil];
    });
}


@end

@implementation UserinfoModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"userId" : @"id"
             };
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.account = @"";
        self.avatar = @"";
        self.group = @"";
        self.group_id = @"";
        self.userId = @"";
        self.name = @"";
        self.phone = @"";
        self.sex = @"";
    }
    return self;
}

@end
