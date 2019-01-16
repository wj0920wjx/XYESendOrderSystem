//
//  FeatureView.m
//  JY
//
//  Created by 澳达国际 on 2019/1/11.
//  Copyright © 2019 飞鱼旅行. All rights reserved.
//

#import "FeatureView.h"

@implementation FeatureView

+(FeatureView *)initFeatureView{
    UINib *nib = [UINib nibWithNibName:@"FeatureView" bundle:nil];
    FeatureView *aView = [[nib instantiateWithOwner:self options:nil] lastObject];
    return aView;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.noteTextView.wzb_placeholder = @"备注";
    self.homestayInfoTextView.wzb_placeholder = @"玩法介绍";
    
    @weakify(self)
    [[self.homestayPopTextField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self)
        self.homestayPopTextField.text = [NSString stringWithFormat:@"%ld",[x integerValue]];
        [self.featureDic setObject:self.homestayPopTextField.text forKey:@"adult"];
    }];
    [[self.apartmentTextField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self)
        self.apartmentTextField.text = [NSString stringWithFormat:@"%ld",[x integerValue]];
        [self.featureDic setObject:self.apartmentTextField.text forKey:@"child"];
    }];
    
    [[[NSNotificationCenter defaultCenter]
      rac_addObserverForName:UIKeyboardWillHideNotification
      object:nil]
     subscribeNext:^(NSNotification *notification) {
         if ([self.homestayInfoTextView isFirstResponder]) {
             @strongify(self)
             [self.featureDic setObject:self.homestayInfoTextView.text forKey:@"featureIntroduction"];
         }
         else if ([self.noteTextView isFirstResponder]) {
             @strongify(self)
             [self.featureDic setObject:self.noteTextView.text forKey:@"order_notes"];
         }
         else{
             [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
         }
     }];
    
}

- (IBAction)popBtnclick:(UIButton *)sender {
    NSInteger count = [self.homestayPopTextField.text integerValue];
    if (sender.tag == 1) {
        //减
        if (count <= 1) {
            count = 1;
        }
        self.homestayPopTextField.text = [NSString stringWithFormat:@"%ld",--count];
    }
    else{
        self.homestayPopTextField.text = [NSString stringWithFormat:@"%ld",++count];
    }
    
    [self.featureDic setObject:self.homestayPopTextField.text forKey:@"adult"];
}

- (IBAction)apartmentBtnClick:(UIButton *)sender {
    NSInteger count = [self.apartmentTextField.text integerValue];
    if (sender.tag == 1) {
        //减
        if (count <= 1) {
            count = 1;
        }
        self.apartmentTextField.text = [NSString stringWithFormat:@"%ld",--count];
    }
    else{
        self.apartmentTextField.text = [NSString stringWithFormat:@"%ld",++count];
    }
    
    [self.featureDic setObject:self.apartmentTextField.text forKey:@"child"];
}

#pragma mark -- 懒加载
-(NSMutableDictionary *)featureDic{
    if (!_featureDic) {
        _featureDic = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _featureDic;
}


@end
