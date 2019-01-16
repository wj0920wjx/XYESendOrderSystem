//
//  FYBaseModel.h
//  JY
//
//  Created by 王杰 on 2018/9/14.
//  Copyright © 2018年 飞鱼旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Success)(id data);
typedef void(^Failure)(id data);

@interface FYBaseModel : NSObject

//提示信息
@property (nonatomic, copy) NSString *message;

//状态码
@property (assign, nonatomic) NSString *status;


-(void)sendRequest:(NSDictionary *)param AndUrl:(NSString *)url AndSuccess:(Success)success AndFailure:(Failure)failure;

@end
