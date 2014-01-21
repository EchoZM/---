//
//  JD_UserLogin.m
//  京东商城
//
//  Created by TY on 14-1-10.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import "JD_AccountManage.h"
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
@interface JD_AccountManage ()
@end

@implementation JD_AccountManage

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabBar_item4_1@2x" ofType:@"png"]];
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
    NSArray *lTextCommodityRelated = [[[NSArray alloc]initWithObjects:@"商品评价/晒单",@"返修/退换货",@"预约电话服务",@"收货地址管理",@"修改密码", nil]autorelease];
    NSArray *lImageOrder = [[[NSArray alloc]initWithObjects:@"myjd_orderStat@2x.png",@"myjd_waitOrder@2x.png",@"myjd_allOrder@2x.png", nil]autorelease];
    NSArray *lImageCommodityRelated = [[[NSArray alloc]initWithObjects:@"myjd_share@2x.png",@"myjd_returnWare@2x.png",@"myjd_tbis@2x.png",@"myjd_adress@2x.png",@"myjd_accountSafe@2x.png", nil]autorelease];
    NSArray *lViewOrder = [[[NSArray alloc]initWithObjects:lOrderFromStateQuery,lObligationQuery,lAllOrderFrom, nil]autorelease];
    NSArray *lViewCommodityRelated = [[[NSArray alloc]initWithObjects:lGoodsEvaluationOrSingleOrder,lReturnGoods,lsubscribeTelServices,lTakeDeliveryAddressManage,lAccountSafety, nil]autorelease];
    [TextArray addObject:lTextOrder];
    [TextArray addObject:lTextCommodityRelated];
    [ImageArray addObject:lImageOrder];
    [ImageArray addObject:lImageCommodityRelated];
    [ViewArray addObject:lViewOrder];
    [ViewArray addObject:lViewCommodityRelated];
    TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 115, 320, self.view.frame.size.height - 164) style:UITableViewStyleGrouped];
    TableView.backgroundView = nil;
    TableView.backgroundColor = [UIColor clearColor];
    TableView.delegate = self;
    TableView.dataSource = self;
    [self.view addSubview:TableView];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self NavigationFurbish];
}

-(void)NavigationFurbish{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [TableView reloadData];
    self.tabBarController.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]initWithTitle:@"更多" style:UIBarButtonItemStyleDone target:self action:@selector(MoreButton:)]autorelease];
    self.tabBarController.navigationItem.rightBarButtonItem.tintColor= [UIColor redColor];
    self.tabBarController.navigationItem.title = @"我的帐户";
    UIView *lView = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 115)]autorelease];
    [lView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"myjd_head_background.png"]]];
    if ([JD_DataManager shareGoodsDataManager].UserState == NO) {
        self.tabBarController.navigationItem.leftBarButtonItems = nil;
        UILabel *lWelcomeText = [[[UILabel alloc]initWithFrame:CGRectMake(0, 25, 320, 25)]autorelease];
        [lWelcomeText setText:@"欢迎来到墨云"];
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
        HeardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [HeardButton setFrame:CGRectMake(20, 20, 69, 69)];
        [HeardButton setImage:[UIImage imageNamed:@"user_header_placeholder@2x.png"] forState:UIControlStateNormal];
        [HeardButton addTarget:self action:@selector(ChoiceHeadImageClick:) forControlEvents:UIControlEventTouchUpInside];
        [lView addSubview:HeardButton];
        UILabel *lUserName = [[[UILabel alloc]initWithFrame:CGRectMake(110, 20, 160, 25)]autorelease];
        [lUserName setBackgroundColor:[UIColor greenColor]];
        [lUserName setText:[NSString stringWithFormat:@"%@",[[[JD_DataManager shareGoodsDataManager] UserManage] objectAtIndex:1]]];
        [lUserName setTextColor:[UIColor whiteColor]];
        [lUserName setBackgroundColor:[UIColor clearColor]];
        lUserName.layer.shadowColor = [UIColor blackColor].CGColor;
        lUserName.layer.shadowOffset = CGSizeMake(0, 1);
        [lUserName setTextAlignment:NSTextAlignmentLeft];
        [lUserName setFont:[UIFont boldSystemFontOfSize:18]];
        [lView addSubview:lUserName];
        UILabel *lUserID = [[[UILabel alloc]initWithFrame:CGRectMake(110, 45, 160, 25)]autorelease];
        [lUserID setBackgroundColor:[UIColor greenColor]];
        [lUserID setText:[NSString stringWithFormat:@"%@",[[[JD_DataManager shareGoodsDataManager] UserManage] objectAtIndex:0]]];
        [lUserID setTextColor:[UIColor whiteColor]];
        [lUserID setBackgroundColor:[UIColor clearColor]];
        lUserID.layer.shadowColor = [UIColor blackColor].CGColor;
        lUserID.layer.shadowOffset = CGSizeMake(0, 1);
        [lUserID setTextAlignment:NSTextAlignmentLeft];
        [lUserID setFont:[UIFont boldSystemFontOfSize:18]];
        [lView addSubview:lUserID];
        UILabel *lUserRole = [[[UILabel alloc]initWithFrame:CGRectMake(110, 70, 160, 25)]autorelease];
        [lUserRole setBackgroundColor:[UIColor greenColor]];
        if ([JD_DataManager shareGoodsDataManager].UserState == YES) {
            [lUserRole setText:@"注册用户"];
        }
        [lUserRole setTextColor:[UIColor whiteColor]];
        [lUserRole setBackgroundColor:[UIColor clearColor]];
        lUserRole.layer.shadowColor = [UIColor blackColor].CGColor;
        lUserRole.layer.shadowOffset = CGSizeMake(0, 1);
        [lUserRole setTextAlignment:NSTextAlignmentLeft];
        [lUserRole setFont:[UIFont boldSystemFontOfSize:18]];
        [lView addSubview:lUserRole];
        
    }
    [self.view addSubview:lView];
    [TableView reloadData];
}

-(void)MoreButton:(UIBarButtonItem *)sender{
    MoreView *lJD_MoreView = [[[MoreView alloc]init]autorelease];
    [self.navigationController pushViewController:lJD_MoreView animated:YES];
}
-(void)SignOut:(UIBarButtonItem *)sender{
    UIAlertView *lAlertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确认退出?" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:@"确认", nil];
    lAlertView.inputView.backgroundColor = [UIColor redColor];
    [lAlertView show];
    [lAlertView release];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [JD_DataManager shareGoodsDataManager].UserState = NO;
        [[[JD_DataManager shareGoodsDataManager] UserManage] removeAllObjects];
        [self NavigationFurbish];
    }
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
        UIImageView *ImageView = [[[UIImageView alloc]initWithFrame:CGRectMake(15, 7, 30, 30)]autorelease];
        ImageView.tag = 10000;
        [lcell addSubview:ImageView];
        UILabel *lLable = [[[UILabel alloc]initWithFrame:CGRectMake(50, 0, 150, 44)]autorelease];
        lLable.tag = 10001;
        [lcell addSubview:lLable];
    }
    
    lcell.backgroundColor = [UIColor clearColor];
    UIImageView *ImageView = (UIImageView *)[lcell viewWithTag:10000];
    ImageView.image =[UIImage imageNamed:[[ImageArray objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]]];
    UILabel *Lable = (UILabel *)[lcell viewWithTag:10001];
    Lable.text = [[TextArray objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
    Lable.backgroundColor = [UIColor clearColor];
    Lable.font = [UIFont boldSystemFontOfSize:15];
    Lable.textColor = [UIColor purpleColor];
    lcell.accessoryType = UITableViewCellAccessoryNone;
    lcell.selectionStyle = UITableViewCellEditingStyleNone;
    return lcell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([JD_DataManager shareGoodsDataManager].UserState == YES) {
        [self.navigationController pushViewController:[[ViewArray objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]] animated:YES];
    }else{
        JD_Login *lJD_Login = [[[JD_Login alloc]init]autorelease];
        [self.navigationController pushViewController:lJD_Login animated:YES];
    }

}

-(void)ChoiceHeadImageClick:(UIButton *)sender{
    UIActionSheet *lActionSheet = [[[UIActionSheet alloc]initWithTitle:@"请选择图片源" delegate:self cancelButtonTitle:@"退出" destructiveButtonTitle:@"本机相册" otherButtonTitles:@"摄像头", nil]autorelease];
    [lActionSheet showInView:self.view];
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:{
            UIImagePickerController *lImagePickerController = [[[UIImagePickerController alloc]init]autorelease];
            lImagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            lImagePickerController.delegate = self;
            [self presentViewController:lImagePickerController animated:YES completion:nil];
            break;
        }
        case 1:{
            UIImagePickerController *lImagePickerController = [[[UIImagePickerController alloc]init]autorelease];
            lImagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:lImagePickerController animated:YES completion:nil];
            break;
        }
        default:
            break;
    }
}
#pragma mark imagePickerController
//图片效果切换
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *lImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [self dismissViewControllerAnimated:YES completion:^{
        CATransition *lTransition = [CATransition animation];
        [lTransition setDuration:2.0];
        [lTransition setDelegate:self];
        [lTransition setType:@"rippleEffect"];
        [lTransition setSubtype:kCAAlignmentLeft];
        [HeardButton.imageView.layer addAnimation:lTransition forKey:@"Animation"];
        [HeardButton setImage:lImage forState:UIControlStateNormal];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [TableView release];
    [TextArray release];
    [HeardButton release];
    [super dealloc];
}
@end
