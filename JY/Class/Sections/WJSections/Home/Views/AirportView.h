//
//  AirportView.h
//  JY
//
//  Created by 澳达国际 on 2019/1/11.
//  Copyright © 2019 飞鱼旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AirportView : UIView<UITextViewDelegate,UITextFieldDelegate>

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
 机场名称
 */
@property (weak, nonatomic) IBOutlet UITextField *airportTextField;

/**
 航班号
 */
@property (weak, nonatomic) IBOutlet UITextField *flightNumTextField;

/**
 送达地点
 */
@property (weak, nonatomic) IBOutlet UITextView *deliveTextField;

/**
 备注
 */
@property (weak, nonatomic) IBOutlet UITextView *noteTextField;

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
 接机数据
 */
@property (strong, nonatomic) NSMutableDictionary *airportDic;

+(AirportView *)initAirportView;

@end

NS_ASSUME_NONNULL_END
