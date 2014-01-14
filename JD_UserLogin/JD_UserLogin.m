//
//  JD_UserLogin.m
//  京东商城
//
//  Created by TY on 14-1-10.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import "JD_UserLogin.h"
#import "MoreView.h"
#import "JD_Login.h"
#import "OrderFromStateQuery.h"
#import "ObligationQuery.h"
#import "AllOrderFrom.h"
#import "GoodsEvaluationOrSingleOrder.h"
#import "ReturnGoods.h"
#import "subscribeTelServices.h"
#import "TakeDeliveryAddressManage.h"
#import "AccountSafety.h"
@interface JD_UserLogin ()

@end

@implementation JD_UserLogin

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabBar_item4_1@2x" ofType:@"png"]];
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"JD_BG.png"]]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    TextArray = [[NSMutableArray alloc]initWithArray:nil];
    ImageArray = [[NSMutableArray alloc]initWithArray:nil];
    ViewArray = [[NSMutableArray alloc]initWithArray:nil];
    OrderFromStateQuery *lOrderFromStateQuery = [[[OrderFromStateQuery alloc]init]autorelease];
    ObligationQuery *lObligationQuery = [[[ObligationQuery alloc]init]autorelease];
    AllOrderFrom *lAllOrderFrom = [[[AllOrderFrom alloc]init]autorelease];
    GoodsEvaluationOrSingleOrder *lGoodsEvaluationOrSingleOrder = [[[GoodsEvaluationOrSingleOrder alloc]init]autorelease];
    ReturnGoods *lReturnGoods = [[[ReturnGoods alloc]init]autorelease];
    subscribeTelServices *lsubscribeTelServices = [[[subscribeTelServices alloc]init]autorelease];
    TakeDeliveryAddressManage *lTakeDeliveryAddressManage = [[[TakeDeliveryAddressManage alloc]init]autorelease];
    AccountSafety *lAccountSafety = [[[AccountSafety alloc]init]autorelease];
    NSArray *lTextOrder = [[[NSArray alloc]initWithObjects:@"订单状态速查",@"待付款订单",@"全部订单", nil]autorelease];
//    NSArray *lTextMessage = [[[NSArray alloc]initWithObjects:@"消息中心",@"我的关注",@"浏览纪录", nil]autorelease];
    NSArray *lTextCommodityRelated = [[[NSArray alloc]initWithObjects:@"商品评价/晒单",@"返修/退换货",@"预约电话服务",@"收货地址管理",@"账户安全", nil]autorelease];
    NSArray *lImageOrder = [[[NSArray alloc]initWithObjects:@"myjd_orderStat@2x.png",@"myjd_waitOrder@2x.png",@"myjd_allOrder@2x.png", nil]autorelease];
//    NSArray *lImageMessage = [[[NSArray alloc]initWithObjects:@"myjd_message@2x.png",@"myStow-icon@2x.png",@"myjd_warehistory@2x.png", nil]autorelease];
    NSArray *lImageCommodityRelated = [[[NSArray alloc]initWithObjects:@"myjd_share@2x.png",@"myjd_returnWare@2x.png",@"myjd_tbis@2x.png",@"myjd_adress@2x.png",@"myjd_accountSafe@2x.png", nil]autorelease];
    NSArray *lViewOrder = [[[NSArray alloc]initWithObjects:lOrderFromStateQuery,lObligationQuery,lAllOrderFrom, nil]autorelease];
    NSArray *lViewCommodityRelated = [[[NSArray alloc]initWithObjects:lGoodsEvaluationOrSingleOrder,lReturnGoods,lsubscribeTelServices,lTakeDeliveryAddressManage,lAccountSafety, nil]autorelease];
    [TextArray addObject:lTextOrder];
//    [TextArray addObject:lTextMessage];
    [TextArray addObject:lTextCommodityRelated];
    [ImageArray addObject:lImageOrder];
//    [ImageArray addObject:lImageMessage];
    [ImageArray addObject:lImageCommodityRelated];
    [ViewArray addObject:lViewOrder];
    [ViewArray addObject:lViewCommodityRelated];
    TableView = [[[UITableView alloc]initWithFrame:CGRectMake(0, 115, 320, 262) style:UITableViewStyleGrouped]autorelease];
    TableView.backgroundView = nil;
    TableView.backgroundColor = [UIColor clearColor];
    TableView.delegate = self;
    TableView.dataSource = self;
    [self.view addSubview:TableView];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [TableView reloadData];
    self.tabBarController.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]initWithTitle:@"更多" style:UIBarButtonItemStyleDone target:self action:@selector(MoreButton:)]autorelease];
    self.tabBarController.navigationItem.rightBarButtonItem.tintColor= [UIColor redColor];
    self.tabBarController.navigationItem.title = @"我的京东";
    UIView *lView = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 115)]autorelease];
    [lView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"myjd_head_background.png"]]];
    if ([JD_DataManager shareGoodsDataManager].UserState == NO) {
        self.tabBarController.navigationItem.leftBarButtonItems = nil;
        UILabel *lWelcomeText = [[[UILabel alloc]initWithFrame:CGRectMake(0, 25, 320, 25)]autorelease];
        [lWelcomeText setText:@"欢迎来到京东"];
        [lWelcomeText setBackgroundColor:[UIColor clearColor]];
        [lWelcomeText setTextColor:[UIColor whiteColor]];
        lWelcomeText.layer.shadowColor = [UIColor blackColor].CGColor;
        lWelcomeText.layer.shadowOffset = CGSizeMake(0, 1);
        [lWelcomeText setTextAlignment:NSTextAlignmentCenter];
        [lWelcomeText setFont:[UIFont boldSystemFontOfSize:26]];
        [lView addSubview:lWelcomeText];
        UIView *lLoginBG = [[[UIView alloc]initWithFrame:CGRectMake(120, 60, 80, 40)]autorelease];
        [lLoginBG setBackgroundColor:[UIColor whiteColor]];
        lLoginBG.alpha = 0.5;
        lLoginBG.layer.cornerRadius = 6.0;
        [lView addSubview:lLoginBG];
        UIButton *lLogin = [UIButton buttonWithType:UIButtonTypeCustom];
        [lLogin setFrame:CGRectMake(120, 60, 80, 40)];
        [lLogin setBackgroundColor:[UIColor clearColor]];
        [lLogin.titleLabel setFont:[UIFont boldSystemFontOfSize:19]];
        [lLogin.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [lLogin setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        [lLogin setTitle:@"登录" forState:UIControlStateNormal];
        [lLogin addTarget:self action:@selector(LoginButton:) forControlEvents:UIControlEventTouchUpInside];
        [lView addSubview:lLogin];
    }else{
        UIBarButtonItem *lSignOut = [[UIBarButtonItem alloc]initWithTitle:@"退出" style:UIBarButtonItemStyleDone target:self action:@selector(SignOut:)];
        self.tabBarController.navigationItem.leftBarButtonItems = @[lSignOut];
        self.tabBarController.navigationItem.leftBarButtonItem.tintColor= [UIColor redColor];
        [lView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"myjd_defalut_background.png"]]];
        UIImageView *lHeardImageView = [[[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 70, 70)]autorelease];
        [lHeardImageView setBackgroundColor:[UIColor redColor]];
       //        [lHeardImageView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@""]]];
        [lView addSubview:lHeardImageView];
        UILabel *lUserName = [[[UILabel alloc]initWithFrame:CGRectMake(125, 20, 160, 25)]autorelease];
        [lUserName setBackgroundColor:[UIColor greenColor]];
        [lUserName setText:[NSString stringWithFormat:@"%@",[[[JD_DataManager shareGoodsDataManager] UserManage] objectAtIndex:0]]];
        [lUserName setTextColor:[UIColor whiteColor]];
        lUserName.layer.shadowColor = [UIColor blackColor].CGColor;
        lUserName.layer.shadowOffset = CGSizeMake(0, 1);
        [lUserName setTextAlignment:NSTextAlignmentLeft];
        [lUserName setFont:[UIFont boldSystemFontOfSize:21]];
        [lView addSubview:lUserName];
    }
    [self.view addSubview:lView];
    [TableView reloadData];
}

-(void)MoreButton:(UIBarButtonItem *)sender{
    MoreView *lJD_MoreView = [[[MoreView alloc]init]autorelease];
    [self.navigationController pushViewController:lJD_MoreView animated:YES];
}
-(void)SignOut:(UIBarButtonItem *)sender{
    [JD_DataManager shareGoodsDataManager].UserState = NO;
    [[[JD_DataManager shareGoodsDataManager] UserManage] removeAllObjects];
}
-(void)LoginButton:(UIButton *)sender{
    JD_Login *lJD_Login = [[[JD_Login alloc]init]autorelease];
    [self.navigationController pushViewController:lJD_Login animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[TextArray objectAtIndex:section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [TextArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cell = @"cell";
    UITableViewCell *lcell = [tableView dequeueReusableCellWithIdentifier:cell];
    if (lcell == nil) {
        lcell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cell]autorelease];
    }
    lcell.backgroundColor = [UIColor clearColor];
    lcell.imageView.image = [UIImage imageNamed:[[ImageArray objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]]];
    lcell.textLabel.text = [[TextArray objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
    lcell.textLabel.font = [UIFont boldSystemFontOfSize:12];
    lcell.accessoryType = UITableViewCellAccessoryNone;
    lcell.selectionStyle = UITableViewCellEditingStyleNone;
    return lcell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([JD_DataManager shareGoodsDataManager].UserState == NO) {
        JD_Login *lJD_Login = [[[JD_Login alloc]init]autorelease];
        [self.tabBarController.navigationController pushViewController:lJD_Login animated:YES];
    }else{
        [self.navigationController pushViewController:[[ViewArray objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]] animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [TableView release];
    [TextArray release];
    [super dealloc];
}
@end
