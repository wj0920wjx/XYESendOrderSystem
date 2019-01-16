//
//  LMJBaseResponse.m
//  PLMMPRJK
//
//  Created by 王杰 on 2017/4/24.
//  Copyright © 2018年 飞鱼旅行. All rights reserved.
//

#import "LMJBaseResponse.h"

@implementation LMJBaseResponse


- (NSString *)description
{
    return [NSString stringWithFormat:@"\n状态吗: %zd,\n错误: %@,\n响应头: %@,\n响应体: %@", self.statusCode, self.error, self.headers, self.responseObject];
}

- (void)setError:(NSError *)error {
    _error = error;
    self.statusCode = error.code;
    self.errorMsg = error.localizedDescription;
}

@end
