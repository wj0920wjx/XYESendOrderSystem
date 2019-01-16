//
//  HomeViewController.m
//  JY
//
//  Created by 澳达国际 on 2019/1/9.
//  Copyright © 2019 飞鱼旅行. All rights reserved.
//

#import "HomeViewController.h"
#import "XYERequestModel.h"
#import "XYEResponseModel.h"
#import "HomeTableViewCell.h"
#import "XYESearchViewController.h"
#import "XYEAddOrderViewController.h"
#import "XYEOrderDetailVC.h"

#define NAVBARHEIGHT (55.0 + NAV_HEIGHT)
#define HEADHEIGHT 125.0
#define BOTTOMHEIGHT 50.0

@interface HomeViewController ()<UITextFieldDelegate>

/**
 相应数据
 */
@property (nonatomic, strong) XYEResponseModel *responseModel;

/**
 搜索条件按钮
 */
@property (nonatomic, strong) UIButton *clearSearchBtn;

/**
 搜索按钮
 */
@property (nonatomic, strong) UIButton *searchBtn;

/**
 下拉按钮
 */
@property (nonatomic, strong) UIButton *pullBtn;

/**
 下拉按钮
 */
@property (nonatomic, strong) UIButton *pullDownBtn;

/**
 添加按钮
 */
@property (nonatomic, strong) UIButton *addBtn;

/**
 金额展示View
 */
@property (nonatomic, strong) UIView *headView;

/**
 总金额
 */
@property (nonatomic, strong) UILabel *totalPrice;

/**
 结算金额
 */
@property (nonatomic, strong) UILabel *finalPrice;

/**
 当地货币金额
 */
@property (nonatomic, strong) UILabel *localPrice;

/**
 数据字典
 */
@property (nonatomic, strong) NSMutableDictionary *dataDic;

/**
 请求数据
 */
@property (nonatomic, strong) XYERequestModel *requestModel;

/**
 底层视图
 */
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation HomeViewController{
    UITextField *pageTextField;
    NSInteger totalPage;
    __block BOOL isRequest;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    if (![[LTUserManager sharedManager].permissions containsObject:@120]) {
        [self.tableView configBlankPage:LMJEasyBlankPageViewTypeAuthority hasData:NO hasError:NO reloadButtonBlock:^(id sender) {
        }];
        return;
    }
    else{
        if (isRequest) {
            [self requestData];
        }
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    isRequest = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"DBE5EF"];
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"DBE5EF"];

    UIEdgeInsets inset = self.tableView.contentInset;
    inset.bottom = SAFEAREA_HEIGHT + BOTTOMHEIGHT;
    inset.top = NAVBARHEIGHT;
    self.tableView.contentInset = inset;
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.tableView setTableHeaderView:self.headView];
    
    [self.totalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView).mas_offset(10.0);
        make.left.equalTo(self.headView).mas_offset(15.0);
        make.right.equalTo(self.headView).mas_offset(-15.0);
        make.height.mas_equalTo(35.0);
    }];
    
    [self.finalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.totalPrice.mas_bottom);
        make.left.equalTo(self.headView).mas_offset(15.0);
        make.right.equalTo(self.headView).mas_offset(-15.0);
        make.height.mas_equalTo(35.0);
    }];

    [self.localPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.finalPrice.mas_bottom);
        make.left.equalTo(self.headView).mas_offset(15.0);
        make.right.equalTo(self.headView).mas_offset(-15.0);
        make.height.mas_equalTo(35.0);
    }];
    
    self.requestModel.limit = 10;
    self.requestModel.page = 1;
    
    [self.view addSubview:self.bottomView];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 260.0;
    isRequest = YES;
}

-(void)uploadData{
    NSString *str = [NSString stringWithFormat:@"平台收入总额：%.2lf",[self.responseModel.cost_list.platform_cost doubleValue]/100];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor redColor]
                    range:NSMakeRange(7, str.length-7)];
    self.totalPrice.attributedText = attrStr;
    
    NSString *str1 = [NSString stringWithFormat:@"飞鱼结算总额：%.2lf",[self.responseModel.cost_list.fish_cost doubleValue]/100];
    NSMutableAttributedString *attrStr1 = [[NSMutableAttributedString alloc] initWithString:str1];
    
    [attrStr1 addAttribute:NSForegroundColorAttributeName
                     value:[UIColor redColor]
                     range:NSMakeRange(7, str1.length-7)];
    self.finalPrice.attributedText = attrStr1;
    
    NSString *str2 = [NSString stringWithFormat:@"当地货币总额：%.2lf",[self.responseModel.cost_list.local_cost doubleValue]/100];
    NSMutableAttributedString *attrStr2 = [[NSMutableAttributedString alloc] initWithString:str2];
    
    [attrStr2 addAttribute:NSForegroundColorAttributeName
                     value:[UIColor redColor]
                     range:NSMakeRange(7, str2.length-7)];
    self.localPrice.attributedText = attrStr2;
}

/**
 数据加载
 */
-(void)requestData{
    [self.tableView.mj_footer resetNoMoreData];
    if (![[LTUserManager sharedManager].permissions containsObject:@120]) {
        [self.tableView configBlankPage:LMJEasyBlankPageViewTypeAuthority hasData:NO hasError:NO reloadButtonBlock:^(id sender) {
        }];
        [self endHeaderFooterRefreshing];
        return;
    }

    [self showLoading];
    LMJWeakSelf(self);
    [FYHTTPTOOL upload:FY_ORDER_LIST parameters:[self.requestModel mj_keyValues] formDataBlock:^(id<AFMultipartFormData> formData) {
        
    } progress:^(NSProgress *progress) {
        
    } completion:^(LMJBaseResponse *response) {
        [weakself dismissLoading];
        if (response.code == 10001) {
            weakself.responseModel = [XYEResponseModel mj_objectWithKeyValues:response.data];
            [weakself uploadData];
            [weakself.tableView reloadData];
            pageTextField.text = [NSString stringWithFormat:@"%ld",weakself.responseModel.page];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (weakself.responseModel.list.count >0) {
                    [weakself.tableView scrollToRow:0 inSection:0 atScrollPosition:UITableViewScrollPositionTop animated:NO];
                }
            });
            [self.tableView configBlankPage:LMJEasyBlankPageViewTypeNoData hasData:weakself.responseModel.list.count>0 hasError:NO reloadButtonBlock:^(id sender) {
            }];
        }
        else{
            [YFEasyHUD showMsgWithDefaultDelay:response.error?response.errorMsg:response.message];
        }
    }];
}

/**
 刷新/下拉

 @param isMore <#isMore description#>
 */
-(void)loadMore:(BOOL)isMore{
    [self endHeaderFooterRefreshing];
    if (isMore) {
        NSInteger totalPage = self.responseModel.total/10 +1;
        if (self.requestModel.page>=totalPage) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
        self.requestModel.page ++;
    }
    [self requestData];
}

#pragma mark -- 懒加载
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-BOTTOMHEIGHT-SAFEAREA_HEIGHT, kScreenWidth, BOTTOMHEIGHT+SAFEAREA_HEIGHT)];
        
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(kScreenWidth-150, 10, 30, 30);
        [leftBtn setImage:[UIImage imageNamed:@"forwrod"] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:leftBtn];
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(kScreenWidth-50, 10, 30, 30);
        [rightBtn setImage:[UIImage imageNamed:@"forback"] forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:rightBtn];

        pageTextField = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth-120, 10, 70, 30)];
        pageTextField.keyboardType = UIKeyboardTypeNumberPad;
        pageTextField.delegate = self;
        pageTextField.textAlignment = NSTextAlignmentCenter;
        pageTextField.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
        pageTextField.placeholder = @"1";
        pageTextField.text = @"1";
        pageTextField.tintColor = [UIColor baseColor];
        [_bottomView addSubview:pageTextField];
    }
    return _bottomView;
}

-(XYEResponseModel *)responseModel{
    if (!_responseModel) {
        _responseModel = [[XYEResponseModel alloc] init];
    }
    return _responseModel;
}

-(XYERequestModel *)requestModel{
    if (!_requestModel) {
        _requestModel = [[XYERequestModel alloc] init];
    }
    return _requestModel;
}

- (NSMutableDictionary *)dataDic{
    if (!_dataDic) {
        _dataDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    return _dataDic;
}

-(UIButton *)clearSearchBtn{
    if (!_clearSearchBtn) {
        _clearSearchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clearSearchBtn setTitle:@"当前有搜索条件" forState:UIControlStateNormal];
        _clearSearchBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_clearSearchBtn setImage:[UIImage imageNamed:@"shanchu"] forState:UIControlStateNormal];
        [_clearSearchBtn setTitleColor:[UIColor baseColor] forState:UIControlStateNormal];
        [_clearSearchBtn addTarget:self action:@selector(clearSearch:) forControlEvents:UIControlEventTouchUpInside];
        _clearSearchBtn.hidden = YES;
    }
    return _clearSearchBtn;
}

-(UIButton *)searchBtn{
    if (!_searchBtn) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchBtn setImage:[UIImage imageNamed:@"sousuo"] forState:UIControlStateNormal];
        [_searchBtn addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
}

-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setTitle:@"+" forState:UIControlStateNormal];
        _addBtn.titleLabel.font = [UIFont systemFontOfSize:kWidth(40.0)];
        [_addBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addOrder:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

-(UIButton *)pullBtn{
    if (!_pullBtn) {
        _pullBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _pullBtn.frame = CGRectMake(0, 0, 45, 30);
        _pullBtn.center = CGPointMake(self.view.center.x, CGRectGetHeight(self.headView.frame)-15);
        [_pullBtn setImage:[UIImage imageNamed:@"pullDown"] forState:UIControlStateNormal];
        [_pullBtn addTarget:self action:@selector(pullDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _pullBtn;
}

-(UIButton *)pullDownBtn{
    if (!_pullDownBtn) {
        _pullDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _pullDownBtn.frame = CGRectMake(0, 0, 45, 30);
        _pullDownBtn.center = CGPointMake(self.view.center.x, CGRectGetHeight(self.headView.frame)-15);
        [_pullDownBtn setImage:[UIImage imageNamed:@"pullDown"] forState:UIControlStateNormal];
        [_pullDownBtn addTarget:self action:@selector(pullDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _pullDownBtn;
}

-(UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HEADHEIGHT + 30)];
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HEADHEIGHT)];
        
        titleView.backgroundColor = [UIColor whiteColor];
        [titleView addSubview:self.totalPrice];
        [titleView addSubview:self.finalPrice];
        [titleView addSubview:self.localPrice];
        
        titleView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        titleView.layer.shadowOpacity = 0.8f;
        titleView.layer.shadowOffset = CGSizeMake(0,2);
        
        [_headView addSubview:titleView];
        
        [_headView addSubview:self.pullBtn];
    }
    return _headView;
}

-(UILabel *)totalPrice{
    if (!_totalPrice) {
        _totalPrice = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, kScreenWidth-30, 40)];
        _totalPrice.font = [UIFont systemFontOfSize:16.0];
        _totalPrice.textColor = [UIColor blackColor];
    }
    return _totalPrice;
}

-(UILabel *)finalPrice{
    if (!_finalPrice) {
        _finalPrice = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, kScreenWidth-30, 40)];
        _finalPrice.font = [UIFont systemFontOfSize:16.0];
        _finalPrice.textColor = [UIColor blackColor];
    }
    return _finalPrice;
}

-(UILabel *)localPrice{
    if (!_localPrice) {
        _localPrice = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, kScreenWidth-30, 40)];
        _localPrice.font = [UIFont systemFontOfSize:16.0];
        _localPrice.textColor = [UIColor blackColor];
    }
    return _localPrice;
}

/**
 上一页

 @param btn <#btn description#>
 */
-(void)leftBtnClick:(UIButton *)btn{
    if ([pageTextField.text integerValue] == 1) {
        [YFEasyHUD showMsgWithDefaultDelay:@"已经是第一页"];
        return;
    }
//    pageTextField.text = [NSString stringWithFormat:@"%ld",[pageTextField.text integerValue] - 1];
    
    self.requestModel.page --;
    [self requestData];
}

/**
 下一页

 @param btn <#btn description#>
 */
-(void)rightBtnClick:(UIButton *)btn{
    NSInteger totalPage = self.responseModel.total/10 +1;
    if ([pageTextField.text integerValue] == totalPage) {
        [YFEasyHUD showMsgWithDefaultDelay:@"已经是最后一页"];
        return;
    }

    self.requestModel.page ++;
    [self requestData];
}

/**
 点击下拉

 @param btn <#btn description#>
 */
-(void)pullDown:(UIButton *)btn{
    if (![[LTUserManager sharedManager].permissions containsObject:@120]) {
        return;
    }
    self.pullDownBtn.selected = !self.pullDownBtn.selected;
    self.pullBtn.selected = self.pullDownBtn.selected;
    if (btn.selected) {
        [self.tableView setTableHeaderView:self.pullDownBtn];
    }
    else{
        [self.tableView setTableHeaderView:self.headView];
    }
}

/**
 添加派单

 @param btn <#btn description#>
 */
-(void)addOrder:(UIButton *)btn{
    if (![[LTUserManager sharedManager].permissions containsObject:@122]) {
        [YFEasyHUD showMsgWithDefaultDelay:@"无创建订单的权限"];
        return;
    }
    XYEAddOrderViewController *avc = [[XYEAddOrderViewController alloc] initWithNibName:@"XYEAddOrderViewController" bundle:nil];
    avc.type = defaultType;
    [self.navigationController pushViewController:avc animated:YES];
}

/**
 添加搜索条件

 @param btn <#btn description#>
 */
-(void)search:(UIButton *)btn{
    LMJWeakSelf(self);
    XYESearchViewController *svc = [[XYESearchViewController alloc] initWithNibName:@"XYESearchViewController" bundle:nil];
    svc.searchDic = [self.requestModel mj_keyValues];
    svc.block = ^(NSMutableDictionary * _Nonnull searchDic) {
        weakself.requestModel = [XYERequestModel mj_objectWithKeyValues:searchDic];
        weakself.requestModel.page = 1;
        [weakself requestData];
        isRequest = NO;
        [weakself isHiddenSearchBtn:searchDic];
    };
    [self.navigationController pushViewController:svc animated:YES];
}

-(void)isHiddenSearchBtn:(NSMutableDictionary *)dic{
    BOOL isHidden = YES;
    for (NSString *key in dic.allKeys) {
        id value = dic[key];
        if ([value isKindOfClass:[NSString class]]) {
            if (!StringIsNullOrEmpty(dic[key])) {
                isHidden = NO;
            }
        }
    }
    self.clearSearchBtn.hidden = isHidden;
}

/**
 清除搜索条件

 @param btn 清除搜索条件按钮
 */
-(void)clearSearch:(UIButton *)btn{
    btn.hidden = YES;
    self.requestModel = nil;
    self.requestModel.limit = 10;
    self.requestModel.page = 1;
    [self requestData];
}

#pragma mark -- textFieldDelegate
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSInteger totalPage = self.responseModel.total/10 +1;
    if (StringIsNullOrEmpty(textField.text) || [textField.text integerValue] == 0) {
        textField.text = @"1";
    }
    if ([textField.text integerValue] >= totalPage) {
        textField.text = [NSString stringWithFormat:@"%ld",totalPage];
    }
    else if ([textField.text integerValue] <=0 ){
        textField.text = @"1";
    }
    
    textField.text = [NSString stringWithFormat:@"%ld",[textField.text integerValue]];
    
    self.requestModel.page = [textField.text integerValue];
    [self requestData];

    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    textField.text = @"";
    return YES;
}

#pragma mark -- tableViewDelegate/tabeViewdataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.responseModel.list.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"cell";
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeTableViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = self.responseModel.list[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (![[LTUserManager sharedManager].permissions containsObject:@124]) {
        [YFEasyHUD showMsgWithDefaultDelay:@"无查看详情的权限"];
        return;
    }

    XYEResponseSubModel *smodel = self.responseModel.list[indexPath.row];
    XYEOrderDetailVC *dvc = [[XYEOrderDetailVC alloc] initWithStyle:UITableViewStylePlain];
    dvc.model = smodel;
    [self.navigationController pushViewController:dvc animated:YES];
}

#pragma mark -- lmj_navgationBarDataSource
-(CGFloat)lmjNavigationHeight:(LMJNavigationBar *)navigationBar{
    navigationBar.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    navigationBar.layer.shadowOpacity = 0.8f;
    navigationBar.layer.shadowOffset = CGSizeMake(0,2);
    return NAV_HEIGHT + 55.0;
}

-(UIColor *)lmjNavigationBackgroundColor:(LMJNavigationBar *)navigationBar{
    return [UIColor baseGreyColor];
}

-(UIView *)lmjNavigationBarLeftView:(LMJNavigationBar *)navigationBar{
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/2, CGRectGetHeight(navigationBar.frame) - STATUS_HEIGHT)];
    
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, CGRectGetHeight(leftView.frame)/2, CGRectGetHeight(leftView.frame)/2)];
    headImageView.layer.masksToBounds = YES;
    headImageView.layer.cornerRadius = CGRectGetHeight(leftView.frame)/4;
    [headImageView sd_setImageWithURL:[NSURL URLWithString:[LTUserManager sharedManager].userInfo.avatar] placeholderImage:[UIImage imageNamed:@"defaultAvatar"]];
    headImageView.userInteractionEnabled = YES;
    [headImageView addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        UIAlertController *avc = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否退出登录?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [LTUserManager removeUserInfo];
            [LTUserManager resetUserInfo];
            [[LTUserManager sharedManager] gotoLogin];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [avc addAction:sureAction];
        [avc addAction:cancelAction];
        [self.navigationController presentViewController:avc animated:YES completion:nil];
    }];
    [leftView addSubview:headImageView];

    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(headImageView.frame)+8, CGRectGetWidth(leftView.frame), CGRectGetHeight(leftView.frame)/2-8)];
    contentLabel.text = @"派单列表";
    contentLabel.textColor = [UIColor blackColor];
    contentLabel.font = [UIFont boldSystemFontOfSize:kWidth(30.0)];
    [leftView addSubview:contentLabel];
    [contentLabel sizeToFit];
    return leftView;
}

-(UIView *)lmjNavigationBarRightView:(LMJNavigationBar *)navigationBar{
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2, 0, kScreenWidth/2, CGRectGetHeight(navigationBar.frame)-STATUS_HEIGHT)];
    [rightView addSubview:self.clearSearchBtn];
    
    [self.clearSearchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(rightView.mas_right).mas_equalTo(-15);
        make.bottom.equalTo(rightView.mas_bottom).mas_equalTo(-5);
    }];
    
    [rightView addSubview:self.addBtn];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rightView.mas_top).mas_offset(-5);
        make.right.equalTo(rightView.mas_right).mas_equalTo(-15);
    }];

    [rightView addSubview:self.searchBtn];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rightView.mas_top).mas_offset(13);
        make.right.equalTo(self.addBtn.mas_left).mas_equalTo(-8);
        make.width.height.mas_equalTo(kWidth(30));
    }];

    
    return rightView;
}

/** 是否隐藏底部黑线 */
- (BOOL)lmjNavigationIsHideBottomLine:(LMJNavigationBar *)navigationBar
{
    return YES;
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return YES;
}

@end
