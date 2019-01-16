//
//  LMJBaseResponse.h
//  PLMMPRJK
//
//  Created by 王杰 on 2017/4/24.
//  Copyright © 2018年 飞鱼旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMJBaseResponse : NSObject

/** <#digest#> */
@property (nonatomic, strong) NSError *error;

/** <#digest#> */
@property (nonatomic, copy) NSString *errorMsg;

/** <#digest#> */
@property (assign, nonatomic) NSInteger statusCode;

/** <#digest#> */
@property (nonatomic, copy) NSMutableDictionary *headers;

/** <#digest#> */
@property (nonatomic, strong) id responseObject;


/**
 成功返回的状态码
 */
@property (nonatomic, copy) NSString *status;


/**
 成功提示
 */
@property (nonatomic, copy) NSString *message;

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, copy) id data;


@end
