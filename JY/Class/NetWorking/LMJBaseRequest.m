//
//  LMJBaseRequest.m
//  PLMMPRJK
//
//  Created by 王杰 on 2017/4/24.
//  Copyright © 2018年 飞鱼旅行. All rights reserved.
//

#import "LMJBaseRequest.h"
#import "LMJRequestManager.h"

@implementation LMJBaseRequest


- (void)GET:(NSString *)URLString parameters:(id)parameters completion:(void(^)(LMJBaseResponse *response))completion
{
    
    LMJWeakSelf(self);
    [[LMJRequestManager sharedManager] GET:URLString parameters:parameters completion:^(LMJBaseResponse *response) {
        
        if (!weakself) {
            return ;
        }
        
        
        !completion ?: completion(response);
        
    }];
}

- (void)POST:(NSString *)URLString parameters:(id)parameters completion:(void(^)(LMJBaseResponse *response))completion
{
    LMJWeakSelf(self);
    [[LMJRequestManager sharedManager] POST:URLString parameters:parameters completion:^(LMJBaseResponse *response) {
        
        if (!weakself) {
            return ;
        }
        
        
        !completion ?: completion(response);
        
    }];
}



@end
