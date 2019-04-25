//
//  LoginViewController.m
//  ChenShuo
//
//  Created by youdian on 2019/4/22.
//  Copyright © 2019 ChenShuo. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    
    [self addLoginUI];
    
    
    // Do any additional setup after loading the view.
}

-(void)addLoginUI{
    UILabel *label_r = [UILabel new];
    label_r.text = @"去注册";
    label_r.textAlignment = NSTextAlignmentRight;
     label_r.font = [UIFont systemFontOfSize:20.0f];
    [self.view addSubview: label_r];
    [ label_r mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(getRectNavAndStatusHight-40);
        make.right.equalTo(self.view).offset(-20);
        make.size.mas_equalTo(CGSizeMake(100, 45));
    }];
    label_r.userInteractionEnabled = YES;
    UITapGestureRecognizer  *regTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(registerClick:)];
    [label_r addGestureRecognizer:regTap];
    
    UILabel *label = [UILabel new];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor darkGrayColor];
    label.text = @"密码登录";
    label.font = [UIFont systemFontOfSize:25.0f];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(getRectNavAndStatusHight);
        make.left.equalTo(self.view).offset(20);
        make.size.mas_equalTo(CGSizeMake(200, 45));
    }];
    
    [self loginCreateUI];
    
}

-(void)loginCreateUI {
    for (int i = 0; i<2; i++) {
        NSArray *lableArr = @[@"手机:",@"密码:"];
        NSArray *placeArr = @[@"请输入手机号码",@"请输入密码"];
        UILabel *lable = [[UILabel alloc]init];
        lable.text = lableArr[i];
        lable.textColor = [UIColor lightGrayColor];
        [self.view addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(140+i*82);
            make.left.equalTo(self.view).offset(20);
            make.size.mas_equalTo(CGSizeMake(50, 30));
        }];
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lable.mas_bottom).offset(1);
            make.left.equalTo(lable);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-40, 1));
        }];
        
        UITextField *textField = [[UITextField alloc]init];
        textField.borderStyle = UITextBorderStyleNone;
        textField.placeholder = placeArr[i];
        textField.tag = 20+i;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.delegate = self;
        [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self.view addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.equalTo(lable);
            make.left.equalTo(lable.mas_right);
            make.right.equalTo(line);
        }];
        
        if (i==1) {
            /*
            UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
            forgetBtn.tag  =10;
            [forgetBtn setTitleColor:Theme_Color forState:UIControlStateNormal];
            forgetBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
            [forgetBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:forgetBtn];
            [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(line.mas_bottom);
                make.right.height.equalTo(textField);
            }];
            */
            UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
            loginBtn.layer.cornerRadius = 6;
            loginBtn.backgroundColor = Theme_Color;
            [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [loginBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            loginBtn.tag = 11;
            [self.view addSubview:loginBtn];
            
            [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(line).offset(80);
                make.left.right.equalTo(line);
                make.height.mas_equalTo(47);
            }];
        }
    }
    
    _phoneNumTF = (UITextField *)[self.view viewWithTag:20];
    _passwordTF = (UITextField *)[self.view viewWithTag:21];
    _passwordTF.secureTextEntry = YES;
}

-(void)registerClick:(UITapGestureRecognizer *)gesture{
    UIViewController *registerVC = [NSClassFromString(@"RegisterViewController") new];
    [self.navigationController pushViewController:registerVC animated:YES];
    
}
-(void)btnClick:(UIButton *)button{
    if ([_phoneNumTF.text isEqualToString:@"15963256235"]&&[_passwordTF.text isEqualToString:@"000000"]) {
        [self.view makeToast:@"登陆成功"];
        [self performSelector:@selector(loginRequest) withObject:nil afterDelay:3];
    }else{
         [self.view makeToast:@"账号或密码错误"];
    }
}
-(void)loginRequest{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:_passwordTF.text forKey:_phoneNumTF.text];
    [userDefault setObject:_phoneNumTF.text forKey:@"phone"];
    [AppDel commonTabBarRootController];
}
#pragma mark UITextFiledDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textField.returnKeyType = UIReturnKeyGo;
    if (textField.tag==20)
    {
        textField.keyboardType = UIKeyboardTypeNumberPad;
        
    }
    else
    {
        textField.keyboardType = UIKeyboardTypeASCIICapable;
        
    }
    
    return YES;
}
-(void)textFieldDidChange:(UITextField *)textField {
    //限制手机号输入长度 大陆手机号 +86省去
    if (textField.tag==20) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
