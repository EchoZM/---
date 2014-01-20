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
#import "JD_AccountManage.h"
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
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)View_Transition:(NSTimer *)sender{
    JD_Home_Page *lHome_Page = [[[JD_Home_Page alloc]init]autorelease];
    JD_Search *lJD_Search = [[[JD_Search alloc]init]autorelease];
    JD_ShopCar *lJD_ShopCar = [[[JD_ShopCar alloc]init]autorelease];
    JD_AccountManage *lJD_AccountManage = [[[JD_AccountManage alloc]init]autorelease];
    UITabBarController *lTabBarController = [[[UITabBarController alloc]init]autorelease];
    lTabBarController.viewControllers = @[lHome_Page,lJD_Search,lJD_ShopCar,lJD_AccountManage];
    UINavigationController *lNavigation = [[[UINavigationController alloc]initWithRootViewController:lTabBarController]autorelease];
    [self presentViewController:lNavigation animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
