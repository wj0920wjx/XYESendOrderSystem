//
//  RemarkTableViewCell.m
//  JY
//
//  Created by 澳达国际 on 2019/1/15.
//  Copyright © 2019 飞鱼旅行. All rights reserved.
//

#import "RemarkTableViewCell.h"

@interface RemarkTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation RemarkTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(XYENoteModel *)model{
    if (model) {
        _model = model;
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"defaultAvatar"]];
        self.nameLabel.text = model.admin_name;
        self.contentLabel.text = model.text;
        self.timeLabel.text = [model.created_at getStamDate];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
