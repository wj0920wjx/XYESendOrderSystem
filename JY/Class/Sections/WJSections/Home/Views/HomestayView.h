//
//  HomestayView.h
//  JY
//
//  Created by 澳达国际 on 2019/1/11.
//  Copyright © 2019 飞鱼旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomestayView : UIView

+(HomestayView *)initHomestayView;

@property (weak, nonatomic) IBOutlet UITextField *homestayPopTextField;

@property (weak, nonatomic) IBOutlet UITextField *apartmentTextField;

@property (weak, nonatomic) IBOutlet UITextView *homestayInfoTextView;

@property (weak, nonatomic) IBOutlet UITextView *noteTextView;

/**
 民宿数据
 */
@property (strong, nonatomic) NSMutableDictionary *homestayDic;

@end

NS_ASSUME_NONNULL_END
