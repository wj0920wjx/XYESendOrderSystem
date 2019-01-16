//
//  XYEAddOrderViewController.m
//  JY
//
//  Created by 澳达国际 on 2019/1/11.
//  Copyright © 2019 飞鱼旅行. All rights reserved.
//

#import "XYEAddOrderViewController.h"
#import "MOFSPickerManager.h"
#import "XYECountryModel.h"
#import "XYEPlanInfo.h"
#import "GroundNumList.h"
#import "PGDatePickManager.h"
#import "AirportView.h"
#import "AirportOffView.h"
#import "CharteredCarView.h"
#import "OneWayOfView.h"
#import "HomestayView.h"
#import "FeatureView.h"
#import "ZJPickerView.h"

@interface XYEAddOrderViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollerViewTop;

/**
 添加视图
 */
@property (strong, nonatomic) IBOutlet UIView *contentView;

/**
 滚动视图
 */
@property (weak, nonatomic) IBOutlet UIScrollView *scrollerView;

//订单标题
@property (weak, nonatomic) IBOutlet UITextField *orderTitleTextField;

@property (weak, nonatomic) IBOutlet UITextField *clientNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *clientWXTextField;
@property (weak, nonatomic) IBOutlet UITextField *clientwwTextField;
@property (weak, nonatomic) IBOutlet UITextField *chanalNoTextField;

//搜索飞鱼
@property (weak, nonatomic) IBOutlet UITextField *searchFYTextField;
//结算费用
@property (weak, nonatomic) IBOutlet UITextField *gotCostTextField;
//平台收费
@property (weak, nonatomic) IBOutlet UITextField *sysCostTextField;
//当地货币
@property (weak, nonatomic) IBOutlet UITextField *localCost;

//地接编号输入
@property (weak, nonatomic) IBOutlet UITextField *groundNumTextField;
//服务数量
@property (weak, nonatomic) IBOutlet UILabel *serviceLabel;
//必填数据
@property (weak, nonatomic) IBOutlet UILabel *mustStartLabel;

//渠道来源
@property (weak, nonatomic) IBOutlet UITextField *chanalComeTextField;
@property (weak, nonatomic) IBOutlet UITextField *counutryTextField;
@property (weak, nonatomic) IBOutlet UITextField *startTimeTextField;
@property (weak, nonatomic) IBOutlet UITextField *endTimeTextField;
//地接编号选择车队
@property (weak, nonatomic) IBOutlet UITextField *groundNoTextField;

/**
 渠道
 */
@property (nonatomic, strong) NSMutableArray *channelAry;

/**
 订单类型
 */
@property (nonatomic, strong) NSMutableArray *orderTypeAry;

/**
 地址列表
 */
@property (nonatomic, strong) NSMutableArray *addressAry;

/**
 城市地址
 */
@property (nonatomic, strong) NSMutableArray *cityAry;

/**
 地接编号列表
 */
@property (nonatomic, strong) GroundNumList *listModel;

/**
 国家地址
 */
@property (nonatomic, strong) XYECountryModel *countryModel;

@property (nonatomic, strong) XYEPlanInfo *planInfoModel;

//显示用户信息
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *userPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UIView *userView;

// 44 -- 100
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;

/**
 切换
 */
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

//接机
@property (nonatomic, strong) AirportView *airportView;
//送机
@property (nonatomic, strong) AirportOffView *airportOffView;
//包车
@property (nonatomic, strong) CharteredCarView *chartedCarView;
//单程接送
@property (nonatomic, strong) OneWayOfView *oneWayofView;
//民宿
@property (nonatomic, strong) HomestayView *homestayView;
//特色推荐
@property (nonatomic, strong) FeatureView *featureView;

/**
 选择使用车辆
 */
@property (nonatomic, strong) NSMutableArray *carList;

/**
 当前服务类型选择
 */
@property (nonatomic, strong) NSMutableDictionary *currentDic;

@end

@implementation XYEAddOrderViewController{
    NSString *country;
    NSString *city;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUI];
    self.scrollerViewTop.constant = NAV_HEIGHT;
    self.title = @"添加订单";
    
    [self requestData];
    [self requestCarListData];
    [self getCarLsitRequest];
    if (StringIsNullOrEmpty(self.model.order_type)) {
        self.model.order_type = @"1";
    }
    self.segment.selectedSegmentIndex = [self.model.order_type integerValue]-1;
    
    [self segmentControl:self.segment];
}

-(void)getCarLsitRequest{
    [self showLoading];
    [FYHTTPTOOL upload:FY_SHOWCARLIST parameters:nil formDataBlock:^(id<AFMultipartFormData> formData) {
        
    } progress:^(NSProgress *progress) {
        
    } completion:^(LMJBaseResponse *response) {
        [self dismissLoading];
        if (response.code == 10001) {
            [self.carList removeAllObjects];
            for (NSDictionary *dic in response.data[@"list"]) {
                [self.carList addObject:dic[@"car_name"]];
            }
        }else{
            [YFEasyHUD showMsgWithDefaultDelay:response.error?response.errorMsg:response.message];
        }
    }];
}

//切换
- (IBAction)segmentControl:(UISegmentedControl *)sender {
    self.model.order_type = [NSString stringWithFormat:@"%ld",sender.selectedSegmentIndex + 1];
    switch (sender.selectedSegmentIndex) {
        case 0:{
            self.airportView.hidden = NO;
            self.airportOffView.hidden = YES;
            self.chartedCarView.hidden = YES;
            self.oneWayofView.hidden = YES;
            self.homestayView.hidden = YES;
            self.featureView.hidden = YES;
            self.scrollerView.contentSize = CGSizeMake(kScreenWidth, CGRectGetHeight(self.contentView.frame) + CGRectGetHeight(self.airportView.frame));
        }
            break;
        case 1:{
            self.airportView.hidden = YES;
            self.airportOffView.hidden = NO;
            self.chartedCarView.hidden = YES;
            self.oneWayofView.hidden = YES;
            self.homestayView.hidden = YES;
            self.featureView.hidden = YES;
            self.scrollerView.contentSize = CGSizeMake(kScreenWidth, CGRectGetHeight(self.contentView.frame) + CGRectGetHeight(self.airportOffView.frame));
        }
            break;
        case 2:{
            self.airportView.hidden = YES;
            self.airportOffView.hidden = YES;
            self.chartedCarView.hidden = NO;
            self.oneWayofView.hidden = YES;
            self.homestayView.hidden = YES;
            self.featureView.hidden = YES;
            self.scrollerView.contentSize = CGSizeMake(kScreenWidth, CGRectGetHeight(self.contentView.frame) + CGRectGetHeight(self.chartedCarView.frame));
        }
            break;
        case 3:{
            self.airportView.hidden = YES;
            self.airportOffView.hidden = YES;
            self.chartedCarView.hidden = YES;
            self.oneWayofView.hidden = NO;
            self.homestayView.hidden = YES;
            self.featureView.hidden = YES;
            self.scrollerView.contentSize = CGSizeMake(kScreenWidth, CGRectGetHeight(self.contentView.frame) + CGRectGetHeight(self.oneWayofView.frame));
        }
            break;
        case 4:{
            self.airportView.hidden = YES;
            self.airportOffView.hidden = YES;
            self.chartedCarView.hidden = YES;
            self.oneWayofView.hidden = YES;
            self.homestayView.hidden = NO;
            self.featureView.hidden = YES;
            self.scrollerView.contentSize = CGSizeMake(kScreenWidth, CGRectGetHeight(self.contentView.frame) + CGRectGetHeight(self.homestayView.frame));
        }
            break;
        case 5:{
            self.airportView.hidden = YES;
            self.airportOffView.hidden = YES;
            self.chartedCarView.hidden = YES;
            self.oneWayofView.hidden = YES;
            self.homestayView.hidden = YES;
            self.featureView.hidden = NO;
            self.scrollerView.contentSize = CGSizeMake(kScreenWidth, CGRectGetHeight(self.contentView.frame) + CGRectGetHeight(self.featureView.frame));
        }
            break;

        default:
            break;
    }
    
    self.model.order_type = [NSString stringWithFormat:@"%ld",sender.selectedSegmentIndex + 1];
}

//获取用户信息
-(void)getUserinfo:(NSString *)str{
    [self showLoading];
    //存在飞鱼ID 则检索获取飞鱼数据
    [FYHTTPTOOL upload:FY_CHOOSEPLAN parameters:@{@"str":str} formDataBlock:^(id<AFMultipartFormData> formData) {
        
    } progress:^(NSProgress *progress) {
        
    } completion:^(LMJBaseResponse *response) {
        [self dismissLoading];
        if (response.code == 10001) {
            self.planInfoModel = [XYEPlanInfo mj_objectWithKeyValues:response.data];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self selectUserInfo:NO];
            });
        }
        else{
            [YFEasyHUD showMsgWithDefaultDelay:response.error?response.errorMsg:response.message];
        }
    }];
}

-(void)setupUI{
    [self.scrollerView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollerView.mas_top).mas_offset(20.0);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(756- 100.0 +44.0);
    }];
    //初始化数据
    self.orderTitleTextField.text = StringIsNullRetBlank(self.model.order_title);
    NSInteger channel = [self.model.channel integerValue]-1;
    if (channel >= 0) {
        self.chanalComeTextField.text = self.channelAry[channel];
    }
    
    self.clientNameTextField.text = StringIsNullRetBlank(self.model.client_name);
    self.clientWXTextField.text = StringIsNullRetBlank(self.model.client_wx);
    self.phoneTextField.text = StringIsNullRetBlank(self.model.client_phone);
    self.clientwwTextField.text = StringIsNullRetBlank(self.model.client_ww);
    
    self.counutryTextField.text = [NSString stringWithFormat:@"%@/%@",StringIsNullRetBlank(self.model.order_country),StringIsNullRetBlank(self.model.order_city)];
    if (StringIsNullOrEmpty(self.model.start_time)) {
        self.startTimeTextField.text = @"";
    }
    else{
        self.startTimeTextField.text = [self getDate:StringIsNullRetBlank(self.model.start_time)];
    }
    if (StringIsNullOrEmpty(self.model.end_time)) {
        self.endTimeTextField.text = @"";
    }
    else{
        self.endTimeTextField.text = [self getDate:StringIsNullRetBlank(self.model.end_time)];
    }

    self.chanalNoTextField.text = StringIsNullRetBlank(self.model.channel_number);
    if (!StringIsNullOrEmpty(self.model.plan_id)) {
        if (self.type != resetCommitType) {
            [self getUserinfo:self.model.plan_id];
        }
        else{
            self.model.plan_id = @"";
            self.userView.hidden = YES;
            self.heightConstraint.constant = 44.0;
            [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(756- 100.0 +44.0);
            }];
        }
    }
    else{
        self.userView.hidden = YES;
        self.heightConstraint.constant = 44.0;
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(756- 100.0 +44.0);
        }];
    }

    //选择车队
    self.groundNoTextField.text = StringIsNullRetBlank(self.model.ground_name);
    if ([self.model.ground_num integerValue] != 0) {
        self.groundNumTextField.text = StringIsNullRetBlank(self.model.ground_num);
        self.model.ground_num = [NSString stringWithFormat:@"%ld",[self.groundNumTextField.text integerValue]];
    }

    if (!StringIsNullOrEmpty(self.model.ground_num) && !StringIsNullOrEmpty(self.model.ground_name) ) {
        //查询服务数量
        [self getGroundNum:self.model.ground_name];
    }

    self.gotCostTextField.text = StringIsNullRetBlank(self.model.fish_cost);
    self.sysCostTextField.text = StringIsNullRetBlank(self.model.platform_cost);
    self.localCost.text = StringIsNullRetBlank(self.model.local_cost);
    
    //接机
    self.airportView.frame = CGRectMake(0, CGRectGetHeight(self.contentView.frame) - NAV_HEIGHT, kScreenWidth, CGRectGetHeight(self.airportView.frame));
    
    [self.scrollerView addSubview:self.airportView];
    
    [self.airportView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.view.mas_left).mas_offset(0);
        make.right.equalTo(self.view.mas_right).mas_offset(0);
        make.height.mas_equalTo(CGRectGetHeight(self.airportView.frame));
    }];
    
    self.scrollerView.contentSize = CGSizeMake(kScreenWidth, CGRectGetHeight(self.contentView.frame) + CGRectGetHeight(self.airportView.frame));

    //送机
    self.airportOffView.frame = CGRectMake(0, CGRectGetHeight(self.contentView.frame) - NAV_HEIGHT, kScreenWidth, CGRectGetHeight(self.airportOffView.frame));
    self.airportOffView.hidden = YES;
    [self.scrollerView addSubview:self.airportOffView];
    [self.airportOffView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.view.mas_left).mas_offset(0);
        make.right.equalTo(self.view.mas_right).mas_offset(0);
        make.height.mas_equalTo(CGRectGetHeight(self.airportOffView.frame));
    }];

    //包车
    self.chartedCarView.frame = CGRectMake(0, CGRectGetHeight(self.contentView.frame) - NAV_HEIGHT, kScreenWidth, CGRectGetHeight(self.chartedCarView.frame));
    self.chartedCarView.hidden = YES;
    [self.scrollerView addSubview:self.chartedCarView];
    [self.chartedCarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.view.mas_left).mas_offset(0);
        make.right.equalTo(self.view.mas_right).mas_offset(0);
        make.height.mas_equalTo(CGRectGetHeight(self.chartedCarView.frame));
    }];
    
    //单程接送
    self.oneWayofView.frame = CGRectMake(0, CGRectGetHeight(self.contentView.frame) - NAV_HEIGHT, kScreenWidth, CGRectGetHeight(self.oneWayofView.frame));
    self.oneWayofView.hidden = YES;
    [self.scrollerView addSubview:self.oneWayofView];
    [self.oneWayofView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.view.mas_left).mas_offset(0);
        make.right.equalTo(self.view.mas_right).mas_offset(0);
        make.height.mas_equalTo(CGRectGetHeight(self.oneWayofView.frame));
    }];
    
    //民宿
    self.homestayView.frame = CGRectMake(0, CGRectGetHeight(self.contentView.frame) - NAV_HEIGHT, kScreenWidth, CGRectGetHeight(self.homestayView.frame));
    self.homestayView.hidden = YES;
    [self.scrollerView addSubview:self.homestayView];
    [self.homestayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.view.mas_left).mas_offset(0);
        make.right.equalTo(self.view.mas_right).mas_offset(0);
        make.height.mas_equalTo(CGRectGetHeight(self.homestayView.frame));
    }];

    //特色玩法
    self.featureView.frame = CGRectMake(0, CGRectGetHeight(self.contentView.frame) - NAV_HEIGHT, kScreenWidth, CGRectGetHeight(self.featureView.frame));
    self.featureView.hidden = YES;
    [self.scrollerView addSubview:self.featureView];
    [self.featureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.view.mas_left).mas_offset(0);
        make.right.equalTo(self.view.mas_right).mas_offset(0);
        make.height.mas_equalTo(CGRectGetHeight(self.featureView.frame));
    }];
    
    [self setupOrderData];
}

-(void)setupOrderData{
    switch ([self.model.order_type integerValue]) {
        case 1:{
            self.airportView.adultTextField.text = StringIsNullRetString(self.model.adult, @"0");
            self.airportView.childTextField.text = StringIsNullRetString(self.model.child, @"0");
            self.airportView.luggageTextField.text = StringIsNullRetString(self.model.luggage, @"0");
            self.airportView.childSetTextField.text = StringIsNullRetString(self.model.childSeat, @"0");
            self.airportView.airportTextField.text = StringIsNullRetBlank(self.model.airport_name);
            self.airportView.flightNumTextField.text = StringIsNullRetBlank(self.model.flight_num);
            self.airportView.deliveTextField.text = StringIsNullRetBlank(self.model.delivered_site);
            self.airportView.selectCarTextField.text = StringIsNullRetBlank(self.model.car);
            self.airportView.prefixTextField.text = StringIsNullRetBlank(self.model.car_suf);
            self.airportView.noteTextField.text = StringIsNullRetBlank(self.model.order_notes);
        }
            break;
        case 2:{
            self.airportOffView.adultTextField.text = StringIsNullRetString(self.model.adult, @"0");
            self.airportOffView.childTextField.text = StringIsNullRetString(self.model.child, @"0");
            self.airportOffView.luggageTextField.text = StringIsNullRetString(self.model.luggage, @"0");
            self.airportOffView.childSetTextField.text = StringIsNullRetString(self.model.childSeat, @"0");
            self.airportOffView.airportTextField.text = StringIsNullRetBlank(self.model.airport_name);
            self.airportOffView.flightNumTextField.text = StringIsNullRetBlank(self.model.flight_num);
            self.airportOffView.departTextView.text = StringIsNullRetBlank(self.model.depart_site);
            self.airportOffView.selectCarTextField.text = StringIsNullRetBlank(self.model.car);
            self.airportOffView.prefixTextField.text = StringIsNullRetBlank(self.model.car_suf);
            self.airportOffView.noteTextField.text = StringIsNullRetBlank(self.model.order_notes);
        }
            break;
        case 3:{
            self.chartedCarView.adultTextField.text = StringIsNullRetString(self.model.adult, @"0");
            self.chartedCarView.childTextField.text = StringIsNullRetString(self.model.child, @"0");
            self.chartedCarView.luggageTextField.text = StringIsNullRetString(self.model.luggage, @"0");
            self.chartedCarView.childSetTextField.text = StringIsNullRetString(self.model.childSeat, @"0");
            self.chartedCarView.charteDayTextField.text = StringIsNullRetBlank(self.model.car_day);
            self.chartedCarView.deliveTextView.text = StringIsNullRetBlank(self.model.delivered_site);
            self.chartedCarView.departTextView.text = StringIsNullRetBlank(self.model.depart_site);
            self.chartedCarView.selectCarTextField.text = StringIsNullRetBlank(self.model.car);
            self.chartedCarView.prefixTextField.text = StringIsNullRetBlank(self.model.car_suf);
            self.chartedCarView.noteTextView.text = StringIsNullRetBlank(self.model.order_notes);
            self.chartedCarView.chartWayTextView.text = StringIsNullRetBlank(self.model.car_stroke);
        }
            break;
        case 4:{
            self.oneWayofView.adultTextField.text = StringIsNullRetString(self.model.adult, @"0");
            self.oneWayofView.childTextField.text = StringIsNullRetString(self.model.child, @"0");
            self.oneWayofView.luggageTextField.text = StringIsNullRetString(self.model.luggage, @"0");
            self.oneWayofView.childSetTextField.text = StringIsNullRetString(self.model.childSeat, @"0");
            self.oneWayofView.deliveTextView.text = StringIsNullRetBlank(self.model.delivered_site);
            self.oneWayofView.departTextView.text = StringIsNullRetBlank(self.model.depart_site);
            self.oneWayofView.selectCarTextField.text = StringIsNullRetBlank(self.model.car);
            self.oneWayofView.prefixTextField.text = StringIsNullRetBlank(self.model.car_suf);
            self.oneWayofView.noteTextView.text = StringIsNullRetBlank(self.model.order_notes);
        }
            break;
        case 5:{
            self.homestayView.homestayPopTextField.text = StringIsNullRetString(self.model.homestay_pop, @"0");
            self.homestayView.apartmentTextField.text = StringIsNullRetString(self.model.homestay_apartment, @"0");
            self.homestayView.homestayInfoTextView.text = StringIsNullRetString(self.model.homestay, @"");
            self.homestayView.noteTextView.text = StringIsNullRetBlank(self.model.order_notes);
        }
            break;
        case 6:{
            self.featureView.homestayPopTextField.text = StringIsNullRetString(self.model.adult, @"0");
            self.featureView.apartmentTextField.text = StringIsNullRetString(self.model.child, @"0");
            self.featureView.homestayInfoTextView.text = StringIsNullRetString(self.model.featureIntroduction, @"");
            self.featureView.noteTextView.text = StringIsNullRetBlank(self.model.order_notes);
        }
            break;

        default:
            break;
    }
}

- (IBAction)tap:(UITapGestureRecognizer *)sender {
    self.userView.hidden = YES;
    self.heightConstraint.constant = 44.0;
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(756-100.0+44.0);
    }];
    self.scrollerView.contentSize = CGSizeMake(kScreenWidth, CGRectGetHeight(self.contentView.frame) + CGRectGetHeight(self.airportView.frame)-NAV_HEIGHT);
}

//获取用户信息
-(void)getPlanUserinfo:(NSString *)str{
    [self showLoading];
    //存在飞鱼ID 则检索获取飞鱼数据
    [FYHTTPTOOL upload:FY_CHOOSEPLAN parameters:@{@"str":str} formDataBlock:^(id<AFMultipartFormData> formData) {
        
    } progress:^(NSProgress *progress) {
        
    } completion:^(LMJBaseResponse *response) {
        [self dismissLoading];
        if (response.code == 10001) {
            self.planInfoModel = [XYEPlanInfo mj_objectWithKeyValues:response.data];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self selectUserInfo:YES];
            });
        }
        else{
            [YFEasyHUD showMsgWithDefaultDelay:response.error?response.errorMsg:response.message];
        }
    }];
}

/**
 选择

 @param isSelect YES-需要选择 NO-不需要选择
 */
-(void)selectUserInfo:(BOOL)isSelect{
    if (!isSelect) {
        PlanUserInfo *info = [self.planInfoModel.list firstObject];
        self.userView.hidden = NO;
        self.heightConstraint.constant = 100.0;
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(756);
        }];
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:info.plan_avatar] placeholderImage:[UIImage imageNamed:@"defaultAvatar"]];
        self.addressLabel.text = [NSString stringWithFormat:@"国家地区:%@%@",info.plan_country,info.plan_city];
        self.userNameLabel.text = [NSString stringWithFormat:@"昵称:%@",info.plan_nick_name];
        self.userIdLabel.text = [NSString stringWithFormat:@"ID:%@",info.plan_id];
        self.userPhoneLabel.text = [NSString stringWithFormat:@"手机:%@",info.plan_phone];
        
        self.model.plan_id = info.plan_id;
    }
    else{
        NSMutableArray *list = [NSMutableArray arrayWithCapacity:0];
        for (PlanUserInfo *info in self.planInfoModel.list) {
            [list addObject:[NSString stringWithFormat:@"%@-%@-%@-%@%@",info.plan_id,info.plan_nick_name,info.plan_phone,info.plan_country,info.plan_city]];
        }
        [ZJPickerView zj_showWithDataList:list propertyDict:nil completion:^(NSString * _Nullable selectContent) {
            self.userView.hidden = NO;
            self.heightConstraint.constant = 100.0;
            [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(756);
            }];
            PlanUserInfo *userInfo = [PlanUserInfo new];
            for (PlanUserInfo *info in self.planInfoModel.list) {
                if ([selectContent containsString:info.plan_id]) {
                    userInfo = info;
                }
            }
            [self.headImageView sd_setImageWithURL:[NSURL URLWithString:userInfo.plan_avatar] placeholderImage:[UIImage imageNamed:@"defaultAvatar"]];
            self.addressLabel.text = [NSString stringWithFormat:@"国家地区:%@%@",userInfo.plan_country,userInfo.plan_city];
            self.userNameLabel.text = [NSString stringWithFormat:@"昵称:%@",userInfo.plan_nick_name];
            self.userIdLabel.text = [NSString stringWithFormat:@"ID:%@",userInfo.plan_id];
            self.userPhoneLabel.text = [NSString stringWithFormat:@"手机:%@",userInfo.plan_phone];
            
            self.model.plan_id = userInfo.plan_id;
        }];
    }
}

#pragma mark -- 懒加载
-(NSMutableDictionary *)currentDic{
    if (!_currentDic) {
        _currentDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    return _currentDic;
}

-(NSMutableArray *)carList{
    if (!_carList) {
        _carList = [NSMutableArray arrayWithCapacity:0];
    }
    return _carList;
}

-(AirportView *)airportView{
    if (!_airportView) {
        _airportView = [AirportView initAirportView];
        _airportView.carList = self.carList;
        _airportView.airportDic = [self.model mj_keyValues];
    }
    return _airportView;
}

-(AirportOffView *)airportOffView{
    if (!_airportOffView) {
        _airportOffView = [AirportOffView initAirportOffView];
        _airportOffView.carList = self.carList;
        _airportOffView.airportOffDic = [self.model mj_keyValues];

    }
    return _airportOffView;
}

-(CharteredCarView *)chartedCarView{
    if (!_chartedCarView) {
        _chartedCarView = [CharteredCarView initCharteredCarView];
        _chartedCarView.carList = self.carList;
        _chartedCarView.charteredDic = [self.model mj_keyValues];
    }
    return _chartedCarView;
}

-(OneWayOfView *)oneWayofView{
    if (!_oneWayofView) {
        _oneWayofView = [OneWayOfView initOneWayOfView];
        _oneWayofView.oneWayDic = [self.model mj_keyValues];
    }
    return _oneWayofView;
}

-(HomestayView *)homestayView{
    if (!_homestayView) {
        _homestayView = [HomestayView initHomestayView];
        _homestayView.homestayDic = [self.model mj_keyValues];
    }
    return _homestayView;
}

-(FeatureView *)featureView{
    if (!_featureView) {
        _featureView = [FeatureView initFeatureView];
        _featureView.featureDic = [self.model mj_keyValues];
    }
    return _featureView;
}

- (XYEPlanInfo *)planInfoModel{
    if (!_planInfoModel) {
        _planInfoModel = [XYEPlanInfo new];
    }
    return _planInfoModel;
}

-(XYEAddOrderModel *)model{
    if (!_model) {
        _model = [XYEAddOrderModel new];
    }
    return _model;
}

- (NSMutableArray *)channelAry{
    if (!_channelAry) {
        _channelAry = [NSMutableArray arrayWithArray:@[@"飞猪",@"小程序",@"美团",@"携程",@"马蜂窝"]];
    }
    return _channelAry;
}

-(NSMutableArray *)orderTypeAry{
    if (!_orderTypeAry) {
        _orderTypeAry = [NSMutableArray arrayWithArray:@[@"接机",@"送机",@"包车",@"单程接送",@"民宿",@"特色玩法"]];
    }
    return _orderTypeAry;
}

- (NSMutableArray *)addressAry{
    if (!_addressAry) {
        _addressAry = [NSMutableArray arrayWithCapacity:0];
    }
    return _addressAry;
}

-(NSMutableArray *)cityAry{
    if (!_cityAry) {
        _cityAry = [NSMutableArray arrayWithCapacity:0];
    }
    return _cityAry;
}

-(GroundNumList *)listModel{
    if (!_listModel) {
        _listModel = [GroundNumList new];
    }
    return _listModel;
}

-(XYECountryModel *)countryModel{
    if (!_countryModel) {
        _countryModel = [XYECountryModel new];
    }
    return _countryModel;
}

#pragma mark -- textFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.chanalComeTextField) {
        [self.view endEditing:YES];
        [[MOFSPickerManager shareManger] showPickerViewWithDataArray:self.channelAry tag:1 title:@"请选择渠道来源" cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(NSString * _Nonnull string) {
            self.chanalComeTextField.text = string;
            NSInteger count = 0 ;
            for (int i=0; i<self.channelAry.count; i++) {
                NSString *channel = self.channelAry[i];
                if ([channel isEqualToString:string]) {
                    count = i+1;
                }
            }
            self.model.channel = [NSString stringWithFormat:@"%ld",(long)count];
        } cancelBlock:^{
            
        }];

        return NO;
    }
    if (textField == self.counutryTextField) {
        [self.view endEditing:YES];
        [[MOFSPickerManager shareManger] showPickerViewWithDataArray:self.addressAry tag:2 title:@"请选择国家" cancelTitle:@"取消" commitTitle:@"完成" commitBlock:^(NSString * _Nonnull string) {
            country = string;
            self.counutryTextField.text = string;
            self.model.order_country = country;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self selectCity:string];
            });
        } cancelBlock:^{
        }];
        return NO;
    }
    if (textField == self.startTimeTextField) {
        [self.view endEditing:YES];
        PGDatePickManager *datePickManager = [[PGDatePickManager alloc] init];
        PGDatePicker *datePicker = datePickManager.datePicker;
        datePicker.datePickerMode = PGDatePickerModeDateHourMinuteSecond;
        datePicker.selectedDate = ^(NSDateComponents *dateComponents) {
            NSDate *date = [NSDate setYear:dateComponents.year month:dateComponents.month day:dateComponents.day hour:dateComponents.hour minute:dateComponents.minute second:dateComponents.second];
            NSString *dateStr = [date stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
            self.startTimeTextField.text = dateStr;
            self.model.start_time = [self getTamp:dateStr];
            
            if (StringIsNullOrEmpty(self.endTimeTextField.text)) {
                self.endTimeTextField.text = dateStr;
                self.model.end_time = [self getTamp:dateStr];
            }
        };
        [self.navigationController presentViewController:datePickManager animated:false completion:nil];
        
        return NO;
    }
    if (textField == self.endTimeTextField) {
        [self.view endEditing:YES];
        PGDatePickManager *datePickManager = [[PGDatePickManager alloc] init];
        PGDatePicker *datePicker = datePickManager.datePicker;
        datePicker.datePickerMode = PGDatePickerModeDateHourMinuteSecond;
        datePicker.selectedDate = ^(NSDateComponents *dateComponents) {
            NSDate *date = [NSDate setYear:dateComponents.year month:dateComponents.month day:dateComponents.day hour:dateComponents.hour minute:dateComponents.minute second:dateComponents.second];
            NSString *dateStr = [date stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
            self.endTimeTextField.text = dateStr;
            self.model.end_time = [self getTamp:dateStr];
        };
        [self.navigationController presentViewController:datePickManager animated:false completion:nil];
        
        return NO;
    }
    if (textField == self.groundNoTextField) {
        [self.view endEditing:YES];
        NSMutableArray *groundList = [NSMutableArray arrayWithCapacity:0];
        for (GroundNumSubList *subModel in self.listModel.list) {
            [groundList addObject:[NSString stringWithFormat:@"%@ --- %@",subModel.depict,subModel.fleet]];
        }
        [[MOFSPickerManager shareManger] showPickerViewWithDataArray:groundList tag:3 title:@"请选择车队编号" cancelTitle:@"不选择" commitTitle:@"完成" commitBlock:^(NSString * _Nonnull string) {
            NSString *fleet = @"";
            for (GroundNumSubList *subModel in self.listModel.list) {
                if ([string containsString:subModel.fleet]) {
                    fleet = subModel.fleet;
                }
            }
            self.groundNoTextField.text = fleet;
            self.model.ground_name = fleet;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self getGroundNum:fleet];
            });
            self.mustStartLabel.hidden = NO;
        } cancelBlock:^{
            self.mustStartLabel.hidden = YES;
            self.groundNoTextField.text = @"";
            self.model.ground_name = @"";
            self.serviceLabel.text = @"服务数:0";
            self.groundNumTextField.text = @"";
        }];
        return NO;
    }


    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField == self.orderTitleTextField) {
        self.model.order_title = self.orderTitleTextField.text;
    }
    if (textField == self.clientNameTextField) {
        self.model.client_name = self.clientNameTextField.text;
    }
    if (textField == self.phoneTextField) {
        self.model.client_phone = self.phoneTextField.text;
    }
    if (textField == self.clientWXTextField) {
        self.model.client_wx = self.clientWXTextField.text;
    }
    if (textField == self.clientwwTextField) {
        self.model.client_ww = self.clientwwTextField.text;
    }
    if (textField == self.chanalNoTextField) {
        self.model.channel_number = self.chanalNoTextField.text;
    }
    if (textField == self.groundNumTextField) {
        self.model.ground_num = [NSString stringWithFormat:@"%ld",[self.groundNumTextField.text integerValue]];
    }
    if (textField == self.gotCostTextField) {
        self.model.fish_cost = self.gotCostTextField.text;
    }
    if (textField == self.sysCostTextField) {
        self.model.platform_cost = self.sysCostTextField.text;
    }
    if (textField == self.localCost) {
        self.model.local_cost = self.localCost.text;
    }

    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.searchFYTextField) {
        [super textFieldShouldReturn:textField];
        [self getPlanUserinfo:textField.text];
    }
    return YES;
}

#pragma mark -- 获取地接编号
-(void)getGroundNum:(NSString *)num{
    NSString *startTime = StringIsNullRetBlank(self.model.start_time);
    NSString *endTime = StringIsNullRetBlank(self.model.end_time);
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    if (!StringIsNullOrEmpty(startTime)) {
        [dic setObject:[self getTamp:startTime] forKey:@"start_time"];
    }
    if (!StringIsNullOrEmpty(endTime)) {
        [dic setObject:[self getTamp:endTime] forKey:@"end_time"];
    }
    [dic setObject:num forKey:@"fleet"];
    [FYHTTPTOOL upload:FY_GROUNDCOUNT parameters:dic formDataBlock:^(id<AFMultipartFormData> formData) {
        
    } progress:^(NSProgress *progress) {
        
    } completion:^(LMJBaseResponse *response) {
        if (response.code == 10001) {
            NSString *ground_count = ((NSDictionary *)response.data[@"info"])[@"ground_count"];
            NSString *ground_num = ((NSDictionary *)response.data[@"info"])[@"ground_num"];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.serviceLabel.text = [NSString stringWithFormat:@"服务数:%ld",[ground_count integerValue]];
                self.groundNumTextField.text = ground_num;
                
                self.model.ground_num = [NSString stringWithFormat:@"%ld",[self.groundNumTextField.text integerValue]];
            });
        }
        else{
            [YFEasyHUD showMsgWithDefaultDelay:response.error?response.errorMsg:response.message];
        }
    }];
}

-(NSString *)getTamp:(NSString *)str{
    NSDate* date = [NSDate dateWithString:str format:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeInterval time=[date timeIntervalSince1970];// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    
    return timeString;
}

#pragma mark -- 选择国家地区
-(void)selectCity:(NSString *)ountry{
    [self showLoading];
    [FYHTTPTOOL upload:FY_CHOOSEREGION parameters:@{@"coun_name":ountry} formDataBlock:^(id<AFMultipartFormData> formData) {
        
    } progress:^(NSProgress *progress) {
        
    } completion:^(LMJBaseResponse *response) {
        [self dismissLoading];
        if (response.code == 10001) {
            [self.cityAry removeAllObjects];
            [self.cityAry addObjectsFromArray:response.data[@"list"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self selectCityData:self.cityAry];
            });
        }
        else{
            [YFEasyHUD showMsgWithDefaultDelay:response.error?response.errorMsg:response.message];
        }
    }];
}

-(void)selectCityData:(NSMutableArray *)cityArray{
    [ZJPickerView zj_showWithDataList:cityArray propertyDict:nil completion:^(NSString *selectContent) {
        city = selectContent;
        self.counutryTextField.text = [NSString stringWithFormat:@"%@/%@",country,city];
        self.model.order_city = city;
    }];
}

#pragma mark -- 获取国家地址
-(void)requestData{
    [self showLoading];
    LMJWeakSelf(self);
    [FYHTTPTOOL upload:FY_CHOOSEREGION parameters:nil formDataBlock:^(id<AFMultipartFormData> formData) {
        
    } progress:^(NSProgress *progress) {
        
    } completion:^(LMJBaseResponse *response) {
        [weakself dismissLoading];
        if (response.code == 10001) {
            weakself.countryModel = [XYECountryModel mj_objectWithKeyValues:response.data];
            for (XYECityModel *subModel in weakself.countryModel.list) {
                [self.addressAry addObject:subModel.coun_name];
            }
        }
        else{
            [YFEasyHUD showMsgWithDefaultDelay:response.error?response.errorMsg:response.message];
        }
    }];
}

#pragma mark -- 获取车队地接编号列表
-(void)requestCarListData{
    [self showLoading];
    LMJWeakSelf(self);
    [FYHTTPTOOL upload:FY_GROUNFLEET parameters:nil formDataBlock:^(id<AFMultipartFormData> formData) {
        
    } progress:^(NSProgress *progress) {
        
    } completion:^(LMJBaseResponse *response) {
        [weakself dismissLoading];
        if (response.code == 10001) {
            self.listModel = [GroundNumList mj_objectWithKeyValues:response.data];
        }
        else{
            [YFEasyHUD showMsgWithDefaultDelay:response.error?response.errorMsg:response.message];
        }
    }];
}


#pragma mark -- lmj_navgationBarDataSource
-(CGFloat)lmjNavigationHeight:(LMJNavigationBar *)navigationBar{
    navigationBar.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    navigationBar.layer.shadowOpacity = 0.8f;
    navigationBar.layer.shadowOffset = CGSizeMake(0,2);
    return NAV_HEIGHT;
}

/** 是否隐藏底部黑线 */
- (BOOL)lmjNavigationIsHideBottomLine:(LMJNavigationBar *)navigationBar
{
    return YES;
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return YES;
}

/** 导航条左边的按钮 */
- (UIImage *)lmjNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(LMJNavigationBar *)navigationBar
{
    return [UIImage imageNamed:@"navigationButtonReturn"];
}

#pragma mark - LMJNavUIBaseViewControllerDelegate
/** 左边的按钮的点击 */
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(LMJNavigationBar *)navigationBar
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIImage *)lmjNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(LMJNavigationBar *)navigationBar{
    [rightButton setTitle:@"提交" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    return nil;
}

-(void)rightButtonEvent:(UIButton *)sender navigationBar:(LMJNavigationBar *)navigationBar{
    [self.view endEditing:YES];
    switch (self.segment.selectedSegmentIndex) {
        case 0:{
            self.currentDic = self.airportView.airportDic;
            XYEAddOrderModel *sModel = [XYEAddOrderModel mj_objectWithKeyValues:self.currentDic];
            if (!StringIsNullOrEmpty(sModel.car)) {
                self.model.car = sModel.car;
            }
            self.model.adult = sModel.adult;
            self.model.child = sModel.child;
            self.model.luggage = sModel.luggage;
            self.model.childSeat = sModel.childSeat;
            if (!StringIsNullOrEmpty(sModel.car_suf)) {
                self.model.car_suf = sModel.car_suf;
            }
            if (!StringIsNullOrEmpty(sModel.airport_name)) {
                self.model.airport_name = sModel.airport_name;
            }
            if (!StringIsNullOrEmpty(sModel.flight_num)) {
                self.model.flight_num = sModel.flight_num;
            }
            if (!StringIsNullOrEmpty(sModel.delivered_site)) {
                self.model.delivered_site = sModel.delivered_site;
            }
            if (!StringIsNullOrEmpty(sModel.order_notes)) {
                self.model.order_notes = sModel.order_notes;
            }
        }
            break;
        case 1:{
            self.currentDic = self.airportOffView.airportOffDic;
            XYEAddOrderModel *sModel = [XYEAddOrderModel mj_objectWithKeyValues:self.currentDic];
            if (!StringIsNullOrEmpty(sModel.car)) {
                self.model.car = sModel.car;
            }
            self.model.adult = sModel.adult;
            self.model.child = sModel.child;
            self.model.luggage = sModel.luggage;
            self.model.childSeat = sModel.childSeat;
            if (!StringIsNullOrEmpty(sModel.car_suf)) {
                self.model.car_suf = sModel.car_suf;
            }
            if (!StringIsNullOrEmpty(sModel.airport_name)) {
                self.model.airport_name = sModel.airport_name;
            }
            if (!StringIsNullOrEmpty(sModel.flight_num)) {
                self.model.flight_num = sModel.flight_num;
            }
            if (!StringIsNullOrEmpty(sModel.depart_site)) {
                self.model.depart_site = sModel.depart_site;
            }
            if (!StringIsNullOrEmpty(sModel.order_notes)) {
                self.model.order_notes = sModel.order_notes;
            }
        }
            break;
        case 2:{
            self.currentDic = self.chartedCarView.charteredDic;
            XYEAddOrderModel *sModel = [XYEAddOrderModel mj_objectWithKeyValues:self.currentDic];
            if (!StringIsNullOrEmpty(sModel.car)) {
                self.model.car = sModel.car;
            }
            self.model.adult = sModel.adult;
            self.model.child = sModel.child;
            self.model.luggage = sModel.luggage;
            self.model.childSeat = sModel.childSeat;
            self.model.car_day = sModel.car_day;
            if (!StringIsNullOrEmpty(sModel.car_suf)) {
                self.model.car_suf = sModel.car_suf;
            }
            if (!StringIsNullOrEmpty(sModel.delivered_site)) {
                self.model.delivered_site = sModel.delivered_site;
            }
            if (!StringIsNullOrEmpty(sModel.depart_site)) {
                self.model.depart_site = sModel.depart_site;
            }
            if (!StringIsNullOrEmpty(sModel.car_stroke)) {
                self.model.car_stroke = sModel.car_stroke;
            }
            if (!StringIsNullOrEmpty(sModel.order_notes)) {
                self.model.order_notes = sModel.order_notes;
            }
        }
            break;
        case 3:{
            self.currentDic = self.oneWayofView.oneWayDic;
            XYEAddOrderModel *sModel = [XYEAddOrderModel mj_objectWithKeyValues:self.currentDic];
            if (!StringIsNullOrEmpty(sModel.car)) {
                self.model.car = sModel.car;
            }
            self.model.adult = sModel.adult;
            self.model.child = sModel.child;
            self.model.luggage = sModel.luggage;
            self.model.childSeat = sModel.childSeat;
            if (!StringIsNullOrEmpty(sModel.car_suf)) {
                self.model.car_suf = sModel.car_suf;
            }
            if (!StringIsNullOrEmpty(sModel.delivered_site)) {
                self.model.delivered_site = sModel.delivered_site;
            }
            if (!StringIsNullOrEmpty(sModel.depart_site)) {
                self.model.depart_site = sModel.depart_site;
            }
            if (!StringIsNullOrEmpty(sModel.order_notes)) {
                self.model.order_notes = sModel.order_notes;
            }
        }
            break;
        case 4:{
            self.currentDic = self.homestayView.homestayDic;
            XYEAddOrderModel *sModel = [XYEAddOrderModel mj_objectWithKeyValues:self.currentDic];
            self.model.homestay_pop = sModel.homestay_pop;
            self.model.homestay_apartment = sModel.homestay_apartment;
            if (!StringIsNullOrEmpty(sModel.homestay)) {
                self.model.homestay = sModel.homestay;
            }
            if (!StringIsNullOrEmpty(sModel.order_notes)) {
                self.model.order_notes = sModel.order_notes;
            }
        }
            break;
        case 5:{
            self.currentDic = self.featureView.featureDic;
            XYEAddOrderModel *sModel = [XYEAddOrderModel mj_objectWithKeyValues:self.currentDic];
            self.model.adult = sModel.adult;
            self.model.child = sModel.child;
            if (!StringIsNullOrEmpty(sModel.featureIntroduction)) {
                self.model.featureIntroduction = sModel.featureIntroduction;
            }

            if (!StringIsNullOrEmpty(sModel.order_notes)) {
                self.model.order_notes = sModel.order_notes;
            }
        }
            break;

        default:
            break;
    }
    NSString *urlStr = FY_ORDERCREATE;
    if (self.type == updateType) {
        urlStr = FY_ORDERUPDATE;
    }
    [self showLoading];
    LMJWeakSelf(self);
    [FYHTTPTOOL upload:urlStr parameters:[self.model mj_keyValues] formDataBlock:^(id<AFMultipartFormData> formData) {
    } progress:^(NSProgress *progress) {
    } completion:^(LMJBaseResponse *response) {
        [weakself dismissLoading];
        if (response.code == 10001) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.navigationController popViewControllerAnimated:YES];
            });
        }
        else{
            [YFEasyHUD showMsgWithDefaultDelay:response.error?response.errorMsg:response.message];
        }
    }];
}

/**
 通过时间戳获取时间

 @param timeStampString <#timeStampString description#>
 @return <#return value description#>
 */
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
