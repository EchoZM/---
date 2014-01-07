//
//  JD_Login.m
//  京东商城
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import "JD_Login.h"

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
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStyleDone target:self action:@selector(LoginButton:)]autorelease];
    self.navigationItem.rightBarButtonItem.tintColor= [UIColor redColor];
}

-(void)CancelButton:(UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)LoginButton:(UIButton *)sender{
//    JD_Login *lJD_Login = [[[JD_Login alloc]init]autorelease];
//    [self.navigationController pushViewController:lJD_Login animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
