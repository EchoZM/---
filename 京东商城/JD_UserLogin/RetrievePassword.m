//
//  RetrievePassword.m
//  京东商城
//
//  Created by TY on 14-1-13.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import "RetrievePassword.h"

@interface RetrievePassword ()

@end

@implementation RetrievePassword

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
    self.navigationItem.title = @"找回密码";
    UIView *lLogin = [[[UIView alloc]initWithFrame:CGRectMake(20, 70, 280, 110)]autorelease];
    lLogin.layer.cornerRadius = 6.0;
    [lLogin setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Login.png"]]];
    [self.view addSubview:lLogin];
    UILabel *lUserLable = [[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 80, 40)]autorelease];
    [lUserLable setText:@"账户名:"];
    [lUserLable setFont:[UIFont boldSystemFontOfSize:21]];
    [lUserLable setBackgroundColor:[UIColor clearColor]];
    [lLogin addSubview:lUserLable];
    UILabel *lEmailLable = [[[UILabel alloc]initWithFrame:CGRectMake(5, 65, 80, 40)]autorelease];
    [lEmailLable setText:@"邮   箱:"];
    [lEmailLable setFont:[UIFont boldSystemFontOfSize:21]];
    [lEmailLable setBackgroundColor:[UIColor clearColor]];
    [lLogin addSubview:lEmailLable];
    UserText = [[UITextField alloc]initWithFrame:CGRectMake(90, 5, 170, 40)];
    [UserText setBackgroundColor:[UIColor clearColor]];
    UserText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    UserText.font = [UIFont boldSystemFontOfSize:21];
    [lLogin addSubview:UserText];
    EmailText = [[UITextField alloc]initWithFrame:CGRectMake(90, 65, 170, 40)];
    [EmailText setBackgroundColor:[UIColor clearColor]];
    EmailText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    EmailText.font = [UIFont boldSystemFontOfSize:21];
    [lLogin addSubview:EmailText];
    UIButton *lLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [lLoginButton setFrame:CGRectMake(20, 200, 280, 40)];
    [lLoginButton setBackgroundColor:[UIColor redColor]];
    [lLoginButton.titleLabel setFont:[UIFont boldSystemFontOfSize:21]];
    [lLoginButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [lLoginButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [lLoginButton addTarget:self action:@selector(Confirmation:) forControlEvents:UIControlEventTouchUpInside];
    [lLoginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:lLoginButton];
}

-(void)Confirmation:(UIButton *)sender{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
