//
//  FYBaseModel.m
//  JY
//
//  Created by 王杰 on 2018/9/14.
//  Copyright © 2018年 飞鱼旅行. All rights reserved.
//

#import "FYBaseModel.h"

@implementation FYBaseModel

-(void)sendRequest:(NSDictionary *)param AndUrl:(NSString *)url AndSuccess:(Success)success AndFailure:(Failure)failure{
    [FYHTTPTOOL upload:url parameters:param formDataBlock:^(id<AFMultipartFormData> formData) {
        
    } progress:^(NSProgress *progress) {
        
    } completion:^(LMJBaseResponse *response) {
        FYBaseModel *model = [FYBaseModel new];
        if (response.error) {
            model.status = [NSString stringWithFormat:@"%ld",(long)response.statusCode];
            model.message = response.errorMsg;
            failure(model);
        }
        else{
            if (!model) {
                model = [FYBaseModel new];
            }
            model.status = [NSString stringWithFormat:@"%ld",(long)response.code];
            model.message = response.message;
            if ([model.status integerValue] == 10004) {
//                [TMAppConfig showTokenError];
                failure(model);
            }
            else
                success(model);
        }
    }];
    
}

@end
