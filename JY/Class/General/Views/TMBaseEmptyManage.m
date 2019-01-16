//
//  TMBaseEmptyManage.m
//  TravelMaster
//
//  Created by aodaguoji on 2017/11/2.
//  Copyright © 2017年 遨游大师. All rights reserved.
//

#import "TMBaseEmptyManage.h"
@interface TMBaseEmptyManage()


//@property (nonatomic, strong) UIView * containerView;


@end
@implementation TMBaseEmptyManage



+ (instancetype)manage {
    return [[self alloc] init];
}
+ (TMBaseEmptyManage *)baseManage{
    return [self manage];
}

- (instancetype)init {
    if(self = [super init]) {
        _buttonSpace = kWidth(20);
        _labelSpace = kWidth(20);
    }
    return self;
}



- (UIView *)containerView {
    if (_containerView) {
        return _containerView;
    }
    _containerView = [[UIView alloc] init];
    _containerView.clipsToBounds = YES;
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kScreenHeight);
    }];
    
    [_containerView addSubview:self.backgroundView];
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.containerView);
    }];
    
    [_containerView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_containerView).offset(_centerOffset.x);
        make.centerY.equalTo(_containerView).offset(_centerOffset.y);
    }];
    
    [_containerView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.titleLabel);
        make.bottom.equalTo(_titleLabel.mas_top).offset(-self.labelSpace);
    }];
    
    [_containerView addSubview:self.actionButton];
    [self.actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(self.buttonSpace);
        make.centerX.equalTo(self.titleLabel);
        if (!CGSizeEqualToSize(self.actionButtonSize, CGSizeZero)) {
            make.size.mas_equalTo(self.actionButtonSize);
        }
    }];

    return _containerView;
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [UIView new];
    }
    return _backgroundView;
}


- (UIImageView *)imageView {
    if (_imageView) {
        return _imageView;
    }
    _imageView = [[UIImageView alloc] init];
    return _imageView;
}

- (UIButton *)actionButton {
    if (_actionButton) {
        return _actionButton;
    }
    _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _actionButton.backgroundColor = BG_COLOR;
    [_actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _actionButton.layer.cornerRadius = kWidth(3);
    [self.actionButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    return _actionButton;
}
- (UILabel *)titleLabel {
    if (_titleLabel) {
        return _titleLabel;
    }
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = TEXT_COLOR;
    _titleLabel.font = [UIFont systemFontOfSize:kWidth(15) weight:UIFontWeightThin];
    return _titleLabel;
}
- (void)buttonAction {
    BlockCallWithVoidArg(self.buttonActionBlock);
}

#pragma mark ------------------- DZNEmptyDataSetSource -------------------
- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
    return self.containerView;
}


@end
