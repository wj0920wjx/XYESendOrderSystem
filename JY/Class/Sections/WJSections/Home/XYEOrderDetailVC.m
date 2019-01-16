//
//  XYEOrderDetailVC.m
//  JY
//
//  Created by 澳达国际 on 2019/1/14.
//  Copyright © 2019 飞鱼旅行. All rights reserved.
//

#import "XYEOrderDetailVC.h"
#import "XYEAddOrderModel.h"
#import "XYEAddOrderViewController.h"
#import "RemarkTableViewCell.h"
#import "XYEDriverInfo.h"
#import "ShowHistoryView.h"

#define STATUSBTNWIDTH ((kScreenWidth-30.0-30.0)/4.0)
#define STATUSBTNHEIGHT 40.0f
#define HISTORYHEIGHT 580.0f

@interface XYEOrderDetailVC ()

@property (nonatomic, strong)XYEAddOrderModel *orderModel;

@property (nonatomic, strong)XYEDriverInfo *driverInfo;

@property (nonatomic, strong)ShowHistoryView *showHistoryView;

@property (nonatomic, strong) NSMutableArray *dataAry;

@property (nonatomic, strong) UIView *footView;

/**
 1-回访 -> 2-hidden -> 3-hidden -> 4-hidden -> 5-hidden -> 6-hidden
 */
@property (nonatomic, strong) UIButton *showVisitBtn;

/**
 1-编辑  -> 2-hidden -> 3-hidden -> 4-回访 -> 5-hidden -> 6-hidden
 */
@property (nonatomic, strong) UIButton *editBtn;

/**
 1-主管派单 -> 2-回访 -> 3-回访 -> 4-取消 -> 5-回访 -> 6-hidden
 */
@property (nonatomic, strong) UIButton *orderBtn;

/**
 1-取消 -> 2-取消  -> 3-取消  -> 4-主管确认 -> 5-BOSS确认 -> 6-回访
 */
@property (nonatomic, strong) UIButton *cancelBtn;

/**
 额外备注
 */
@property (nonatomic, strong) UIButton *remarkBtn;

@end

@implementation XYEOrderDetailVC{
    BOOL isFade;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestData];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    isFade = YES;
    self.tableView.mj_footer = nil;
    
    self.title = self.model.order_title;
    
    UIEdgeInsets inset = self.tableView.contentInset;
    inset.bottom = SAFEAREA_HEIGHT;
    self.tableView.contentInset = inset;
    
    [self.tableView setTableFooterView:self.footView];
    
    [self.tableView setShowsVerticalScrollIndicator:NO];
    [self.tableView setShowsHorizontalScrollIndicator:NO];
    
    self.showHistoryView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, HISTORYHEIGHT);
    self.showHistoryView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.showHistoryView.layer.shadowOpacity = 0.8f;
    self.showHistoryView.layer.shadowOffset = CGSizeMake(0,-3);
    [self.view addSubview:self.showHistoryView];
    [self.view bringSubviewToFront:self.showHistoryView];
}

-(void)loadMore:(BOOL)isMore{
    if (!isMore) {
        [self requestData];
    }
}

-(void)requestData{
    [self showLoading];
    LMJWeakSelf(self);
    [FYHTTPTOOL upload:FY_SHOWDETAIL parameters:@{@"order_id":self.model.Id} formDataBlock:^(id<AFMultipartFormData> formData) {
        
    } progress:^(NSProgress *progress) {
        
    } completion:^(LMJBaseResponse *response) {
        [weakself endHeaderFooterRefreshing];
        [weakself dismissLoading];
        if (response.code == 10001) {
            weakself.orderModel = [XYEAddOrderModel mj_objectWithKeyValues:response.data[@"info"]];
            weakself.driverInfo = [XYEDriverInfo mj_objectWithKeyValues:response.data[@"driver_info"]];
            [weakself sortAry];
            [weakself changeStatus];
            [weakself.tableView reloadData];
        }else{
            [YFEasyHUD showMsgWithDefaultDelay:response.error?response.errorMsg:response.message];
        }
    }];
}

#pragma mark -- 按钮相应
//查看回访
-(void)showVisitBtnClick:(UIButton *)btn{
    if (![[LTUserManager sharedManager].permissions containsObject:@127]) {
        [YFEasyHUD showMsgWithDefaultDelay:@"无查看订单回访记录权限"];
        return;
    }
    [self.showHistoryView requestData:self.model.Id];
    [UIView animateWithDuration:0.25 animations:^{
        self.showHistoryView.frame = CGRectMake(0, kScreenHeight-HISTORYHEIGHT, kScreenWidth, HISTORYHEIGHT);
    }];
}

//编辑订单
-(void)editOrderBtnClick:(UIButton *)btn{
    if (![[LTUserManager sharedManager].permissions containsObject:@123]) {
        [YFEasyHUD showMsgWithDefaultDelay:@"无编辑派单的权限"];
        return;
    }
    XYEAddOrderViewController *avc = [[XYEAddOrderViewController alloc] initWithNibName:@"XYEAddOrderViewController" bundle:nil];
    avc.model = self.orderModel;
    avc.type = updateType;
    [self.navigationController pushViewController:avc animated:YES];
}

//主管派单
-(void)orderBtnClick:(UIButton *)btn{
    if (![[LTUserManager sharedManager].permissions containsObject:@132]) {
        [YFEasyHUD showMsgWithDefaultDelay:@"无派单权限"];
        return;
    }
    [self showLoading];
    LMJWeakSelf(self);
    [FYHTTPTOOL upload:FY_PRINCIPAL parameters:@{@"order_id":self.orderModel.order_id} formDataBlock:^(id<AFMultipartFormData> formData) {
        
    } progress:^(NSProgress *progress) {
        
    } completion:^(LMJBaseResponse *response) {
        [weakself dismissLoading];
        if (response.code == 10001) {
            [weakself requestData];
        }else{
            [YFEasyHUD showMsgWithDefaultDelay:response.error?response.errorMsg:response.message];
        }
        
    }];
}

//取消订单
-(void)cancelOrderBtnClick:(UIButton *)btn{
    if (![[LTUserManager sharedManager].permissions containsObject:@135]) {
        [YFEasyHUD showMsgWithDefaultDelay:@"无取消派单的权限"];
        return;
    }
    [self cancelReason];
}

//主管确认
-(void)chargeSureBtnClick:(UIButton *)btn{
    if (![[LTUserManager sharedManager].permissions containsObject:@133]) {
        [YFEasyHUD showMsgWithDefaultDelay:@"无主管派单权限"];
        return;
    }
    [self showLoading];
    LMJWeakSelf(self);
    [FYHTTPTOOL upload:FY_PRINCIPALAUDIT parameters:@{@"order_id":self.orderModel.order_id} formDataBlock:^(id<AFMultipartFormData> formData) {
        
    } progress:^(NSProgress *progress) {
        
    } completion:^(LMJBaseResponse *response) {
        [weakself dismissLoading];
        if (response.code == 10001) {
            [weakself requestData];
        }else{
            [YFEasyHUD showMsgWithDefaultDelay:response.error?response.errorMsg:response.message];
        }
        
    }];
}

//BOSS确认
-(void)bossSureBtnClick:(UIButton *)btn{
    if (![[LTUserManager sharedManager].permissions containsObject:@134]) {
        [YFEasyHUD showMsgWithDefaultDelay:@"无财务审核已服务派单权限"];
        return;
    }
    [self showLoading];
    LMJWeakSelf(self);
    [FYHTTPTOOL upload:FY_CEOAUDIT parameters:@{@"order_id":self.orderModel.order_id} formDataBlock:^(id<AFMultipartFormData> formData) {
        
    } progress:^(NSProgress *progress) {
        
    } completion:^(LMJBaseResponse *response) {
        [weakself dismissLoading];
        if (response.code == 10001) {
            [weakself requestData];
        }else{
            [YFEasyHUD showMsgWithDefaultDelay:response.error?response.errorMsg:response.message];
        }
        
    }];
}

//重新派单
-(void)resetOrderBtnClick:(UIButton *)btn{
    if (![[LTUserManager sharedManager].permissions containsObject:@131]) {
        [YFEasyHUD showMsgWithDefaultDelay:@"无编辑派单的权限"];
        return;
    }
    XYEAddOrderViewController *avc = [[XYEAddOrderViewController alloc] initWithNibName:@"XYEAddOrderViewController" bundle:nil];
    avc.model = self.orderModel;
    avc.type = resetCommitType;
    [self.navigationController pushViewController:avc animated:YES];
}

//处理标记
-(void)treatmentClick:(UIButton *)btn{
    if (![[LTUserManager sharedManager].permissions containsObject:@130]) {
        [YFEasyHUD showMsgWithDefaultDelay:@"无取消订单二次处理标记权限"];
        return;
    }
    [self showLoading];
    LMJWeakSelf(self);
    [FYHTTPTOOL upload:FY_TRASHMARK parameters:@{@"order_id":self.orderModel.order_id} formDataBlock:^(id<AFMultipartFormData> formData) {
    } progress:^(NSProgress *progress) {
    } completion:^(LMJBaseResponse *response) {
        [weakself dismissLoading];
        if (response.code == 10001) {
            [weakself requestData];
        }else{
            [YFEasyHUD showMsgWithDefaultDelay:response.error?response.errorMsg:response.message];
        }
    }];
}

#pragma mark -- 取消原因
-(void)cancelReason{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请输入取消原因" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *userNameTextField = alertController.textFields.firstObject;
        if (!StringIsNullOrEmpty(userNameTextField.text)) {
            [self cancelRequest:userNameTextField.text];
        }
    }]];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"取消原因";
    }];
    
    
    [self presentViewController:alertController animated:true completion:nil];
}

-(void)cancelRequest:(NSString *)cancelReason{
    [self showLoading];
    LMJWeakSelf(self);
    [FYHTTPTOOL upload:FY_CANCEL parameters:@{@"order_id":self.orderModel.order_id,@"reason_cancel":cancelReason} formDataBlock:^(id<AFMultipartFormData> formData) {
    } progress:^(NSProgress *progress) {
    } completion:^(LMJBaseResponse *response) {
        [weakself dismissLoading];
        if (response.code == 10001) {
            [weakself requestData];
        }else{
            [YFEasyHUD showMsgWithDefaultDelay:response.error?response.errorMsg:response.message];
        }
    }];
}

#pragma mark -- 私有方法
/**
 * 切换订单状态
 */
-(void)changeStatus{
    switch ([self.orderModel.order_state integerValue]) {
        case 1:
        {
            [self.showVisitBtn setTitle:@"查看回访" forState:UIControlStateNormal];
            [self.showVisitBtn setTitleColor:[UIColor textColor] forState:UIControlStateNormal];
            self.showVisitBtn.backgroundColor = [UIColor baseGreyColor];
            self.showVisitBtn.hidden = NO;
            [self.showVisitBtn removeAllTargets];
            [self.showVisitBtn addTarget:self action:@selector(showVisitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.editBtn setTitle:@"编辑订单" forState:UIControlStateNormal];
            [self.editBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.editBtn.backgroundColor = [UIColor baseColor];
            self.editBtn.hidden = NO;
            [self.editBtn removeAllTargets];
            [self.editBtn addTarget:self action:@selector(editOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.orderBtn setTitle:@"主管派单" forState:UIControlStateNormal];
            [self.orderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.orderBtn.backgroundColor = [UIColor baseGreenColor];
            self.orderBtn.hidden = NO;
            [self.orderBtn removeAllTargets];
            [self.orderBtn addTarget:self action:@selector(orderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            [self.cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.cancelBtn.backgroundColor = [UIColor baseyelloColor];
            self.cancelBtn.hidden = NO;
            [self.cancelBtn removeAllTargets];
            [self.cancelBtn addTarget:self action:@selector(cancelOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case 2:
        case 3:{
            self.showVisitBtn.hidden = YES;
            self.editBtn.hidden = YES;
            
            [self.orderBtn setTitle:@"查看回访" forState:UIControlStateNormal];
            [self.orderBtn setTitleColor:[UIColor textColor] forState:UIControlStateNormal];
            self.orderBtn.backgroundColor = [UIColor baseGreyColor];
            self.orderBtn.hidden = NO;
            [self.orderBtn removeAllTargets];
            [self.orderBtn addTarget:self action:@selector(showVisitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            [self.cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.cancelBtn.backgroundColor = [UIColor baseyelloColor];
            self.cancelBtn.hidden = NO;
            [self.cancelBtn removeAllTargets];
            [self.cancelBtn addTarget:self action:@selector(cancelOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case 4:{
            //已经确认
            if ([self.orderModel.principal_twice_state integerValue] == 2) {
                self.showVisitBtn.hidden = YES;
                self.editBtn.hidden = YES;
                
                [self.orderBtn setTitle:@"查看回访" forState:UIControlStateNormal];
                [self.orderBtn setTitleColor:[UIColor textColor] forState:UIControlStateNormal];
                self.orderBtn.backgroundColor = [UIColor baseGreyColor];
                self.orderBtn.hidden = NO;
                [self.orderBtn removeAllTargets];
                [self.orderBtn addTarget:self action:@selector(showVisitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                
                [self.cancelBtn setTitle:@"BOSS确认" forState:UIControlStateNormal];
                [self.cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.cancelBtn.backgroundColor = [UIColor baseGreenColor];
                self.cancelBtn.hidden = NO;
                [self.cancelBtn removeAllTargets];
                [self.cancelBtn addTarget:self action:@selector(bossSureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                if ([self.orderModel.ceo_audit_state integerValue] == 1) {
                    self.cancelBtn.backgroundColor = [UIColor darkGrayColor];
                    self.cancelBtn.enabled = NO;
                }
                else{
                    self.cancelBtn.backgroundColor = [UIColor baseGreenColor];
                    self.cancelBtn.enabled = YES;
                }
            }
            else{
                self.showVisitBtn.hidden = YES;
                
                [self.editBtn setTitle:@"查看回访" forState:UIControlStateNormal];
                [self.editBtn setTitleColor:[UIColor textColor] forState:UIControlStateNormal];
                self.editBtn.backgroundColor = [UIColor baseGreyColor];
                self.editBtn.hidden = NO;
                [self.editBtn removeAllTargets];
                [self.editBtn addTarget:self action:@selector(showVisitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                
                [self.orderBtn setTitle:@"取消订单" forState:UIControlStateNormal];
                [self.orderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.orderBtn.backgroundColor = [UIColor baseyelloColor];
                self.orderBtn.hidden = NO;
                [self.orderBtn removeAllTargets];
                [self.orderBtn addTarget:self action:@selector(cancelOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                
                [self.cancelBtn setTitle:@"主管确认" forState:UIControlStateNormal];
                [self.cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.cancelBtn.backgroundColor = [UIColor baseGreenColor];
                self.cancelBtn.hidden = NO;
                [self.cancelBtn removeAllTargets];
                [self.cancelBtn addTarget:self action:@selector(chargeSureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
            break;
        case 7:
        {
        }
            break;
        case 8:
        {
            self.showVisitBtn.hidden = YES;
            self.editBtn.hidden = YES;
            
            [self.orderBtn setTitle:@"查看回访" forState:UIControlStateNormal];
            [self.orderBtn setTitleColor:[UIColor textColor] forState:UIControlStateNormal];
            self.orderBtn.backgroundColor = [UIColor baseGreyColor];
            self.orderBtn.hidden = NO;
            [self.orderBtn removeAllTargets];
            [self.orderBtn addTarget:self action:@selector(showVisitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.cancelBtn setTitle:@"BOSS确认" forState:UIControlStateNormal];
            [self.cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.cancelBtn.backgroundColor = [UIColor baseGreenColor];
            self.cancelBtn.hidden = NO;
            [self.cancelBtn removeAllTargets];
            [self.cancelBtn addTarget:self action:@selector(bossSureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            if ([self.orderModel.ceo_audit_state integerValue] == 1) {
                self.cancelBtn.backgroundColor = [UIColor darkGrayColor];
                self.cancelBtn.enabled = NO;
            }
            else{
                self.cancelBtn.backgroundColor = [UIColor baseGreenColor];
                self.cancelBtn.enabled = YES;
            }
        }
            break;
        case 5:
        {
            self.showVisitBtn.hidden = YES;
            self.editBtn.hidden = YES;
            self.orderBtn.hidden = YES;
            
            [self.cancelBtn setTitle:@"查看回访" forState:UIControlStateNormal];
            [self.cancelBtn setTitleColor:[UIColor textColor] forState:UIControlStateNormal];
            self.cancelBtn.backgroundColor = [UIColor baseGreyColor];
            self.cancelBtn.hidden = NO;
            [self.cancelBtn removeAllTargets];
            [self.cancelBtn addTarget:self action:@selector(showVisitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case 6:
        case 9:
        case 10:{
            self.showVisitBtn.hidden = YES;
            
            [self.editBtn setTitle:@"查看回访" forState:UIControlStateNormal];
            [self.editBtn setTitleColor:[UIColor textColor] forState:UIControlStateNormal];
            self.editBtn.backgroundColor = [UIColor baseGreyColor];
            self.editBtn.hidden = NO;
            [self.editBtn removeAllTargets];
            [self.editBtn addTarget:self action:@selector(showVisitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.orderBtn setTitle:@"重新派单" forState:UIControlStateNormal];
            [self.orderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.orderBtn.backgroundColor = [UIColor baseyelloColor];
            self.orderBtn.hidden = NO;
            [self.orderBtn removeAllTargets];
            [self.orderBtn addTarget:self action:@selector(resetOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            if ([self.orderModel.trash_mark integerValue] == 1) {
                [self.cancelBtn setTitle:@"处理标记" forState:UIControlStateNormal];
                self.cancelBtn.backgroundColor = [UIColor baseRedColor];
                self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
                [self.cancelBtn removeAllTargets];
                [self.cancelBtn addTarget:self action:@selector(treatmentClick:) forControlEvents:UIControlEventTouchUpInside];
            }
            else{
                [self.cancelBtn setTitle:@"作废已处理" forState:UIControlStateNormal];
                self.cancelBtn.backgroundColor = [UIColor textColor];
                self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
                [self.cancelBtn removeAllTargets];
            }
            [self.cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.cancelBtn.hidden = NO;
        }
            break;
            
        default:
            break;
    }
}

-(void)sortAry{
    [self.dataAry removeAllObjects];
    NSMutableArray *clientInfo = [NSMutableArray arrayWithCapacity:0];
    [clientInfo addObject:[NSString stringWithFormat:@"客户姓名: %@",self.orderModel.client_name]];
    [clientInfo addObject:[NSString stringWithFormat:@"客户手机: %@",self.orderModel.client_phone]];
    [clientInfo addObject:[NSString stringWithFormat:@"客户微信: %@",self.orderModel.client_wx]];
    [clientInfo addObject:[NSString stringWithFormat:@"国家地区: %@%@",self.orderModel.order_country,self.orderModel.order_city]];
    [clientInfo addObject:[NSString stringWithFormat:@"客户旺旺: %@",self.orderModel.client_ww]];
    [self.dataAry addObject:@{@"客户信息":clientInfo}];
    
    NSMutableArray *costInfo = [NSMutableArray arrayWithCapacity:0];
    [costInfo addObject:[NSString stringWithFormat:@"结算费用: %@",self.orderModel.fish_cost]];
    [costInfo addObject:[NSString stringWithFormat:@"平台费用: %@",self.orderModel.platform_cost]];
    [costInfo addObject:[NSString stringWithFormat:@"当地货币: %@",self.orderModel.local_cost]];
    [self.dataAry addObject:@{@"费用信息":costInfo}];
    
    NSMutableArray *chanalInfo = [NSMutableArray arrayWithCapacity:0];
    [chanalInfo addObject:[NSString stringWithFormat:@"渠道来源: %@",self.orderModel.channel]];
    [chanalInfo addObject:[NSString stringWithFormat:@"渠道编号: %@",self.orderModel.channel_number]];
    [self.dataAry addObject:@{@"渠道信息":chanalInfo}];
    
    NSMutableArray *routeInfo = [NSMutableArray arrayWithCapacity:0];
    NSString *orderType = @"";
    switch ([self.orderModel.order_type integerValue]) {
        case 1:
        {
            orderType = @"接机";
            [routeInfo addObject:[NSString stringWithFormat:@"开始时间: %@",[self.orderModel.start_time getStamDate]]];
            if (!StringIsNullOrEmpty(self.orderModel.end_time)) {
                [routeInfo addObject:[NSString stringWithFormat:@"结束时间: %@",[self.orderModel.end_time getStamDate]]];
            }
            [routeInfo addObject:[NSString stringWithFormat:@"指定飞鱼: %@(ID: %@)",self.orderModel.plan_nick_name,self.orderModel.plan_id]];
            [routeInfo addObject:[NSString stringWithFormat:@"地接编号: %@",self.orderModel.ground_name_num]];
            [routeInfo addObject:[NSString stringWithFormat:@"成人数量: %@||行李数量: %@",self.orderModel.adult,self.orderModel.luggage]];
            [routeInfo addObject:[NSString stringWithFormat:@"儿童数量: %@||儿童座椅: %@",self.orderModel.child,self.orderModel.childSeat]];
            [routeInfo addObject:[NSString stringWithFormat:@"机场名称: %@",self.orderModel.airport_name]];
            [routeInfo addObject:[NSString stringWithFormat:@"行程航班: %@",self.orderModel.flight_num]];
            [routeInfo addObject:[NSString stringWithFormat:@"送达地点: %@",self.orderModel.delivered_site]];
            [routeInfo addObject:[NSString stringWithFormat:@"使用车辆: %@%@",self.orderModel.car,StringIsNullRetBlank(self.orderModel.car_suf)]];
            [routeInfo addObject:[NSString stringWithFormat:@"行程备注: %@",self.orderModel.order_notes]];
        }
            break;
        case 2:
        {
            orderType = @"送机";
            [routeInfo addObject:[NSString stringWithFormat:@"开始时间: %@",[self.orderModel.start_time getStamDate]]];
            if (!StringIsNullOrEmpty(self.orderModel.end_time)) {
                [routeInfo addObject:[NSString stringWithFormat:@"结束时间: %@",[self.orderModel.end_time getStamDate]]];
            }
            [routeInfo addObject:[NSString stringWithFormat:@"指定飞鱼: %@(ID: %@)",self.orderModel.plan_nick_name,self.orderModel.plan_id]];
            [routeInfo addObject:[NSString stringWithFormat:@"地接编号: %@",self.orderModel.ground_name_num]];
            [routeInfo addObject:[NSString stringWithFormat:@"成人数量: %@||行李数量: %@",self.orderModel.adult,self.orderModel.luggage]];
            [routeInfo addObject:[NSString stringWithFormat:@"儿童数量: %@||儿童座椅: %@",self.orderModel.child,self.orderModel.childSeat]];
            [routeInfo addObject:[NSString stringWithFormat:@"机场名称: %@",self.orderModel.airport_name]];
            [routeInfo addObject:[NSString stringWithFormat:@"行程航班: %@",self.orderModel.flight_num]];
            [routeInfo addObject:[NSString stringWithFormat:@"出发地点: %@",self.orderModel.depart_site]];
            [routeInfo addObject:[NSString stringWithFormat:@"使用车辆: %@%@",self.orderModel.car,StringIsNullRetBlank(self.orderModel.car_suf)]];
            [routeInfo addObject:[NSString stringWithFormat:@"行程备注: %@",self.orderModel.order_notes]];
        }
            break;
        case 3:
        {
            orderType = @"包车";
            [routeInfo addObject:[NSString stringWithFormat:@"开始时间: %@",[self.orderModel.start_time getStamDate]]];
            if (!StringIsNullOrEmpty(self.orderModel.end_time)) {
                [routeInfo addObject:[NSString stringWithFormat:@"结束时间: %@",[self.orderModel.end_time getStamDate]]];
            }
            [routeInfo addObject:[NSString stringWithFormat:@"指定飞鱼: %@(ID: %@)",self.orderModel.plan_nick_name,self.orderModel.plan_id]];
            [routeInfo addObject:[NSString stringWithFormat:@"地接编号: %@",self.orderModel.ground_name_num]];
            [routeInfo addObject:[NSString stringWithFormat:@"成人数量: %@||行李数量: %@",self.orderModel.adult,self.orderModel.luggage]];
            [routeInfo addObject:[NSString stringWithFormat:@"儿童数量: %@||儿童座椅: %@",self.orderModel.child,self.orderModel.childSeat]];
            [routeInfo addObject:[NSString stringWithFormat:@"出发地点: %@",self.orderModel.depart_site]];
            [routeInfo addObject:[NSString stringWithFormat:@"送达地点: %@",self.orderModel.delivered_site]];
            [routeInfo addObject:[NSString stringWithFormat:@"包车天数: %@天",self.orderModel.car_day]];
            [routeInfo addObject:[NSString stringWithFormat:@"使用车辆: %@%@",self.orderModel.car,StringIsNullRetBlank(self.orderModel.car_suf)]];
            [routeInfo addObject:[NSString stringWithFormat:@"游玩行程: %@",self.orderModel.car_stroke]];
            [routeInfo addObject:[NSString stringWithFormat:@"行程备注: %@",self.orderModel.order_notes]];
        }
            break;
        case 4:
        {
            orderType = @"单程接送";
            [routeInfo addObject:[NSString stringWithFormat:@"开始时间: %@",[self.orderModel.start_time getStamDate]]];
            if (!StringIsNullOrEmpty(self.orderModel.end_time)) {
                [routeInfo addObject:[NSString stringWithFormat:@"结束时间: %@",[self.orderModel.end_time getStamDate]]];
            }
            [routeInfo addObject:[NSString stringWithFormat:@"指定飞鱼: %@(ID: %@)",self.orderModel.plan_nick_name,self.orderModel.plan_id]];
            [routeInfo addObject:[NSString stringWithFormat:@"地接编号: %@",self.orderModel.ground_name_num]];
            [routeInfo addObject:[NSString stringWithFormat:@"成人数量: %@||行李数量: %@",self.orderModel.adult,self.orderModel.luggage]];
            [routeInfo addObject:[NSString stringWithFormat:@"儿童数量: %@||儿童座椅: %@",self.orderModel.child,self.orderModel.childSeat]];
            [routeInfo addObject:[NSString stringWithFormat:@"出发地点: %@",self.orderModel.depart_site]];
            [routeInfo addObject:[NSString stringWithFormat:@"送达地点: %@",self.orderModel.delivered_site]];
            [routeInfo addObject:[NSString stringWithFormat:@"使用车辆: %@%@",self.orderModel.car,StringIsNullRetBlank(self.orderModel.car_suf)]];
            [routeInfo addObject:[NSString stringWithFormat:@"行程备注: %@",self.orderModel.order_notes]];
            
        }
            break;
        case 5:
        {
            orderType = @"民宿";
            [routeInfo addObject:[NSString stringWithFormat:@"开始时间: %@",[self.orderModel.start_time getStamDate]]];
            if (!StringIsNullOrEmpty(self.orderModel.end_time)) {
                [routeInfo addObject:[NSString stringWithFormat:@"结束时间: %@",[self.orderModel.end_time getStamDate]]];
            }
            [routeInfo addObject:[NSString stringWithFormat:@"指定飞鱼: %@(ID: %@)",self.orderModel.plan_nick_name,self.orderModel.plan_id]];
            [routeInfo addObject:[NSString stringWithFormat:@"地接编号: %@",self.orderModel.ground_name_num]];
            [routeInfo addObject:[NSString stringWithFormat:@"入住人数: %@||公寓数量: %@",self.orderModel.homestay_pop,self.orderModel.homestay_apartment]];
            [routeInfo addObject:[NSString stringWithFormat:@"使用车辆: %@%@",self.orderModel.car,StringIsNullRetBlank(self.orderModel.car_suf)]];
            [routeInfo addObject:[NSString stringWithFormat:@"行程备注: %@",self.orderModel.order_notes]];
        }
            break;
        case 6:
        {
            orderType = @"特色玩法";
            [routeInfo addObject:[NSString stringWithFormat:@"开始时间: %@",[self.orderModel.start_time getStamDate]]];
            if (!StringIsNullOrEmpty(self.orderModel.end_time)) {
                [routeInfo addObject:[NSString stringWithFormat:@"结束时间: %@",[self.orderModel.end_time getStamDate]]];
            }
            [routeInfo addObject:[NSString stringWithFormat:@"指定飞鱼: %@(ID: %@)",self.orderModel.plan_nick_name,self.orderModel.plan_id]];
            [routeInfo addObject:[NSString stringWithFormat:@"地接编号: %@",self.orderModel.ground_name_num]];
            [routeInfo addObject:[NSString stringWithFormat:@"成人数量: %@||儿童数量: %@",self.orderModel.adult,self.orderModel.child]];
            [routeInfo addObject:[NSString stringWithFormat:@"玩法介绍: %@",StringIsNullRetBlank(self.orderModel.featureIntroduction)]];
            [routeInfo addObject:[NSString stringWithFormat:@"行程备注: %@",self.orderModel.order_notes]];
        }
            break;
            
        default:
            break;
    }
    
    [self.dataAry addObject:@{[NSString stringWithFormat:@"行程信息(%@)",orderType]:routeInfo}];
    
    if (self.driverInfo && !StringIsNullOrEmpty(self.driverInfo.Id)) {
        NSMutableArray *driverInfo = [NSMutableArray arrayWithCapacity:0];
        [driverInfo addObject:[NSString stringWithFormat:@"编号: %@||性别: %@",self.driverInfo.Id,self.driverInfo.driver_sex]];
        [driverInfo addObject:[NSString stringWithFormat:@"手机: %@||车龄: %@",self.driverInfo.driver_phone,self.driverInfo.driver_car_age]];
        [driverInfo addObject:[NSString stringWithFormat:@"姓名: %@",self.driverInfo.driver_name]];
        [driverInfo addObject:[NSString stringWithFormat:@"地区: %@%@",self.driverInfo.driver_country,self.driverInfo.driver_city]];
        [driverInfo addObject:[NSString stringWithFormat:@"微信: %@",self.driverInfo.driver_weixin]];
        [driverInfo addObject:[NSString stringWithFormat:@"分组: %@",self.driverInfo.driver_group]];
        
        [driverInfo addObject:[NSString stringWithFormat:@"车牌: %@||车型: %@",self.driverInfo.driver_car_license,self.driverInfo.driver_car_model]];
        [driverInfo addObject:[NSString stringWithFormat:@"里程数: %@公里||牌照类型: %@",self.driverInfo.driver_mileage,self.driverInfo.driver_license_type]];
        [driverInfo addObject:[NSString stringWithFormat:@"行驶证: %@",self.driverInfo.driver_driving_license]];
        [driverInfo addObject:[NSString stringWithFormat:@"驾驶证: %@",self.driverInfo.driver_vehicle_travel_license]];
        [driverInfo addObject:[NSString stringWithFormat:@"车辆保险: %@",self.driverInfo.driver_insurance]];
        
        [self.dataAry addObject:@{@"司机信息":driverInfo}];
    }
    //额外备注
    if (self.orderModel.note_list.count > 0) {
        NSMutableArray *noteList = [NSMutableArray arrayWithCapacity:0];
        [noteList addObjectsFromArray:self.orderModel.note_list];
        [self.dataAry addObject:@{@"额外备注":noteList}];
    }
    //取消原因
    if (!StringIsNullOrEmpty(self.orderModel.reason_cancel)) {
        NSMutableArray *reasonList = [NSMutableArray arrayWithCapacity:0];
        [reasonList addObject:[NSString stringWithFormat:@"%@",self.orderModel.reason_cancel]];
        [self.dataAry addObject:@{@"订单作废理由":reasonList}];
    }
}

#pragma mark -- tableViewDelegate/tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.dataAry[indexPath.section];
    NSMutableArray *secAry = dic[dic.allKeys[0]];
    NSString *title = dic.allKeys[0];
    if ([title isEqualToString:@"额外备注"]) {
        static NSString *cellName = @"RemarkTableViewCell";
        RemarkTableViewCell *cell = (RemarkTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellName];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"RemarkTableViewCell" owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        XYENoteModel *model = secAry[indexPath.row];
        if (model) {
            cell.model = model;
        }
        return cell;
    }
    else{
        static NSString *cellName = @"staticCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellName];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:15.0];
            cell.detailTextLabel.textColor = [UIColor blackColor];
            cell.textLabel.numberOfLines = 0;
            cell.detailTextLabel.numberOfLines = 0;
        }
        id data = secAry[indexPath.row];
        if ([data isKindOfClass:[NSString class]]) {
            NSString *content = (NSString *)data;
            NSArray *contentAry = [content componentsSeparatedByString:@"||"];
            
            cell.textLabel.text = [contentAry firstObject];
            if (contentAry.count >1 && !StringIsNullOrEmpty([contentAry lastObject])) {
                cell.detailTextLabel.text = [contentAry lastObject];
            }
            else{
                cell.detailTextLabel.text = @"";
            }
        }
        if (!StringIsNullOrEmpty(self.orderModel.reason_cancel)) {
            if (self.dataAry.count == (indexPath.section+1) && secAry.count == (indexPath.row+1)) {
                cell.backgroundColor = [[UIColor baseRedColor] colorWithAlphaComponent:0.1];
                cell.textLabel.textColor = [UIColor redColor];
            }
            else{
                cell.backgroundColor = [UIColor whiteColor];
                cell.textLabel.textColor = [UIColor blackColor];
            }
        }
        return cell;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *dic = self.dataAry[section];
    NSMutableArray *secAry = dic[dic.allKeys[0]];
    NSString *title = dic.allKeys[0];
    if ([title isEqualToString:@"额外备注"]) {
        if (isFade) {
            return 0;
        }
    }
    
    return [secAry count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataAry.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.dataAry[indexPath.section];
    NSMutableArray *secAry = dic[dic.allKeys[0]];
    id data = secAry[indexPath.row];
    if ([data isKindOfClass:[NSString class]]) {
        NSString *content = (NSString *)data;
        NSArray *contentAry = [content componentsSeparatedByString:@"||"];
        NSString *firstStr = [contentAry firstObject];
        CGSize size = [firstStr sizeForFont:[UIFont systemFontOfSize:15.0f] size:CGSizeMake(kScreenWidth-30, CGFLOAT_MAX) mode:NSLineBreakByWordWrapping];
        return MAX(44.0f, size.height+16);
    }
    else if([data isKindOfClass:[XYENoteModel class]]){
        XYENoteModel *model = (XYENoteModel *)data;
        CGSize size = [model.text sizeForFont:[UIFont systemFontOfSize:15.0f] size:CGSizeMake(kScreenWidth-98, CGFLOAT_MAX) mode:NSLineBreakByWordWrapping];
        return size.height+75;
    }
    return 44.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *secView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    
    secView.backgroundColor = [UIColor colorWithHexString:@"DBE5EF"];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, kScreenWidth-30, 30)];
    titleLabel.backgroundColor = [UIColor clearColor];
    NSDictionary *dic = self.dataAry[section];
    NSString *title = dic.allKeys[0];
    titleLabel.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightSemibold];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = title;
    [secView addSubview:titleLabel];
    
    if ([title isEqualToString:@"额外备注"]) {
        [secView addSubview:self.remarkBtn];
    }
    
    return secView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView) {
        if (self.showHistoryView.frame.origin.y == kScreenHeight-HISTORYHEIGHT) {
            [UIView animateWithDuration:0.25 animations:^{
                self.showHistoryView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, HISTORYHEIGHT);
            }];
        }
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView == self.tableView) {
        [super scrollViewWillBeginDragging:scrollView];
        if (self.showHistoryView.frame.origin.y == kScreenHeight-HISTORYHEIGHT) {
            [UIView animateWithDuration:0.25 animations:^{
                self.showHistoryView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, HISTORYHEIGHT);
            }];
        }
    }
}

-(void)remarkBtnClick:(UIButton *)btn{
    isFade = !isFade;
    if (!isFade) {
        CGAffineTransform transform =CGAffineTransformMakeRotation(M_PI);
        [btn setTransform:transform];
    }
    else{
        btn.transform = CGAffineTransformIdentity;
    }
    [self.tableView reloadData];
}

#pragma mark -- 懒加载
-(ShowHistoryView *)showHistoryView{
    if (!_showHistoryView) {
        _showHistoryView = [[[NSBundle mainBundle] loadNibNamed:@"ShowHistoryView" owner:self options:nil] lastObject];
        LMJWeakSelf(self);
        _showHistoryView.block = ^{
            if (weakself.showHistoryView.frame.origin.y == kScreenHeight-HISTORYHEIGHT) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [UIView animateWithDuration:0.25 animations:^{
                        weakself.showHistoryView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, HISTORYHEIGHT);
                    }];
                });
            }
        };
    }
    return _showHistoryView;
}

-(XYEDriverInfo *)driverInfo{
    if (!_driverInfo) {
        _driverInfo = [XYEDriverInfo new];
    }
    return _driverInfo;
}

- (UIButton *)remarkBtn{
    if (!_remarkBtn) {
        _remarkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _remarkBtn.frame = CGRectMake(kScreenWidth-50, 10, 30, 30);
        [_remarkBtn setImage:[UIImage imageNamed:@"xiangxia"] forState:UIControlStateNormal];
        [_remarkBtn addTarget:self action:@selector(remarkBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _remarkBtn;
}

-(UIButton *)showVisitBtn{
    if (!_showVisitBtn) {
        _showVisitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_showVisitBtn setTitle:@"查看回访" forState:UIControlStateNormal];
        _showVisitBtn.frame = CGRectMake(kScreenWidth-(STATUSBTNWIDTH+10)*4 -5, 20, STATUSBTNWIDTH, STATUSBTNHEIGHT);
        [_showVisitBtn setTitleColor:[UIColor textColor] forState:UIControlStateNormal];
        _showVisitBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        _showVisitBtn.backgroundColor = [UIColor baseGreyColor];
        _showVisitBtn.layer.masksToBounds = YES;
        _showVisitBtn.layer.cornerRadius = 6.0;
    }
    return _showVisitBtn;
}

-(UIButton *)editBtn{
    if (!_editBtn) {
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editBtn setTitle:@"编辑订单" forState:UIControlStateNormal];
        _editBtn.frame = CGRectMake(kScreenWidth-(STATUSBTNWIDTH+10)*3 -5, 20, STATUSBTNWIDTH, STATUSBTNHEIGHT);
        [_editBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _editBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        _editBtn.backgroundColor = [UIColor baseColor];
        _editBtn.layer.masksToBounds = YES;
        _editBtn.layer.cornerRadius = 6.0;
    }
    return _editBtn;
}

-(UIButton *)orderBtn{
    if (!_orderBtn) {
        _orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_orderBtn setTitle:@"主管派单" forState:UIControlStateNormal];
        _orderBtn.frame = CGRectMake(kScreenWidth-(STATUSBTNWIDTH+10)*2 -5, 20, STATUSBTNWIDTH, STATUSBTNHEIGHT);
        [_orderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _orderBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        _orderBtn.backgroundColor = [UIColor baseGreenColor];
        _orderBtn.layer.masksToBounds = YES;
        _orderBtn.layer.cornerRadius = 6.0;
    }
    return _orderBtn;
}

-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        _cancelBtn.frame = CGRectMake(kScreenWidth-STATUSBTNWIDTH-15, 20, STATUSBTNWIDTH, STATUSBTNHEIGHT);
        [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        _cancelBtn.backgroundColor = [UIColor baseyelloColor];
        _cancelBtn.layer.masksToBounds = YES;
        _cancelBtn.layer.cornerRadius = 6.0;
    }
    return _cancelBtn;
}

-(UIView *)footView{
    if (!_footView) {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80.0)];
        [_footView addSubview:self.showVisitBtn];
        [_footView addSubview:self.editBtn];
        [_footView addSubview:self.orderBtn];
        [_footView addSubview:self.cancelBtn];
    }
    return _footView;
}

-(NSMutableArray *)dataAry{
    if (!_dataAry) {
        _dataAry = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataAry;
}

-(XYEResponseSubModel *)model{
    if (!_model) {
        _model = [XYEResponseSubModel new];
    }
    return _model;
}

- (XYEAddOrderModel *)orderModel{
    if (!_orderModel) {
        _orderModel = [XYEAddOrderModel new];
    }
    return _orderModel;
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

@end
