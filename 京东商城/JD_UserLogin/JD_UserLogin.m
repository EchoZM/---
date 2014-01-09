//
//  JD_UserLogin.m
//  京东商城
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 张闽. All rights reserved.
//

#import "JD_UserLogin.h"
#import "JD_Login.h"
#import "MoreView.h"
@interface JD_UserLogin ()

@end

@implementation JD_UserLogin

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabBar_item4_1@2x" ofType:@"png"]];
        self.view.backgroundColor = [UIColor whiteColor];
        Array = [[NSMutableArray alloc]initWithArray:nil];
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
    if ([self.view.subviews count] != 0) {
        for (int i = 0; i < [self.view.subviews count]; i++) {
            [[self.view.subviews objectAtIndex:i] removeFromSuperview];
        }
    }
    self.tabBarController.navigationItem.leftBarButtonItems = nil;
    self.tabBarController.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]initWithTitle:@"更多" style:UIBarButtonItemStyleDone target:self action:@selector(MoreButton:)]autorelease];
    self.tabBarController.navigationItem.rightBarButtonItem.tintColor= [UIColor redColor];
    self.tabBarController.navigationItem.title = @"我的京东";
    UIView *lView = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 120)]autorelease];
    [lView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"myjd_head_background@2x.png"]]];
    [self.view addSubview:lView];
    UILabel *lWelcomeText = [[[UILabel alloc]initWithFrame:CGRectMake(0, 30, 320, 25)]autorelease];
    [lWelcomeText setText:@"欢迎来到京东"];
    [lWelcomeText setBackgroundColor:[UIColor clearColor]];
    [lWelcomeText setTextColor:[UIColor whiteColor]];
    lWelcomeText.layer.shadowColor = [UIColor blackColor].CGColor;
    lWelcomeText.layer.shadowOffset = CGSizeMake(0, 1);
    [lWelcomeText setTextAlignment:NSTextAlignmentCenter];
    [lWelcomeText setFont:[UIFont boldSystemFontOfSize:26]];
    [lView addSubview:lWelcomeText];
    UIView *lLoginBG = [[[UIView alloc]initWithFrame:CGRectMake(120, 65, 80, 40)]autorelease];
    [lLoginBG setBackgroundColor:[UIColor whiteColor]];
    lLoginBG.alpha = 0.5;
    lLoginBG.layer.cornerRadius = 6.0;
    [lView addSubview:lLoginBG];
    UIButton *lLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [lLogin setFrame:CGRectMake(120, 65, 80, 40)];
    [lLogin setBackgroundColor:[UIColor clearColor]];
    [lLogin.titleLabel setFont:[UIFont boldSystemFontOfSize:19]];
    [lLogin.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [lLogin setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [lLogin setTitle:@"登录" forState:UIControlStateNormal];
    [lLogin addTarget:self action:@selector(LoginButton:) forControlEvents:UIControlEventTouchUpInside];
    [lView addSubview:lLogin];
    TableView = [[[UITableView alloc]initWithFrame:CGRectMake(0, 120, 320, 262) style:UITableViewStyleGrouped]autorelease];
    TableView.backgroundView = nil;
    TableView.backgroundColor = [UIColor clearColor];
    TableView.delegate = self;
    TableView.dataSource = self;
    [TableView reloadData];
    [self.view addSubview:TableView];
}

-(void)LoginButton:(UIButton *)sender{
    JD_Login *lJD_Login = [[[JD_Login alloc]init]autorelease];
    [self.navigationController pushViewController:lJD_Login animated:YES];
}

-(void)MoreButton:(UIBarButtonItem *)sender{
    MoreView *lJD_MoreView = [[[MoreView alloc]init]autorelease];
    [self.navigationController pushViewController:lJD_MoreView animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"dfhfg";
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cell = @"cell";
    UITableViewCell *lcell = [tableView dequeueReusableCellWithIdentifier:cell];
    if (lcell == nil) {
        lcell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cell]autorelease];
    }
    return lcell;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
