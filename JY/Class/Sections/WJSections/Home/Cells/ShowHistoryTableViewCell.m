//
//  ShowHistoryTableViewCell.m
//  JY
//
//  Created by 澳达国际 on 2019/1/16.
//  Copyright © 2019 飞鱼旅行. All rights reserved.
//

#import "ShowHistoryTableViewCell.h"

@interface ShowHistoryTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation ShowHistoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(XYEVisitSubModel *)model{
    _model = model;
    self.nameLabel.text = StringIsNullRetBlank(model.admin_name);
    self.contentLabel.text = StringIsNullRetBlank(model.text);
    self.timeLabel.text = [StringIsNullRetBlank(model.created_at) getStamDate];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
