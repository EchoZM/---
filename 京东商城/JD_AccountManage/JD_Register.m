//
//  JD_Register.m
//  JD_MALL
//
//  Created by TY on 14-1-14.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import "JD_Register.h"

@interface JD_Register ()

@end

@implementation JD_Register

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
    self.navigationItem.title = @"普通用户注册";
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(CancelButton:)]autorelease];
    self.navigationItem.leftBarButtonItem.tintColor= [UIColor redColor];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(RegisterButton:)]autorelease];
    self.navigationItem.rightBarButtonItem.tintColor= [UIColor redColor];
    UIView *lView = [[[UIView alloc]initWithFrame:CGRectMake(20, 20, 280, 200)]autorelease];
    lView.layer.cornerRadius = 6.0;
    [lView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Register.png"]]];
    [self.view addSubview:lView];
    UserText = [[UITextField alloc]initWithFrame:CGRectMake(20, 0, 170, 35)];
    [UserText setBackgroundColor:[UIColor clearColor]];
    [UserText setPlaceholder:@"请输入帐户名"];
    [UserText setKeyboardType:UIKeyboardTypeNamePhonePad];
    UserText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    UserText.font = [UIFont boldSystemFontOfSize:21];
    [lView addSubview:UserText];
    PasswordText = [[UITextField alloc]initWithFrame:CGRectMake(20, 40, 170, 35)];
    [PasswordText setBackgroundColor:[UIColor clearColor]];
    [PasswordText setPlaceholder:@"请输入密码"];
    [PasswordText setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [PasswordText setSecureTextEntry:YES];
    PasswordText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    PasswordText.font = [UIFont boldSystemFontOfSize:21];
    [lView addSubview:PasswordText];
    RePasswordText = [[UITextField alloc]initWithFrame:CGRectMake(20, 80, 170, 45)];
    [RePasswordText setBackgroundColor:[UIColor clearColor]];
    [RePasswordText setPlaceholder:@"请输入确认密码"];
    [RePasswordText setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [RePasswordText setSecureTextEntry:YES];
    RePasswordText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    RePasswordText.font = [UIFont boldSystemFontOfSize:21];
    [lView addSubview:RePasswordText];
    EmailText = [[UITextField alloc]initWithFrame:CGRectMake(20, 120, 170, 45)];
    [EmailText setBackgroundColor:[UIColor clearColor]];
    [EmailText setPlaceholder:@"请输入邮箱"];
    [EmailText setKeyboardType:UIKeyboardTypeURL];
    EmailText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    EmailText.font = [UIFont boldSystemFontOfSize:21];
    [lView addSubview:EmailText];
    TelephoneText = [[UITextField alloc]initWithFrame:CGRectMake(20, 160, 170, 45)];
    [TelephoneText setBackgroundColor:[UIColor clearColor]];
    [TelephoneText setPlaceholder:@"请输入电话号码"];
    [TelephoneText setKeyboardType:UIKeyboardTypeNumberPad];
    TelephoneText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    TelephoneText.font = [UIFont boldSystemFontOfSize:21];
    [lView addSubview:TelephoneText];
    ShowPassword = [UIButton buttonWithType:UIButtonTypeCustom];
    [ShowPassword setTag:10000];
    [ShowPassword setFrame:CGRectMake(40, 240, 28, 28)];
    ShowPassword.layer.cornerRadius = 6;
    [ShowPassword setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"radiobox_0.png"]]];
    [ShowPassword addTarget:self action:@selector(ShowPassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ShowPassword];
    UILabel *lShowPasswordLable = [[[UILabel alloc]initWithFrame:CGRectMake(70, 240, 100, 28)]autorelease];
    [lShowPasswordLable setBackgroundColor:[UIColor clearColor]];
    [lShowPasswordLable setText:@"显示密码"];
    lShowPasswordLable.font = [UIFont boldSystemFontOfSize:19];
    [lShowPasswordLable setTextColor:[UIColor purpleColor]];
    [self.view addSubview:lShowPasswordLable];
}

-(void)CancelButton:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)RegisterButton:(UIBarButtonItem *)sender{
    NSString *lBodyString = [NSString stringWithFormat:@"name=%@&password=%@&email=%@&telephone=%@",UserText.text,PasswordText.text,EmailText.text,TelephoneText.text];
    [[JD_DataManager shareGoodsDataManager] downloadDataWithHTTPMethod:@"post" WithBodyString:lBodyString WithURLString:@"register.php" AndSuccess:^(NSData *data) {
        NSDictionary *lDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSNumber *lNumber = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil] objectForKey:@"error"];
        NSLog(@"%@",lDictionary);
        if ([lNumber isEqualToNumber:[NSNumber numberWithInt:0]] && [lDictionary objectForKey:@"msg"] != nil){
            [JD_DataManager shareGoodsDataManager].UserRegisterState = YES;
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            if ([lNumber isEqualToNumber:[NSNumber numberWithInt:1]] && [lDictionary objectForKey:@"msg"] != nil) {
                UserText.text = @"";
                UserText.placeholder = @"用户名重复";
            }else{
                UIAlertView *lErrorAlertView = [[[UIAlertView alloc]initWithTitle:@"提示" message:@"用户信息录入不完整，请仔细核对!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil]autorelease];
                [lErrorAlertView show];
            }
        }
    } AndFailed:^{
        JD_NetworkPrompt *lNetWorkPrompt = [[[JD_NetworkPrompt alloc]init]autorelease];
        [self.view addSubview:lNetWorkPrompt];
    }];
}

-(void)ShowPassword:(UIButton *)sender{
    if (sender.tag == 10000) {
        [ShowPassword setImage:[UIImage imageNamed:@"checkbox_1@2x.png"] forState:UIControlStateNormal];
        [PasswordText setSecureTextEntry:NO];
        [RePasswordText setSecureTextEntry:NO];
        sender.tag = 10001;
    }else{
        [ShowPassword setImage:nil forState:UIControlStateNormal];
        [PasswordText setSecureTextEntry:YES];
        [RePasswordText setSecureTextEntry:YES];
        sender.tag = 10000;
    }
}

- (IBAction)View:(UIControl *)sender {
    //失去焦点，检查用户名合法性
    if ([UserText resignFirstResponder]) {
        [[JD_DataManager shareGoodsDataManager] downloadDataWithHTTPMethod:@"get" WithBodyString:nil WithURLString:[NSString stringWithFormat:@"checkname.php?name=%@",UserText.text] AndSuccess:^(NSData *data) {
            NSNumber *lError = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil] objectForKey:@"error"];
            NSNumber *lMsg = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil] objectForKey:@"msg"];
            if ([UserText.text length] < 6 || [UserText.text length] > 18){
                UserText.text = @"";
                UserText.placeholder = @"请输入6至18位";
            }else if(!([lError isEqualToNumber:[NSNumber numberWithInt:0]] && [lMsg isEqualToNumber:[NSNumber numberWithInt:1]])){
                UserText.text = @"";
                UserText.placeholder = @"用户名不可用";
            }
        } AndFailed:^{
            JD_NetworkPrompt *lNetWorkPrompt = [[[JD_NetworkPrompt alloc]init]autorelease];
            [self.view addSubview:lNetWorkPrompt];
        }];
    }
    //失去焦点，检查密码合法性
    if ([PasswordText resignFirstResponder]) {
        [[JD_DataManager shareGoodsDataManager] downloadDataWithHTTPMethod:@"get" WithBodyString:nil WithURLString:[NSString stringWithFormat:@"checkpassword.php?password=%@",PasswordText.text] AndSuccess:^(NSData *data) {
            NSNumber *lError = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil] objectForKey:@"error"];
            NSNumber *lMsg = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil] objectForKey:@"msg"];
            if ([PasswordText.text length] < 6 || [PasswordText.text length] > 18){
                PasswordText.text = @"";
                PasswordText.placeholder = @"请输入6至18位";
            }else if(!([lError isEqualToNumber:[NSNumber numberWithInt:0]] && [lMsg isEqualToNumber:[NSNumber numberWithInt:1]])){
                PasswordText.text = @"";
                PasswordText.placeholder = @"密码不可用";
            }
        } AndFailed:^{
            JD_NetworkPrompt *lNetWorkPrompt = [[[JD_NetworkPrompt alloc]init]autorelease];
            [self.view addSubview:lNetWorkPrompt];
        }];
    }
    if ([RePasswordText resignFirstResponder]) {
        if (![RePasswordText.text isEqualToString:PasswordText.text]) {
            RePasswordText.text = @"";
            RePasswordText.placeholder = @"密码输入不一致";
        }
    }
    //失去焦点，检查邮箱合法性
    if ([EmailText resignFirstResponder]) {
        [[JD_DataManager shareGoodsDataManager] downloadDataWithHTTPMethod:@"get" WithBodyString:nil WithURLString:[NSString stringWithFormat:@"checkemail.php?email=%@",EmailText.text] AndSuccess:^(NSData *data) {
            NSNumber *lError = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil] objectForKey:@"error"];
            NSNumber *lMsg = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil] objectForKey:@"msg"];
            NSString *LEmail = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,5}";
            NSPredicate *lPredicate = [NSPredicate predicateWithFormat:@"self MATCHES %@",LEmail ];
            if (![lPredicate evaluateWithObject:[NSString stringWithFormat:@"%@",EmailText.text]]){
                EmailText.text = @"";
                EmailText.placeholder = @"输入正确邮箱";
            }else if(!([lError isEqualToNumber:[NSNumber numberWithInt:0]] && [lMsg isEqualToNumber:[NSNumber numberWithInt:1]])){
                EmailText.text = @"";
                EmailText.placeholder = @"邮箱不可用";
            }
        } AndFailed:^{
            JD_NetworkPrompt *lNetWorkPrompt = [[[JD_NetworkPrompt alloc]init]autorelease];
            [self.view addSubview:lNetWorkPrompt];
        }];
    }
    //失去焦点，检查电话合法性
    if ([TelephoneText resignFirstResponder]) {
        [[JD_DataManager shareGoodsDataManager] downloadDataWithHTTPMethod:@"get" WithBodyString:nil WithURLString:[NSString stringWithFormat:@"checktelephone.php?telephone=%@",TelephoneText.text] AndSuccess:^(NSData *data) {
            NSNumber *lError = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil] objectForKey:@"error"];
            NSNumber *lMsg = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil] objectForKey:@"msg"];
            NSLog(@"%@,%@",lError,lMsg);
            NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
            NSPredicate *lPredicate = [NSPredicate predicateWithFormat:@"self MATCHES %@", regex];
            if (![lPredicate evaluateWithObject:[NSString stringWithFormat:@"%@",TelephoneText.text]]){
                TelephoneText.text = @"";
                TelephoneText.placeholder = @"输入正确电话号码";
            }else if(!([lError isEqualToNumber:[NSNumber numberWithInt:0]] && [lMsg isEqualToNumber:[NSNumber numberWithInt:1]])){
                TelephoneText.text = @"";
                TelephoneText.placeholder = @"电话号码不可用";
            }
        } AndFailed:^{
            JD_NetworkPrompt *lNetWorkPrompt = [[[JD_NetworkPrompt alloc]init]autorelease];
            [self.view addSubview:lNetWorkPrompt];
        }];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [UserText release];
    [PasswordText release];
    [RePasswordText release];
    [EmailText release];
    [TelephoneText release];
    [ShowPassword release];
    [super dealloc];
}
    
@end
