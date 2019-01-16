//
//  FYBaseViewModel.h
//  JY
//
//  Created by 王杰 on 2018/9/17.
//  Copyright © 2018年 飞鱼旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef void(^Success)(id data);
//typedef void(^Failure)(id data);
//
//@protocol BaseModelDelegate <NSObject>
////可添加代理方法
//-(void)getDataSuccess:(Success)success AndFailure:(Failure)failure;
//
//@end

@interface FYBaseViewModel : NSObject

@property(nonatomic,strong) RACSubject *successObject;
@property(nonatomic,strong) RACSubject *failureObject;

//@property(nonatomic,weak) id<BaseModelDelegate> baseModelDelegate;
//
-(void)exchangeData:(NSMutableDictionary *)param;

-(void)exchangeData:(NSMutableDictionary *)param WithUrl:(NSString *)urlString;

@end
