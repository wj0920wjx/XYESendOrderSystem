//
//  TMBaseEmptyManage.h
//  TravelMaster
//
//  Created by aodaguoji on 2017/11/2.
//  Copyright © 2017年 遨游大师. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DZNEmptyDataSet/DZNEmptyDataSet-umbrella.h>

@interface TMBaseEmptyManage : NSObject<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

+ (instancetype)manage;

// swift 用
+ (TMBaseEmptyManage *)baseManage;
// 跟试图 约束了高度
@property (nonatomic, strong) UIView * containerView;

/**
 容器
 */
@property (nonatomic, strong) UIView *backgroundView;
/**
 中心位置的偏移量 默认为 {0, 0}
 */
@property (nonatomic, assign) CGPoint centerOffset;

/**
 imageView
 */
@property (nonatomic, strong) UIImageView *imageView;

/**
 标题view
 */
@property (nonatomic, strong) UILabel *titleLabel;
/**
 按钮
 */
@property (nonatomic, strong) UIButton *actionButton;

/**
 button 距离 label 的垂直间距 默认为20
 */
@property (nonatomic, assign) CGFloat buttonSpace;

/**
 label 距离 image 的垂直间距 默认为20
 */
@property (nonatomic, assign) CGFloat labelSpace;


/**
 actionButtonSize
 */
@property (nonatomic, assign) CGSize actionButtonSize;

/**
 回调
 */
@property (nonatomic, copy) void(^buttonActionBlock)();

@end
