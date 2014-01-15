//
//  AccountSafety.m
//  京东商城
//
//  Created by TY on 14-1-13.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import "AccountSafety.h"
#import "JD_Login.h"
@interface AccountSafety ()

@end

@implementation AccountSafety

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"帐户安全";
        self.tabBarItem.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabBar_item4_1@2x" ofType:@"png"]];
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"JD_1.png"]]];
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
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(BackButton:)];
        self.navigationItem.leftBarButtonItem.tintColor= [UIColor redColor];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(ConfirmButton:)];
        self.navigationItem.rightBarButtonItem.tintColor= [UIColor redColor];
        UIView *lView = [[[UIView alloc]initWithFrame:CGRectMake(10, 20, 300, 120)]autorelease];
        lView.layer.cornerRadius = 6.0;
        [lView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"AccountSafety.png"]]];
        [self.view addSubview:lView];
        UserText = [[UITextField alloc]initWithFrame:CGRectMake(20, 0, 170, 35)];
        [UserText setBackgroundColor:[UIColor clearColor]];
        [UserText setPlaceholder:@"请输入帐户名"];
        [UserText setKeyboardType:UIKeyboardTypeNamePhonePad];
        UserText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        UserText.font = [UIFont boldSystemFontOfSize:21];
        [lView addSubview:UserText];
        OldPasswordText = [[[UITextField alloc]initWithFrame:CGRectMake(20, 40, 170, 35)]autorelease];
        [OldPasswordText setBackgroundColor:[UIColor clearColor]];
        [OldPasswordText setPlaceholder:@"请输入旧密码"];
        [OldPasswordText setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
        [OldPasswordText setSecureTextEntry:YES];
        OldPasswordText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        OldPasswordText.font = [UIFont boldSystemFontOfSize:21];
        [lView addSubview:OldPasswordText];
        NewPasswordText = [[[UITextField alloc]initWithFrame:CGRectMake(20, 80, 170, 45)]autorelease];
        [NewPasswordText setBackgroundColor:[UIColor clearColor]];
        [NewPasswordText setPlaceholder:@"请输入新密码"];
        [NewPasswordText setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
        [NewPasswordText setSecureTextEntry:YES];
        NewPasswordText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        NewPasswordText.font = [UIFont boldSystemFontOfSize:21];
        [lView addSubview:NewPasswordText];
}

-(void)BackButton:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)ConfirmButton:(UIBarButtonItem *)sender{
    NSString *lBodyString = [NSString stringWithFormat:@"name=%@&oldpassword=%@&newpassword=%@",UserText.text,OldPasswordText.text,NewPasswordText];
    ;
    [[JD_DataManager shareGoodsDataManager] downloadDataWithBodyString:lBodyString WithURLString:@"changepassword.php" AndSuccess:^(NSData *data) {
        NSNumber *lNumber = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil] objectForKey:@"error"];
        if (![lNumber isEqualToNumber:[NSNumber numberWithInt:0]]){
            UIAlertView *lErrorAlertView = [[[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名或旧密码错误" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil]autorelease];
            [lErrorAlertView show];
        }else{
            UIAlertView *lErrorAlertView = [[[UIAlertView alloc]initWithTitle:@"提示" message:@"修改成功!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil]autorelease];
            [lErrorAlertView show];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } AndFailed:^{
        UIAlertView *lErrorAlertView = [[[UIAlertView alloc]initWithTitle:@"提示" message:@"修改成功!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil]autorelease];
        [lErrorAlertView show];
    }];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
