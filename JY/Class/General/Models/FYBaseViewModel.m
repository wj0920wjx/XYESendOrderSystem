//
//  FYBaseViewModel.m
//  JY
//
//  Created by 王杰 on 2018/9/17.
//  Copyright © 2018年 飞鱼旅行. All rights reserved.
//

#import "FYBaseViewModel.h"
#import "FYBaseModel.h"

@implementation FYBaseViewModel

-(instancetype)init{
    if (self = [super init]) {
        self.successObject = [RACSubject subject];
        self.failureObject = [RACSubject subject];
    }
    return self;
}

-(void)exchangeData:(NSDictionary *)param{
    
}

-(void)exchangeData:(NSMutableDictionary *)param WithUrl:(NSString *)urlString{
    
}

@end
