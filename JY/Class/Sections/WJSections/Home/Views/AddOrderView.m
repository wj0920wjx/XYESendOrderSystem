//
//  AddOrderView.m
//  JY
//
//  Created by 澳达国际 on 2019/1/11.
//  Copyright © 2019 飞鱼旅行. All rights reserved.
//

#import "AddOrderView.h"

@implementation AddOrderView

+(AddOrderView *)initAddOrderView{
    UINib *nib = [UINib nibWithNibName:@"AddOrderView" bundle:nil];
    AddOrderView *addOrderView = [[nib instantiateWithOwner:self options:nil] lastObject];
    return addOrderView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
