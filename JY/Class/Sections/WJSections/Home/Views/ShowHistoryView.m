//
//  ShowHistoryView.m
//  JY
//
//  Created by 澳达国际 on 2019/1/16.
//  Copyright © 2019 飞鱼旅行. All rights reserved.
//

#import "ShowHistoryView.h"
#import "ShowHistoryTableViewCell.h"

@interface ShowHistoryView ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (weak, nonatomic) IBOutlet UITextField *contentTextField;

@property (nonatomic, strong) XYEVisitModel *model;

@end

@implementation ShowHistoryView{
    NSString *_orderId;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self.tableview setTableFooterView:[UIView new]];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
}

- (IBAction)closeBtnClick:(UIButton *)sender {
    if (self.block) {
        self.block();
    }
}

-(XYEVisitModel *)model{
    if (!_model) {
        _model = [XYEVisitModel new];
    }
    return _model;
}

-(void)requestData:(NSString *)orderId{
    _orderId = orderId;
    [YFEasyHUD showIndicator];
    [FYHTTPTOOL upload:FY_GETVISITLIST parameters:@{@"order_id":orderId} formDataBlock:^(id<AFMultipartFormData> formData) {
    } progress:^(NSProgress *progress) {
    } completion:^(LMJBaseResponse *response) {
        [YFEasyHUD hideHud];
        if (response.code == 10001) {
            self.model = [XYEVisitModel mj_objectWithKeyValues:response.data];
            [self.tableview reloadData];
        }
        else{
            [YFEasyHUD showMsgWithDefaultDelay:response.error?response.errorMsg:response.message];
        }
    }];
}

-(void)sendText:(NSString *)text{
    [self endEditing:YES];
    self.contentTextField.text = @"";
    [YFEasyHUD showIndicator];
    [FYHTTPTOOL upload:FY_VISIT parameters:@{@"order_id":_orderId,@"text":text} formDataBlock:^(id<AFMultipartFormData> formData) {
    } progress:^(NSProgress *progress) {
    } completion:^(LMJBaseResponse *response) {
        [YFEasyHUD hideHud];
        if (response.code == 10001) {
            [self requestData:_orderId];
        }
        else{
            [YFEasyHUD showMsgWithDefaultDelay:response.error?response.errorMsg:response.message];
        }
    }];
}

//提交数据
- (IBAction)commitBtnClick:(UIButton *)sender {
    if (![[LTUserManager sharedManager].permissions containsObject:@126]) {
        [YFEasyHUD showMsgWithDefaultDelay:@"无添加回访记录权限"];
        return;
    }
    [self sendText:self.contentTextField.text];
}

#pragma mark -- tableviewDelegate/tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"adminCell";
    ShowHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ShowHistoryTableViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    XYEVisitSubModel *smodel = self.model.list[indexPath.row];
    cell.model = smodel;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.list.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XYEVisitSubModel *smodel = self.model.list[indexPath.row];

    CGSize size = [smodel.text sizeForFont:[UIFont systemFontOfSize:15.0f] size:CGSizeMake(kScreenWidth-185, CGFLOAT_MAX) mode:NSLineBreakByWordWrapping];
    return size.height+40;
}

@end
