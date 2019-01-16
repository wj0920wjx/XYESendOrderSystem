//
//  XYESearchViewController.m
//  JY
//
//  Created by 澳达国际 on 2019/1/10.
//  Copyright © 2019 飞鱼旅行. All rights reserved.
//

#import "XYESearchViewController.h"
#import <MOFSPickerManager/MOFSPickerManager.h>
#import "PGDatePickManager.h"
#import "XYECountryModel.h"
#import "ZJPickerView.h"

@interface XYESearchViewController ()<UITextFieldDelegate>
/**
 订单编号
 */
@property (weak, nonatomic) IBOutlet UITextField *orderNoTextField;

/**
 飞鱼姓名
 */
@property (weak, nonatomic) IBOutlet UITextField *planNameTextField;

/**
 飞鱼ID
 */
@property (weak, nonatomic) IBOutlet UITextField *planNoTextField;

/**
 订单状态
 */
@property (weak, nonatomic) IBOutlet UITextField *orderStatusTextField;

/**
 订单类型
 */
@property (weak, nonatomic) IBOutlet UITextField *orderTypeTextField;

/**
 客户名称
 */
@property (weak, nonatomic) IBOutlet UITextField *clientNameTextField;

/**
 订单标题
 */
@property (weak, nonatomic) IBOutlet UITextField *orderTitleTextField;

/**
 手机号
 */
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

/**
 渠道编号
 */
@property (weak, nonatomic) IBOutlet UITextField *chanalNoTextField;

/**
 地接编号
 */
@property (weak, nonatomic) IBOutlet UITextField *grounNoTextField;

/**
 客服
 */
@property (weak, nonatomic) IBOutlet UITextField *kfTextField;

/**
 国家地区
 */
@property (weak, nonatomic) IBOutlet UITextField *countryTextField;

/**
 列表排序
 */
@property (weak, nonatomic) IBOutlet UITextField *sortTypeTextField;

@property (weak, nonatomic) IBOutlet UITextField *serviceStartTextField;
@property (weak, nonatomic) IBOutlet UITextField *serviceEndTextField;

@property (weak, nonatomic) IBOutlet UITextField *orderStartTextField;
@property (weak, nonatomic) IBOutlet UITextField *orderEndTextField;

@property (weak, nonatomic) IBOutlet UITextField *creatStartTextField;
@property (weak, nonatomic) IBOutlet UITextField *creatEndTextField;

/**
 订单状态字典
 */
@property (nonatomic, strong) NSMutableDictionary *orderStatusDic;

/**
 订单类型字典
 */
@property (nonatomic, strong) NSMutableDictionary *orderTypeDic;

/**
 列表排序
 */
@property (nonatomic, strong) NSMutableDictionary *sortDic;

/**
 地址列表
 */
@property (nonatomic, strong) NSMutableArray *addressAry;

/**
 城市地址
 */
@property (nonatomic, strong) NSMutableArray *cityAry;

@property (nonatomic, strong) XYECountryModel *model;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toponeConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toptwoConstraint;

@end

@implementation XYESearchViewController{
    NSString *country;
    NSString *city;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"搜索条件";
    
    _toponeConstraint.constant = _toptwoConstraint.constant = NAV_HEIGHT;
    
    [self upsetUI];
    
    [self requestData];
}

-(void)requestData{
    [self showLoading];
    LMJWeakSelf(self);
    [FYHTTPTOOL upload:FY_CHOOSEREGION parameters:nil formDataBlock:^(id<AFMultipartFormData> formData) {
        
    } progress:^(NSProgress *progress) {
        
    } completion:^(LMJBaseResponse *response) {
        [weakself dismissLoading];
        if (response.code == 10001) {
            weakself.model = [XYECountryModel mj_objectWithKeyValues:response.data];
            for (XYECityModel *subModel in weakself.model.list) {
                [self.addressAry addObject:subModel.coun_name];
            }
        }
        else{
            [YFEasyHUD showMsgWithDefaultDelay:response.error?response.errorMsg:response.message];
        }
    }];
}

-(void)upsetUI{
    NSString *order_id = self.searchDic[@"order_id"];
    self.orderNoTextField.text = StringIsNullRetBlank(order_id);
    
    NSString *order_title = self.searchDic[@"order_title"];
    self.orderTitleTextField.text = StringIsNullRetBlank(order_title);
    
    NSString *plan_id = self.searchDic[@"plan_id"];
    self.planNoTextField.text = StringIsNullRetBlank(plan_id);
    
    NSString *plan_nick_name = self.searchDic[@"plan_nick_name"];
    self.planNameTextField.text = StringIsNullRetBlank(plan_nick_name);
    
    NSString *client_name = self.searchDic[@"client_name"];
    self.clientNameTextField.text = StringIsNullRetBlank(client_name);
    
    NSString *client_phone = self.searchDic[@"client_phone"];
    self.phoneTextField.text = StringIsNullRetBlank(client_phone);
    
    //    NSString *client_wx = self.searchDic[@"client_wx"];
    NSString *channel_number = self.searchDic[@"channel_number"];
    self.chanalNoTextField.text = StringIsNullRetBlank(channel_number);
    
    NSString *kf_creator = self.searchDic[@"kf_creator"];
    self.kfTextField.text = StringIsNullRetBlank(kf_creator);
    
    NSString *ground_name_num = self.searchDic[@"ground_name_num"];
    self.grounNoTextField.text = StringIsNullRetBlank(ground_name_num);
    
    NSString *start_time = self.searchDic[@"start_time"];
    self.serviceStartTextField.text = StringIsNullRetBlank(start_time);
    
    NSString *end_time = self.searchDic[@"end_time"];
    self.serviceEndTextField.text = StringIsNullRetBlank(end_time);
    
    NSString *choose_type = self.searchDic[@"choose_type"];
    if (!StringIsNullOrEmpty(choose_type)) {
        for (NSString *key in self.orderStatusDic.allKeys) {
            NSString *value = self.orderStatusDic[key];
            if ([value isEqualToString:choose_type]) {
                choose_type = key;
            }
        }
        self.orderStatusTextField.text = StringIsNullRetBlank(choose_type);
    }
    
    NSString *order_country = self.searchDic[@"order_country"];
    
    NSString *order_city = self.searchDic[@"order_city"];
    
    self.countryTextField.text = [NSString stringWithFormat:@"%@/%@",StringIsNullRetBlank(order_country),StringIsNullRetBlank(order_city)];
    
    NSString *principal_ktime = self.searchDic[@"principal_ktime"];
    self.orderStartTextField.text = StringIsNullRetBlank(principal_ktime);
    
    NSString *principal_etime = self.searchDic[@"principal_etime"];
    self.orderEndTextField.text = StringIsNullRetBlank(principal_etime);
    
    NSString *created_at_ktime = self.searchDic[@"created_at_ktime"];
    self.creatStartTextField.text = StringIsNullRetBlank(created_at_ktime);
    
    NSString *created_at_etime = self.searchDic[@"created_at_etime"];
    self.creatEndTextField.text = StringIsNullRetBlank(created_at_etime);
    
    NSString *sequence = self.searchDic[@"sequence"];
    if (!StringIsNullOrEmpty(sequence)) {
        for (NSString *key in self.sortDic.allKeys) {
            NSString *value = self.sortDic[key];
            if ([value isEqualToString:sequence]) {
                sequence = key;
            }
        }
        self.sortTypeTextField.text = StringIsNullRetBlank(sequence);
    }
    
    NSString *order_type = self.searchDic[@"order_type"];
    if (!StringIsNullOrEmpty(order_type)) {
        for (NSString *key in self.orderTypeDic.allKeys) {
            NSString *value = self.orderTypeDic[key];
            if ([value isEqualToString:order_type]) {
                order_type = key;
            }
        }
        self.orderTypeTextField.text = StringIsNullRetBlank(order_type);
    }
}

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
        self.countryTextField.text = [NSString stringWithFormat:@"%@/%@",country,city];
        
        [self.searchDic setObject:city forKey:@"order_city"];
    }];
}

#pragma mark -- textFieldDelegate
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField == self.orderNoTextField) {
        [self.searchDic setObject:self.orderNoTextField.text forKey:@"order_id"];
        if (StringIsNullOrEmpty(self.orderNoTextField.text)) {
            [self.searchDic removeObjectForKey:@"order_id"];
        }
    }
    if (textField == self.planNameTextField) {
        [self.searchDic setObject:self.planNameTextField.text forKey:@"plan_nick_name"];
        if (StringIsNullOrEmpty(self.planNameTextField.text)) {
            [self.searchDic removeObjectForKey:@"plan_nick_name"];
        }
    }
    if (textField == self.planNoTextField) {
        [self.searchDic setObject:self.planNoTextField.text forKey:@"plan_id"];
        if (StringIsNullOrEmpty(self.planNoTextField.text)) {
            [self.searchDic removeObjectForKey:@"plan_id"];
        }
    }
    if (textField == self.clientNameTextField) {
        [self.searchDic setObject:self.clientNameTextField.text forKey:@"client_name"];
        if (StringIsNullOrEmpty(self.clientNameTextField.text)) {
            [self.searchDic removeObjectForKey:@"client_name"];
        }
    }
    if (textField == self.orderTitleTextField) {
        [self.searchDic setObject:self.orderTitleTextField.text forKey:@"order_title"];
        if (StringIsNullOrEmpty(self.orderTitleTextField.text)) {
            [self.searchDic removeObjectForKey:@"order_title"];
        }
    }
    if (textField == self.phoneTextField) {
        [self.searchDic setObject:self.phoneTextField.text forKey:@"client_phone"];
        if (StringIsNullOrEmpty(self.phoneTextField.text)) {
            [self.searchDic removeObjectForKey:@"client_phone"];
        }
    }
    if (textField == self.chanalNoTextField) {
        [self.searchDic setObject:self.chanalNoTextField.text forKey:@"channel_number"];
        if (StringIsNullOrEmpty(self.chanalNoTextField.text)) {
            [self.searchDic removeObjectForKey:@"channel_number"];
        }
    }
    if (textField == self.grounNoTextField) {
        [self.searchDic setObject:self.grounNoTextField.text forKey:@"ground_name_num"];
        if (StringIsNullOrEmpty(self.grounNoTextField.text)) {
            [self.searchDic removeObjectForKey:@"ground_name_num"];
        }
    }
    if (textField == self.kfTextField) {
        [self.searchDic setObject:self.kfTextField.text forKey:@"kf_creator"];
        if (StringIsNullOrEmpty(self.kfTextField.text)) {
            [self.searchDic removeObjectForKey:@"kf_creator"];
        }
    }
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.orderStatusTextField) {
        [[MOFSPickerManager shareManger] showPickerViewWithDataArray:@[@"全部",@"未派单",@"待接单",@"服务中",@"结算中",@"结算中：主管待审核",@"结算中：CEO待审核",@"已完成",@"已取消",@"已取消：未派单",@"已取消：已派单"] tag:0 title:@"请选择订单状态" cancelTitle:@"取消" commitTitle:@"完成" commitBlock:^(NSString * _Nonnull string) {
            self.orderStatusTextField.text = string;
            [self.searchDic setObject:self.orderStatusDic[string] forKey:@"choose_type"];
            if (StringIsNullOrEmpty(self.orderStatusDic[string])) {
                [self.searchDic removeObjectForKey:@"choose_type"];
            }
        } cancelBlock:^{
            
        }];
        return NO;
    }
    if (textField == self.orderTypeTextField) {
        [[MOFSPickerManager shareManger] showPickerViewWithDataArray:@[@"全部",@"接机",@"送机",@"包车",@"单程接送",@"民宿",@"特色玩法"] tag:1 title:@"请选择订单类型" cancelTitle:@"取消" commitTitle:@"完成" commitBlock:^(NSString * _Nonnull string) {
            self.orderTypeTextField.text = string;
            [self.searchDic setObject:self.orderTypeDic[string] forKey:@"order_type"];
            if (StringIsNullOrEmpty(self.orderTypeDic[string])) {
                [self.searchDic removeObjectForKey:@"order_type"];
            }
        } cancelBlock:^{
            
        }];
        return NO;
    }
    if (textField == self.sortTypeTextField) {
        [[MOFSPickerManager shareManger] showPickerViewWithDataArray:@[@"最新创建",@"服务开始时间正序",@"服务开始时间倒序",@"派单时间正序",@"派单时间倒序",@"结束时间正序",@"结束时间倒序"] tag:2 title:@"请选择列表排序" cancelTitle:@"取消" commitTitle:@"完成" commitBlock:^(NSString * _Nonnull string) {
            self.sortTypeTextField.text = string;
            [self.searchDic setObject:self.sortDic[string] forKey:@"sequence"];
        } cancelBlock:^{
            
        }];
        return NO;
    }
    if (textField == self.countryTextField) {
        [[MOFSPickerManager shareManger] showPickerViewWithDataArray:self.addressAry tag:3 title:@"请选择国家" cancelTitle:@"取消" commitTitle:@"完成" commitBlock:^(NSString * _Nonnull string) {
            country = string;
            self.countryTextField.text = string;
            [self.searchDic setObject:country forKey:@"order_country"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self selectCity:string];
            });
        } cancelBlock:^{
        }];
        return NO;
    }
    if (textField == self.serviceStartTextField) {
        PGDatePickManager *datePickManager = [[PGDatePickManager alloc] init];
        PGDatePicker *datePicker = datePickManager.datePicker;
        datePicker.datePickerMode = PGDatePickerModeDateHourMinuteSecond;
        datePicker.selectedDate = ^(NSDateComponents *dateComponents) {
            NSDate *date = [NSDate setYear:dateComponents.year month:dateComponents.month day:dateComponents.day hour:dateComponents.hour minute:dateComponents.minute second:dateComponents.second];
            NSString *dateStr = [date stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
            self.serviceStartTextField.text = dateStr;
            [self.searchDic setObject:dateStr forKey:@"start_time"];
            
            if (StringIsNullOrEmpty(self.serviceEndTextField.text)) {
                self.serviceEndTextField.text = dateStr;
                [self.searchDic setObject:dateStr forKey:@"end_time"];
            }
        };
        [self.navigationController presentViewController:datePickManager animated:false completion:nil];
        
        return NO;
    }
    if (textField == self.serviceEndTextField) {
        PGDatePickManager *datePickManager = [[PGDatePickManager alloc] init];
        PGDatePicker *datePicker = datePickManager.datePicker;
        datePicker.datePickerMode = PGDatePickerModeDateHourMinuteSecond;
        datePicker.selectedDate = ^(NSDateComponents *dateComponents) {
            NSDate *date = [NSDate setYear:dateComponents.year month:dateComponents.month day:dateComponents.day hour:dateComponents.hour minute:dateComponents.minute second:dateComponents.second];
            NSString *dateStr = [date stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
            self.serviceEndTextField.text = dateStr;
            [self.searchDic setObject:dateStr forKey:@"end_time"];
        };
        [self.navigationController presentViewController:datePickManager animated:false completion:nil];
        return NO;
    }
    if (textField == self.orderStartTextField) {
        PGDatePickManager *datePickManager = [[PGDatePickManager alloc] init];
        PGDatePicker *datePicker = datePickManager.datePicker;
        datePicker.datePickerMode = PGDatePickerModeDateHourMinuteSecond;
        datePicker.selectedDate = ^(NSDateComponents *dateComponents) {
            NSDate *date = [NSDate setYear:dateComponents.year month:dateComponents.month day:dateComponents.day hour:dateComponents.hour minute:dateComponents.minute second:dateComponents.second];
            NSString *dateStr = [date stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
            self.orderStartTextField.text = dateStr;
            [self.searchDic setObject:dateStr forKey:@"principal_ktime"];
            if (StringIsNullOrEmpty(self.orderEndTextField.text)) {
                self.orderEndTextField.text = dateStr;
                [self.searchDic setObject:dateStr forKey:@"principal_etime"];
            }
        };
        [self.navigationController presentViewController:datePickManager animated:false completion:nil];
        return NO;
    }
    if (textField == self.orderEndTextField) {
        PGDatePickManager *datePickManager = [[PGDatePickManager alloc] init];
        PGDatePicker *datePicker = datePickManager.datePicker;
        datePicker.datePickerMode = PGDatePickerModeDateHourMinuteSecond;
        datePicker.selectedDate = ^(NSDateComponents *dateComponents) {
            NSDate *date = [NSDate setYear:dateComponents.year month:dateComponents.month day:dateComponents.day hour:dateComponents.hour minute:dateComponents.minute second:dateComponents.second];
            NSString *dateStr = [date stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
            self.orderEndTextField.text = dateStr;
            [self.searchDic setObject:dateStr forKey:@"principal_etime"];
        };
        [self.navigationController presentViewController:datePickManager animated:false completion:nil];
        
        return NO;
    }
    if (textField == self.creatStartTextField) {
        PGDatePickManager *datePickManager = [[PGDatePickManager alloc] init];
        PGDatePicker *datePicker = datePickManager.datePicker;
        datePicker.datePickerMode = PGDatePickerModeDateHourMinuteSecond;
        datePicker.selectedDate = ^(NSDateComponents *dateComponents) {
            NSDate *date = [NSDate setYear:dateComponents.year month:dateComponents.month day:dateComponents.day hour:dateComponents.hour minute:dateComponents.minute second:dateComponents.second];
            NSString *dateStr = [date stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
            self.creatStartTextField.text = dateStr;
            [self.searchDic setObject:dateStr forKey:@"created_at_ktime"];
            if (StringIsNullOrEmpty(self.creatEndTextField.text)) {
                self.creatEndTextField.text = dateStr;
                [self.searchDic setObject:dateStr forKey:@"created_at_etime"];
            }
        };
        [self.navigationController presentViewController:datePickManager animated:false completion:nil];
        return NO;
    }
    if (textField == self.creatEndTextField) {
        PGDatePickManager *datePickManager = [[PGDatePickManager alloc] init];
        PGDatePicker *datePicker = datePickManager.datePicker;
        datePicker.datePickerMode = PGDatePickerModeDateHourMinuteSecond;
        datePicker.selectedDate = ^(NSDateComponents *dateComponents) {
            NSDate *date = [NSDate setYear:dateComponents.year month:dateComponents.month day:dateComponents.day hour:dateComponents.hour minute:dateComponents.minute second:dateComponents.second];
            NSString *dateStr = [date stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
            self.creatEndTextField.text = dateStr;
            [self.searchDic setObject:dateStr forKey:@"created_at_etime"];
        };
        [self.navigationController presentViewController:datePickManager animated:false completion:nil];
        return NO;
    }
    
    return YES;
}

#pragma mark -- 懒加载
-(XYECountryModel *)model{
    if (!_model) {
        _model = [XYECountryModel new];
    }
    return _model;
}

-(NSMutableDictionary *)orderStatusDic{
    if (!_orderStatusDic) {
        _orderStatusDic = [[NSMutableDictionary alloc] initWithDictionary:@{@"全部":@"",@"未派单":@"1",@"待接单":@"2",@"服务中":@"3",@"结算中":@"4",@"结算中：主管待审核":@"7",@"结算中：CEO待审核":@"8",@"已完成":@"5",@"已取消":@"6",@"已取消：未派单":@"9",@"已取消：已派单":@"10"}];
    }
    return _orderStatusDic;
}

-(NSMutableDictionary *)orderTypeDic{
    if (!_orderTypeDic) {
        _orderTypeDic = [[NSMutableDictionary alloc] initWithDictionary:@{@"全部":@"",@"接机":@"1",@"送机":@"2",@"包车":@"3",@"单程接送":@"4",@"民宿":@"5",@"特色玩法":@"6"}];
    }
    return _orderTypeDic;
}

-(NSMutableDictionary *)sortDic{
    if (!_sortDic) {
        _sortDic = [[NSMutableDictionary alloc] initWithDictionary:@{@"最新创建":@"0",@"服务开始时间正序":@"1",@"服务开始时间倒序":@"2",@"派单时间正序":@"3",@"派单时间倒序":@"4",@"结束时间正序":@"5",@"结束时间倒序":@"6"}];
    }
    return _sortDic;
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

- (NSMutableDictionary *)searchDic{
    if (!_searchDic) {
        _searchDic = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _searchDic;
}

#pragma mark -- lmj_navgationBarDataSource
-(CGFloat)lmjNavigationHeight:(LMJNavigationBar *)navigationBar{
    navigationBar.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    navigationBar.layer.shadowOpacity = 0.8f;
    navigationBar.layer.shadowOffset = CGSizeMake(0,2);
    return NAV_HEIGHT;
}

-(UIColor *)lmjNavigationBackgroundColor:(LMJNavigationBar *)navigationBar{
    return [UIColor baseGreyColor];
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

/**
 navigationBar代理
 
 @param rightButton <#rightButton description#>
 @param navigationBar <#navigationBar description#>
 @return <#return value description#>
 */
- (UIImage *)lmjNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(LMJNavigationBar *)navigationBar{
    [rightButton setTitle:@"搜索" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    return nil;
}

-(void)rightButtonEvent:(UIButton *)sender navigationBar:(LMJNavigationBar *)navigationBar{
    [self.view endEditing:YES];
    if (self.block) {
        self.block(self.searchDic);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
