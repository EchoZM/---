//
//  JD_Search.m
//  京东商城
//
//  Created by TY on 14-1-3.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import "JD_Search.h"

@interface JD_Search ()

@end

@implementation JD_Search

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabBar_item1_1@2x" ofType:@"png"]];
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
    UISearchBar *lSearchBar = [[[UISearchBar alloc]initWithFrame:CGRectMake(44, 0, 320, 44)]autorelease];
    [[lSearchBar.subviews objectAtIndex:0] removeFromSuperview];
    [lSearchBar setBackgroundColor:[UIColor clearColor]];
    self.tabBarController.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]initWithCustomView:lSearchBar]autorelease];;
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
