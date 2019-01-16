//
//  HomeTableViewCell.m
//  JY
//
//  Created by 澳达国际 on 2019/1/9.
//  Copyright © 2019 飞鱼旅行. All rights reserved.
//

#import "HomeTableViewCell.h"

@interface HomeTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *groundLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *wxLabel;
@property (weak, nonatomic) IBOutlet UILabel *wangLabel;
@property (weak, nonatomic) IBOutlet UILabel *carLabel;
@property (weak, nonatomic) IBOutlet UILabel *fyLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(XYEResponseSubModel *)model{
    if (model) {
        _model = model;
        self.titleLabel.text = [NSString stringWithFormat:@"订单标题: %@",StringIsNullRetBlank(model.order_title)];
        self.orderNoLabel.text = [NSString stringWithFormat:@"订单编号: %@",StringIsNullRetBlank(model.Id)];
        self.groundLabel.text = [NSString stringWithFormat:@"地接编号: %@",StringIsNullRetBlank(model.ground_name_num)];
        self.startTimeLabel.text = [NSString stringWithFormat:@"%@",StringIsNullRetBlank([self getDate:model.start_time])];
        
        self.endTimeLabel.text = [NSString stringWithFormat:@"%@",(StringIsNullOrEmpty(model.end_time)||[model.end_time integerValue] == 0)?@"":[self getDate:model.end_time]];
        
        self.nameLabel.text = [NSString stringWithFormat:@"客户: %@",StringIsNullRetBlank(model.client_name)];
        self.phoneLabel.text = [NSString stringWithFormat:@"手机: %@",StringIsNullRetBlank(model.client_phone)];
        self.wxLabel.text = [NSString stringWithFormat:@"微信: %@",StringIsNullRetBlank(model.client_wx)];
        self.wangLabel.text = [NSString stringWithFormat:@"旺旺: %@",StringIsNullRetBlank(model.client_ww)];
        self.carLabel.text = [NSString stringWithFormat:@"车辆: %@ %@",StringIsNullRetBlank(model.car),StringIsNullRetBlank(model.car_suf)];
        self.fyLabel.text = [NSString stringWithFormat:@"飞鱼: %@",StringIsNullRetBlank(model.plan_nick_name)];
        
        self.statusLabel.text = [NSString stringWithFormat:@"订单状态: %@",StringIsNullRetBlank(model.order_state_name)];
    }
}

#pragma mark -- 私有库
-(NSString *)getDate:(NSString *)timeStampString{
    // iOS 生成的时间戳是10位
    NSTimeInterval interval =[timeStampString doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [formatter stringFromDate: date];
    return dateString;
}

@end
