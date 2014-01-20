//
//  JD_WelcomeView.m
//  京东商城
//
//  Created by TY on 14-1-3.
//  Copyright (c) 2014年 张闽. All rights reserved.
//

#import "JD_WelcomeView.h"
#import "JD_Home_Page.h"
#import "JD_Search.h"
#import "JD_ShopCar.h"
#import "JD_UserLogin.h"
@interface JD_WelcomeView ()

@end

@implementation JD_WelcomeView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"welcom"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(View_Transition:) userInfo:nil repeats:NO];
    //    UISearchBar *lSearchBar = [[[UISearchBar alloc]initWithFrame:CGRectMake(88, 0, 232, 44)]autorelease];
    //    [lSearchBar setBackgroundColor:[UIColor darkGrayColor]];
    //    [self.view addSubview:lSearchBar];
    //    UIButton *lLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [lLogin setFrame:CGRectMake((self.view.frame.size.width*2)/3+17, 44, 25, 15)];
    //    [lLogin addTarget:self action:@selector(UserLogin) forControlEvents:UIControlEventTouchUpInside];
    //    [lLogin setTitle:@"登录" forState:UIControlStateNormal];
    //    [lLogin.titleLabel setFont:[UIFont systemFontOfSize:12]];
    //    [lLogin setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    //    [lLogin setBackgroundColor:[UIColor yellowColor]];
    //    [self.view addSubview:lLogin];
    //    UIButton *lRegister = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [lRegister setFrame:CGRectMake((self.view.frame.size.width*2)/3+42, 44, 25, 15)];
    //    [lRegister setTitle:@"注册" forState:UIControlStateNormal];
    //    [lRegister.titleLabel setFont:[UIFont systemFontOfSize:12]];
    //    [lRegister setTitleColor:[UIColor purpleColor] /Users/ty/Desktop/Home_Page_NavigationforState:UIControlStateNormal];
    //    [lRegister setBackgroundColor:[UIColor yellowColor]];
    //    [self.view addSubview:lRegister];
    //    UIButton *lShopCar = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [lShopCar setFrame:CGRectMake((self.view.frame.size.width*2)/3+67, 44, 40, 15)];
    //    [lShopCar setTitle:@"购物车" forState:UIControlStateNormal];
    //    [lShopCar.titleLabel setFont:[UIFont systemFontOfSize:12]];
    //    [lShopCar setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    //    [lShopCar setBackgroundColor:[UIColor yellowColor]];
    //    [self.view addSubview:lShopCar];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)View_Transition:(NSTimer *)sender{
    JD_Home_Page *lHome_Page = [[[JD_Home_Page alloc]init]autorelease];
    JD_Search *lJD_Search = [[[JD_Search alloc]init]autorelease];
    JD_ShopCar *lJD_ShopCar = [[[JD_ShopCar alloc]init]autorelease];
    JD_UserLogin *lUserLogin = [[[JD_UserLogin alloc]init]autorelease];
    UITabBarController *lTabBarController = [[[UITabBarController alloc]init]autorelease];
    lTabBarController.viewControllers = @[lHome_Page,lJD_Search,lJD_ShopCar,lUserLogin];
    UINavigationController *lNavigation = [[[UINavigationController alloc]initWithRootViewController:lTabBarController]autorelease];
    [self presentViewController:lNavigation animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
