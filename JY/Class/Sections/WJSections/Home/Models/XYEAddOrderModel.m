//
//  XYEAddOrderModel.m
//  JY
//
//  Created by 澳达国际 on 2019/1/11.
//  Copyright © 2019 飞鱼旅行. All rights reserved.
//

#import "XYEAddOrderModel.h"

@implementation XYEAddOrderModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"Id" : @"id"
             };
}

+(NSDictionary *)mj_objectClassInArray{
    return @{@"note_list" : [XYENoteModel class]};
}

-(NSMutableArray<XYENoteModel *> *)note_list{
    if (!_note_list) {
        _note_list = [NSMutableArray arrayWithCapacity:0];
    }
    return _note_list;
}

@end

@implementation XYEDirverInfoModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"Id" : @"id"
             };
}

@end

@implementation XYENoteModel


@end
