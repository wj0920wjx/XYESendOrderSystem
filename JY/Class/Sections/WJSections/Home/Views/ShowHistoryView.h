//
//  ShowHistoryView.h
//  JY
//
//  Created by 澳达国际 on 2019/1/16.
//  Copyright © 2019 飞鱼旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ShowHistoryBlock)(void);

@interface ShowHistoryView : UIView

@property (nonatomic, copy)ShowHistoryBlock block;

-(void)requestData:(NSString *)orderId;

@end

NS_ASSUME_NONNULL_END
