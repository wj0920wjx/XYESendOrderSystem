//
//  OneWayOfView.h
//  JY
//
//  Created by 澳达国际 on 2019/1/11.
//  Copyright © 2019 飞鱼旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OneWayOfView : UIView

+(OneWayOfView *)initOneWayOfView;

/**
 成人数
 */
@property (weak, nonatomic) IBOutlet UITextField *adultTextField;

/**
 儿童数
 */
@property (weak, nonatomic) IBOutlet UITextField *childTextField;

/**
 行李数
 */
@property (weak, nonatomic) IBOutlet UITextField *luggageTextField;

/**
 儿童座椅
 */
@property (weak, nonatomic) IBOutlet UITextField *childSetTextField;

/**
 出发地点
 */
@property (weak, nonatomic) IBOutlet UITextView *departTextView;

/**
 送达地点
 */
@property (weak, nonatomic) IBOutlet UITextView *deliveTextView;

/**
 备注
 */
@property (weak, nonatomic) IBOutlet UITextView *noteTextView;

/**
 选择车辆
 */
@property (weak, nonatomic) IBOutlet UITextField *selectCarTextField;

/**
 车辆后缀
 */
@property (weak, nonatomic) IBOutlet UITextField *prefixTextField;

@property (nonatomic, strong)NSMutableArray *carList;

/**
 单程接送
 */
@property (strong, nonatomic) NSMutableDictionary *oneWayDic;

@end

NS_ASSUME_NONNULL_END
