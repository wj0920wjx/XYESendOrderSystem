//
//  XYELoginViewController.m
//  JY
//
//  Created by 澳达国际 on 2019/1/8.
//  Copyright © 2019 飞鱼旅行. All rights reserved.
//

#import "XYELoginViewController.h"
#import "HomeViewController.h"

@interface XYELoginViewController ()<UITextFieldDelegate>

/**
 用户
 */
@property (weak, nonatomic) IBOutlet UITextField *userNameTextfield;

/**
 密码
 */
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIView *userNameLineView;

@property (weak, nonatomic) IBOutlet UIView *passwordLineView;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation XYELoginViewController

- (IBAction)login:(UIButton *)sender {
    [self.view endEditing:YES];
    LMJWeakSelf(self);
    [self showLoading];
    [FYHTTPTOOL upload:FY_LOGIN parameters:@{@"account":self.userNameTextfield.text,@"password":[self.passwordTextField.text md5]} formDataBlock:^(id<AFMultipartFormData> formData) {
        
    } progress:^(NSProgress *progress) {
        
    } completion:^(LMJBaseResponse *response) {
        [weakself dismissLoading];
        if (response.code == 10001) {
            [[LTUserManager sharedManager] mj_setKeyValues:response.data];
            [[LTUserManager sharedManager] updateUserInfo];
            
            HomeViewController *hvc = [[HomeViewController alloc] initWithStyle:UITableViewStylePlain];
            LMJNavigationController *nvc = (LMJNavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            if ([nvc.topViewController isKindOfClass:[HomeViewController class]]) {
                [weakself.navigationController dismissViewControllerAnimated:YES completion:nil];
            }
            else{
                LMJNavigationController *nvc = [[LMJNavigationController alloc] initWithRootViewController:hvc];
                [UIApplication sharedApplication].keyWindow.rootViewController = nvc;
            }
        }
        else{
            [YFEasyHUD showMsgWithDefaultDelay:response.error?response.errorMsg:response.message];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

-(void)setupUI{
    RACSignal *psdSignal = [[self.passwordTextField rac_textSignal] map:^id _Nullable(NSString * _Nullable value) {
        return @(value.length>0);
    }];
    
    RACSignal *nameSignal = [[self.userNameTextfield rac_textSignal] map:^id _Nullable(NSString * _Nullable value) {
        return @(value.length>0);
    }];
    
    [[RACSignal combineLatest:@[psdSignal,nameSignal] reduce:^id(NSNumber *num1 ,NSNumber *num2){
        return @([num1 boolValue] && [num2 boolValue]);
    }] subscribeNext:^(NSNumber *success) {
        self.loginBtn.enabled = [success boolValue];
        if ([success boolValue]) {
            self.loginBtn.backgroundColor = [UIColor baseColor];
        }
        else{
            self.loginBtn.backgroundColor = [UIColor lightGrayColor];
        }
    }];
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    self.userNameLineView.backgroundColor = [UIColor baseGreyColor];
    self.passwordLineView.backgroundColor = [UIColor baseGreyColor];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == self.userNameTextfield) {
        self.userNameLineView.backgroundColor = [UIColor baseColor];
        self.passwordLineView.backgroundColor = [UIColor baseGreyColor];
    }
    else{
        self.passwordLineView.backgroundColor = [UIColor baseColor];
        self.userNameLineView.backgroundColor = [UIColor baseGreyColor];
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark -- lmj_navgationBarDataSource
-(CGFloat)lmjNavigationHeight:(LMJNavigationBar *)navigationBar{
    return 0;
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
