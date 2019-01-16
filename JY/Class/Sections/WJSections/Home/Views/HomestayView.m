//
//  HomestayView.m
//  JY
//
//  Created by 澳达国际 on 2019/1/11.
//  Copyright © 2019 飞鱼旅行. All rights reserved.
//

#import "HomestayView.h"

@implementation HomestayView

+(HomestayView *)initHomestayView{
    UINib *nib = [UINib nibWithNibName:@"HomestayView" bundle:nil];
    HomestayView *aView = [[nib instantiateWithOwner:self options:nil] lastObject];
    return aView;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.noteTextView.wzb_placeholder = @"备注";
    self.homestayInfoTextView.wzb_placeholder = @"房屋信息";
    
    @weakify(self)
    [[self.homestayPopTextField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self)
        self.homestayPopTextField.text = [NSString stringWithFormat:@"%ld",[x integerValue]];
        [self.homestayDic setObject:self.homestayPopTextField.text forKey:@"homestay_pop"];
    }];
    [[self.apartmentTextField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self)
        self.apartmentTextField.text = [NSString stringWithFormat:@"%ld",[x integerValue]];
        [self.homestayDic setObject:self.apartmentTextField.text forKey:@"homestay_apartment"];
    }];
    
    [[[NSNotificationCenter defaultCenter]
      rac_addObserverForName:UIKeyboardWillHideNotification
      object:nil]
     subscribeNext:^(NSNotification *notification) {
         if ([self.homestayInfoTextView isFirstResponder]) {
             @strongify(self)
             [self.homestayDic setObject:self.homestayInfoTextView.text forKey:@"homestay"];
         }
         else if ([self.noteTextView isFirstResponder]) {
             @strongify(self)
             [self.homestayDic setObject:self.noteTextView.text forKey:@"order_notes"];
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
    
    [self.homestayDic setObject:self.homestayPopTextField.text forKey:@"homestay_pop"];
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
    
    [self.homestayDic setObject:self.apartmentTextField.text forKey:@"homestay_apartment"];
}

#pragma mark -- 懒加载
-(NSMutableDictionary *)homestayDic{
    if (!_homestayDic) {
        _homestayDic = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _homestayDic;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
