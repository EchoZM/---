//
//  JD_Register.m
//  京东商城
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import "JD_Register.h"
#import "JD_Login.h"
@interface JD_Register ()

@end

@implementation JD_Register

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        Data = [[NSMutableData alloc]init];
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
    [UserText setPlaceholder:@"请输入用户名"];
    [UserText setKeyboardType:UIKeyboardTypeNamePhonePad];
    UserText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    UserText.font = [UIFont boldSystemFontOfSize:21];
    [lView addSubview:UserText];
    PasswordText = [[[UITextField alloc]initWithFrame:CGRectMake(20, 40, 170, 35)]autorelease];
    [PasswordText setBackgroundColor:[UIColor clearColor]];
    [PasswordText setPlaceholder:@"请输入密码"];
    [PasswordText setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [PasswordText setSecureTextEntry:YES];
    PasswordText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    PasswordText.font = [UIFont boldSystemFontOfSize:21];
    [lView addSubview:PasswordText];
    RePasswordText = [[[UITextField alloc]initWithFrame:CGRectMake(20, 80, 170, 45)]autorelease];
    [RePasswordText setBackgroundColor:[UIColor clearColor]];
    [RePasswordText setPlaceholder:@"请输入确认密码"];
    [RePasswordText setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [RePasswordText setSecureTextEntry:YES];
    RePasswordText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    RePasswordText.font = [UIFont boldSystemFontOfSize:21];
    [lView addSubview:RePasswordText];
    EmailText = [[[UITextField alloc]initWithFrame:CGRectMake(20, 120, 170, 45)]autorelease];
    [EmailText setBackgroundColor:[UIColor clearColor]];
    [EmailText setPlaceholder:@"请输入邮箱"];
    [EmailText setKeyboardType:UIKeyboardTypeURL];
    EmailText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    EmailText.font = [UIFont boldSystemFontOfSize:21];
    [lView addSubview:EmailText];
    TelephoneText = [[[UITextField alloc]initWithFrame:CGRectMake(20, 160, 170, 45)]autorelease];
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
    NSURL *lURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/shop/register.php",IP]];
    ASIFormDataRequest *lRequestForm = [[[ASIFormDataRequest alloc]initWithURL:lURL]autorelease];
    [lRequestForm setPostValue:UserText.text forKey:@"name"];
    [lRequestForm setPostValue:PasswordText.text forKey:@"password"];
    [lRequestForm setPostValue:EmailText.text forKey:@"email"];
    [lRequestForm setPostValue:TelephoneText.text forKey:@"telephone"];
    [lRequestForm startSynchronous];
    NSData *data = [[lRequestForm responseString] dataUsingEncoding:NSUTF8StringEncoding];
    NSNumber *lNumber = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil] objectForKey:@"error"];
    [lRequestForm responseString];
    if ([lNumber isEqualToNumber:[NSNumber numberWithInt:1]]) {
        UIAlertView *lErrorAlertView = [[[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名重复" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil]autorelease];
        [lErrorAlertView show];
    }else if ([lNumber isEqualToNumber:[NSNumber numberWithInt:0]]){
        UIAlertView *lErrorAlertView = [[[UIAlertView alloc]initWithTitle:@"提示" message:@"恭喜您，注册成功!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil]autorelease];
        [lErrorAlertView show];
        [JD_DataManager shareGoodsDataManager].UserRegisterState = YES;
        //        JD_Login *lJD_Login = [[[JD_Login alloc]init]autorelease];
        //        [self.navigationController popViewControllerAnimated:YES];
        //        lJD_Login.UserText.text = UserText.text;
        //        lJD_Login.PasswordText.text = PasswordText.text;
        
        NSLog(@"%@",[lRequestForm responseString]);
    }
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)View:(UIControl *)sender {
    if ([UserText resignFirstResponder]) {
        if (UserText.text.length  < 6 || UserText.text.length > 16) {
            UIAlertView *lErrorAlertView = [[[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名请输入6至16位" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil]autorelease];
            [lErrorAlertView show];
        }
//        else{
//            NSString *lBodyString = [NSString stringWithFormat:@"name=%@",UserText.text];
//            NSURL *lURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/shop/checkname.php",IP]];
//            ASIHTTPRequest *lRequest = [ASIHTTPRequest requestWithURL:lURL];
//            [lRequest setRequestMethod:@"get"];
////            lRequest set
//            [lRequest startSynchronous];
//            NSError *error = [lRequest error];
//            if (!error) {
//                NSString *str = [lRequest responseString];
//            }
//        }
    }
    if([PasswordText resignFirstResponder]){
        if (PasswordText.text.length  < 6 || PasswordText.text.length > 16) {
            UIAlertView *lErrorAlertView = [[[UIAlertView alloc]initWithTitle:@"提示" message:@"密码请输入6至16位" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil]autorelease];
            [lErrorAlertView show];
        }
    }
    if ([RePasswordText resignFirstResponder]){
        if (![PasswordText.text isEqualToString:RePasswordText.text]) {
            UIAlertView *lErrorAlertView = [[[UIAlertView alloc]initWithTitle:@"提示" message:@"两次密码输入不一致!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil]autorelease];
            [lErrorAlertView show];
        }
    }
    [EmailText resignFirstResponder];
    [TelephoneText resignFirstResponder];
}

-(void)dealloc{
    [UserText release];
    [PasswordText release];
    [RePasswordText release];
    [EmailText release];
    [TelephoneText release];
    [ShowPassword release];
    [Data release];
    [super dealloc];
}

@end


