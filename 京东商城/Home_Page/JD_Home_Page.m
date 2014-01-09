//
//  JD_Home_Page.m
//  京东商城
//
//  Created by TY on 14-1-3.
//  Copyright (c) 2014年 张闽. All rights reserved.
//

#import "JD_Home_Page.h"
#import "JD_UserLogin.h"

@interface JD_Home_Page ()

@end

@implementation JD_Home_Page

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabBar_item0_1@2x" ofType:@"png"]];
        
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
    self.tabBarController.navigationItem.title = nil;
    UIImageView *lLogo = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)]autorelease];
    UIBarButtonItem *FristBarButton = [[[UIBarButtonItem alloc]initWithCustomView:lLogo]autorelease];
    UISearchBar *lSearchBar = [[[UISearchBar alloc]initWithFrame:CGRectMake(44, 0, 257, 44)]autorelease];
    [[lSearchBar.subviews objectAtIndex:0] removeFromSuperview];
    [lSearchBar setBackgroundColor:[UIColor clearColor]];
    UIBarButtonItem *LastBarButton = [[[UIBarButtonItem alloc]initWithCustomView:lSearchBar]autorelease];
    [lLogo setImage:[UIImage imageNamed:@"companyLogo.png"]];
    self.tabBarController.navigationItem.leftBarButtonItems = @[FristBarButton,LastBarButton];
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
