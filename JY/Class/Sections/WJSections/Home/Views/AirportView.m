//
//  AirportView.m
//  JY
//
//  Created by 澳达国际 on 2019/1/11.
//  Copyright © 2019 飞鱼旅行. All rights reserved.
//

#import "AirportView.h"
#import "ZJPickerView.h"

@implementation AirportView

+(AirportView *)initAirportView{
    UINib *nib = [UINib nibWithNibName:@"AirportView" bundle:nil];
    AirportView *aView = [[nib instantiateWithOwner:self options:nil] lastObject];
    return aView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

-(NSMutableDictionary *)airportDic{
    if (!_airportDic) {
        _airportDic = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _airportDic;
}

- (IBAction)addBTn:(UIButton *)sender {
    NSInteger count = [self.adultTextField.text integerValue];
    if (sender.tag == 1) {
        //减
        if (count <= 1) {
            count = 1;
        }
        self.adultTextField.text = [NSString stringWithFormat:@"%ld",--count];
    }
    else{
        self.adultTextField.text = [NSString stringWithFormat:@"%ld",++count];
    }
    
    [self.airportDic setObject:self.adultTextField.text forKey:@"adult"];
}

- (IBAction)childBTn:(UIButton *)sender {
    NSInteger count = [self.childTextField.text integerValue];
    if (sender.tag == 1) {
        //减
        if (count <= 1) {
            count = 1;
        }
        self.childTextField.text = [NSString stringWithFormat:@"%ld",--count];
    }
    else{
        self.childTextField.text = [NSString stringWithFormat:@"%ld",++count];
    }
    [self.airportDic setObject:self.childTextField.text forKey:@"child"];
}

- (IBAction)luggageBtn:(UIButton *)sender {
    NSInteger count = [self.luggageTextField.text integerValue];
    if (sender.tag == 1) {
        //减
        if (count <= 1) {
            count = 1;
        }
        self.luggageTextField.text = [NSString stringWithFormat:@"%ld",--count];
    }
    else{
        self.luggageTextField.text = [NSString stringWithFormat:@"%ld",++count];
    }
    [self.airportDic setObject:self.luggageTextField.text forKey:@"luggage"];
}

- (IBAction)chilSetBtn:(UIButton *)sender {
    NSInteger count = [self.childSetTextField.text integerValue];
    if (sender.tag == 1) {
        //减
        if (count <= 1) {
            count = 1;
        }
        self.childSetTextField.text = [NSString stringWithFormat:@"%ld",--count];
    }
    else{
        self.childSetTextField.text = [NSString stringWithFormat:@"%ld",++count];
    }
    [self.airportDic setObject:self.childSetTextField.text forKey:@"childSeat"];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.noteTextField.wzb_placeholder = @"备注";
    self.deliveTextField.wzb_placeholder = @"送达地点";
    
    @weakify(self)
    [[self.adultTextField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self)
        self.adultTextField.text = [NSString stringWithFormat:@"%ld",[x integerValue]];
        [self.airportDic setObject:self.adultTextField.text forKey:@"adult"];
    }];
    [[self.childTextField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self)
        self.childTextField.text = [NSString stringWithFormat:@"%ld",[x integerValue]];
        [self.airportDic setObject:self.childTextField.text forKey:@"child"];
    }];
    [[self.luggageTextField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self)
        self.luggageTextField.text = [NSString stringWithFormat:@"%ld",[x integerValue]];
        [self.airportDic setObject:self.luggageTextField.text forKey:@"luggage"];
    }];
    [[self.childSetTextField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self)
        self.childSetTextField.text = [NSString stringWithFormat:@"%ld",[x integerValue]];
        [self.airportDic setObject:self.childSetTextField.text forKey:@"childSeat"];
    }];
    
    [[self.airportTextField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self)
        [self.airportDic setObject:x forKey:@"airport_name"];
    }];
    
    [[self.flightNumTextField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self)
        [self.airportDic setObject:self.flightNumTextField.text forKey:@"flight_num"];
    }];
    
    [[self.selectCarTextField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self)
        self.selectCarTextField.text = @"";
        [self endEditing:YES];
        [ZJPickerView zj_showWithDataList:self.carList propertyDict:nil completion:^(NSString * _Nullable selectContent) {
            self.selectCarTextField.text = selectContent;
            [self.airportDic setObject:self.selectCarTextField.text forKey:@"car"];
        }];
    }];
    
    [[self.prefixTextField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self)
        [self.airportDic setObject:self.prefixTextField.text forKey:@"car_suf"];
    }];
    
    [[[NSNotificationCenter defaultCenter]
      rac_addObserverForName:UIKeyboardWillHideNotification
      object:nil]
     subscribeNext:^(NSNotification *notification) {
         if ([self.deliveTextField isFirstResponder]) {
             @strongify(self)
             [self.airportDic setObject:self.deliveTextField.text forKey:@"delivered_site"];
         }
         else if ([self.noteTextField isFirstResponder]) {
             @strongify(self)
             [self.airportDic setObject:self.noteTextField.text forKey:@"order_notes"];
         }
         else{
             [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
         }
     }];
}

-(NSMutableArray *)carList{
    if (!_carList) {
        _carList = [NSMutableArray arrayWithCapacity:0];
    }
    return _carList;
}

@end
