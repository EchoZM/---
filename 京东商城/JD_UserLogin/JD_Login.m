//
//  JD_Login.m
//  京东商城
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 张闽. All rights reserved.
//

#import "JD_Login.h"
#import "JD_Register.h"
@interface JD_Login ()

@end

@implementation JD_Login

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"登录";
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(CancelButton:)]autorelease];
    self.navigationItem.leftBarButtonItem.tintColor= [UIColor redColor];
    self.navigationItem.rightBarButtonItem = nil;
//    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStyleDone target:self action:@selector(LoginButton:)]autorelease];
//    self.navigationItem.rightBarButtonItem.tintColor= [UIColor redColor];
    UIView *lLogin = [[[UIView alloc]initWithFrame:CGRectMake(20, 70, 280, 110)]autorelease];
    lLogin.layer.cornerRadius = 6.0;
    [lLogin setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:lLogin];
    UILabel *lUserLable = [[[UILabel alloc]initWithFrame:CGRectMake(5, 10, 80, 45)]autorelease];
    [lUserLable setText:@"账户名:"];
    [lUserLable setFont:[UIFont boldSystemFontOfSize:21]];
    [lUserLable setBackgroundColor:[UIColor orangeColor]];
    [lLogin addSubview:lUserLable];
    UILabel *lPasswordLable = [[[UILabel alloc]initWithFrame:CGRectMake(5, 55, 80, 45)]autorelease];
    [lPasswordLable setText:@"密   码:"];
    [lPasswordLable setFont:[UIFont boldSystemFontOfSize:21]];
    [lPasswordLable setBackgroundColor:[UIColor greenColor]];
    [lLogin addSubview:lPasswordLable];
    UITextField *lUserText = [[[UITextField alloc]initWithFrame:CGRectMake(90, 25, 170, 50)]autorelease];
    [lLogin addSubview:lUserText];
    UIButton *lLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [lLoginButton setFrame:CGRectMake(20, 200, 280, 40)];
    [lLoginButton setBackgroundColor:[UIColor redColor]];
    [lLoginButton.titleLabel setFont:[UIFont boldSystemFontOfSize:21]];
    [lLoginButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [lLoginButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [lLoginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:lLoginButton];
    UIButton *lRetrievePassword = [UIButton buttonWithType:UIButtonTypeCustom];
    [lRetrievePassword setFrame:CGRectMake(20, 260, 60, 30)];
    [lRetrievePassword setBackgroundColor:[UIColor clearColor]];
    [lRetrievePassword.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [lRetrievePassword.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [lRetrievePassword setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [lRetrievePassword setTitle:@"找回密码" forState:UIControlStateNormal];
    [lRetrievePassword addTarget:self action:@selector(RetrievePassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lRetrievePassword];
    UIButton *lOtherLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [lOtherLogin setFrame:CGRectMake(self.view.frame.size.width-160, 260, 140, 30)];
    [lOtherLogin setBackgroundColor:[UIColor clearColor]];
    [lOtherLogin.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [lOtherLogin.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [lOtherLogin setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [lOtherLogin setTitle:@"用合作网站帐号登录" forState:UIControlStateNormal];
    [lOtherLogin addTarget:self action:@selector(OtherLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lOtherLogin];
    
    UIButton *lFreeRegister = [UIButton buttonWithType:UIButtonTypeCustom];
    [lFreeRegister setFrame:CGRectMake(20, 310, 280, 40)];
    [lFreeRegister setBackgroundColor:[UIColor orangeColor]];
    [lFreeRegister.titleLabel setFont:[UIFont boldSystemFontOfSize:21]];
    [lFreeRegister.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [lFreeRegister setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [lFreeRegister setTitle:@"免费注册" forState:UIControlStateNormal];
    [lFreeRegister addTarget:self action:@selector(FreeRegister:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lFreeRegister];
}

-(void)CancelButton:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)LoginButton:(UIButton *)sender{
//    JD_Login *lJD_Login = [[[JD_Login alloc]init]autorelease];
//    [self.navigationController pushViewController:lJD_Login animated:YES];
}

-(void)FreeRegister:(UIButton *)sender{
        JD_Register *lJD_Register = [[[JD_Register alloc]init]autorelease];
        [self.navigationController pushViewController:lJD_Register animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
