//
//  JD_Login.m
//  JD_MALL
//
//  Created by TY on 14-1-14.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import "JD_Login.h"
#import "JD_Register.h"
#import "RetrievePassword.h"
@interface JD_Login ()

@end

@implementation JD_Login

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.view setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%f",self.view.frame.size.height);
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"登录";
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(CancelButton:)]autorelease];
    self.navigationItem.leftBarButtonItem.tintColor= [UIColor redColor];
    self.navigationItem.rightBarButtonItem = nil;
    UIView *lLogin = [[[UIView alloc]initWithFrame:CGRectMake(20, 70, 280, 110)]autorelease];
    lLogin.layer.cornerRadius = 6.0;
    [lLogin setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Login.png"]]];
    [self.view addSubview:lLogin];
    UILabel *lUserLable = [[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 80, 40)]autorelease];
    [lUserLable setText:@"账户名:"];
    [lUserLable setFont:[UIFont boldSystemFontOfSize:21]];
    [lUserLable setBackgroundColor:[UIColor clearColor]];
    [lLogin addSubview:lUserLable];
    UILabel *lPasswordLable = [[[UILabel alloc]initWithFrame:CGRectMake(5, 65, 80, 40)]autorelease];
    [lPasswordLable setText:@"密   码:"];
    [lPasswordLable setFont:[UIFont boldSystemFontOfSize:21]];
    [lPasswordLable setBackgroundColor:[UIColor clearColor]];
    [lLogin addSubview:lPasswordLable];
    _UserText = [[UITextField alloc]initWithFrame:CGRectMake(90, 5, 170, 40)];
    [_UserText setBackgroundColor:[UIColor clearColor]];
    [_UserText setPlaceholder:@"请输入帐户名"];
    [_UserText setKeyboardType:UIKeyboardTypeNamePhonePad];
    _UserText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _UserText.font = [UIFont boldSystemFontOfSize:21];
    [lLogin addSubview:_UserText];
    _PasswordText = [[UITextField alloc]initWithFrame:CGRectMake(90, 65, 170, 40)];
    [_PasswordText setBackgroundColor:[UIColor clearColor]];
    [_PasswordText setPlaceholder:@"请输入密码"];
    [_PasswordText setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [_PasswordText setSecureTextEntry:YES];
    _PasswordText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _PasswordText.font = [UIFont boldSystemFontOfSize:21];
    [lLogin addSubview:_PasswordText];
    UIButton *lLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [lLoginButton setFrame:CGRectMake(20, 200, 280, 40)];
    [lLoginButton setBackgroundColor:[UIColor redColor]];
    [lLoginButton.titleLabel setFont:[UIFont boldSystemFontOfSize:21]];
    [lLoginButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [lLoginButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [lLoginButton addTarget:self action:@selector(LoginButton:) forControlEvents:UIControlEventTouchUpInside];
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

-(void)CancelButton:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)RetrievePassword:(UIButton *)sender{
    RetrievePassword *lRetrievePassword = [[[RetrievePassword alloc]init]autorelease];
    [self.navigationController pushViewController:lRetrievePassword animated:YES];
}

-(void)FreeRegister:(UIButton *)sender{
    JD_Register *lJD_Register = [[[JD_Register alloc]init]autorelease];
    [self.navigationController pushViewController:lJD_Register animated:YES];
}

-(void)LoginButton:(UIButton *)sender{
    NSString *lBodyString = [NSString stringWithFormat:@"name=%@&password=%@",_UserText.text,_PasswordText.text];
    [[JD_DataManager shareGoodsDataManager] downloadDataWithHTTPMethod:@"post" WithBodyString:lBodyString WithURLString:@"login.php" AndSuccess:^(NSData *data){
        NSDictionary *lDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSNumber *lNumber = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil] objectForKey:@"error"];
        if ([lNumber isEqualToNumber:[NSNumber numberWithInt:0]] && [lDictionary objectForKey:@"msg"] != nil){
            NSArray *UserArray = @[[[lDictionary objectForKey:@"msg"] objectForKey:@"customerid"],[[lDictionary objectForKey:@"msg"] objectForKey:@"name"],[[lDictionary objectForKey:@"msg"] objectForKey:@"email"],[[lDictionary objectForKey:@"msg"] objectForKey:@"telephone"]];
            [[[JD_DataManager shareGoodsDataManager] UserManage] addObjectsFromArray:UserArray];
            [JD_DataManager shareGoodsDataManager].UserState = YES;
            [JD_DataManager shareGoodsDataManager].userID = [[lDictionary objectForKey:@"msg"] objectForKey:@"customerid"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            UIAlertView *lErrorAlertView = [[[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名或密码错误" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil]autorelease];
            [lErrorAlertView show];
        }
    }AndFailed:^{
        JD_NetworkPrompt *lNetWorkPrompt = [[[JD_NetworkPrompt alloc]init]autorelease];
        [self.view addSubview:lNetWorkPrompt];
    }];
}

- (IBAction)View:(UIControl *)sender {
    if ([_UserText resignFirstResponder]) {
        if ([_UserText.text length] < 6 || [_UserText.text length] > 18) {
            _UserText.text = @"";
            _UserText.placeholder = @"请输入6至18位";
        }
    }
    if ([_PasswordText resignFirstResponder]){
        if ([_PasswordText.text length] < 6 || [_PasswordText.text length] > 18) {
            _PasswordText.text = @"";
            _PasswordText.placeholder = @"请输入6至18位";
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [_UserText release];
    [_PasswordText release];
    [super dealloc];
}

@end
