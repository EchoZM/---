//
//  TakeDeliveryAddressManage.m
//  京东商城
//
//  Created by TY on 14-1-13.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import "TakeDeliveryAddressManage.h"
#import "AddComment.h"
#import "AddressInfoViewController.h"
@interface TakeDeliveryAddressManage ()

@end

@implementation TakeDeliveryAddressManage

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"收货地址管理";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 40, 40);
    [backButton setImage:[UIImage imageNamed:@"title_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(BackButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    [leftBarButton release];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithTitle:@"新建" style:UIBarButtonItemStylePlain target:self action:@selector(NewButton:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    self.navigationItem.rightBarButtonItem.tintColor= [UIColor redColor];
    [rightBarButton release];
    
    for (UIView *lView in self.view.subviews) {
        [lView removeFromSuperview];
    }
    NSString *bodyString = [NSString stringWithFormat:@"customerid=%@",[JD_DataManager shareGoodsDataManager].userID];
    [[JD_DataManager shareGoodsDataManager] downloadDataWithHTTPMethod:@"post" WithBodyString:bodyString WithURLString:@"getaddress.php" AndSuccess:^(NSData *data){
        NSDictionary *lDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSString *error = [NSString stringWithFormat:@"%@",[lDictionary objectForKey:@"error"]];
        if ([error isEqualToString:@"0"]) {
            NSDictionary *lDic = [lDictionary objectForKey:@"msg"];
            NSString *count = [NSString stringWithFormat:@"%@",[lDic objectForKey:@"count"]];
            if ([count isEqualToString:@"0"]) {
                UILabel *lLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 250, 50)];
                lLabel.center = self.view.center;
                lLabel.text = @"还没有地址，请新建地址！";
                lLabel.backgroundColor = [UIColor whiteColor];
                lLabel.textColor = [UIColor blackColor];
                lLabel.textAlignment = NSTextAlignmentCenter;
                lLabel.font = [UIFont systemFontOfSize:18];
                [self.view addSubview:lLabel];
                [lLabel release];
            }else{
                _infoviewArray = [[NSMutableArray alloc]initWithArray:[lDic objectForKey:@"info"]];
                _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
                _tableView.dataSource = self;
                _tableView.delegate = self;
                _tableView.backgroundView = nil;
                _tableView.bounces = NO;
                [_tableView.tableHeaderView removeFromSuperview];
                _tableView.showsVerticalScrollIndicator = NO;
                [self.view addSubview:_tableView];
            }
        }else{
            NSLog(@"请求失败！");
        }
    }AndFailed:^{
        UILabel *lLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
        lLabel.center = self.view.center;
        lLabel.text = @"无有效网络！";
        lLabel.backgroundColor = [UIColor whiteColor];
        lLabel.textColor = [UIColor blackColor];
        lLabel.textAlignment = NSTextAlignmentCenter;
        lLabel.font = [UIFont systemFontOfSize:24];
        [self.view addSubview:lLabel];
        [lLabel release];
    }];
}

-(void)BackButton:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)NewButton:(UIBarButtonItem *)sender
{
    AddComment *lAddComment = [[AddComment alloc]init];
    [self.navigationController pushViewController:lAddComment animated:YES];
    [lAddComment release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [_infoviewArray release];
    [_tableView release];
    [super dealloc];
}
#pragma mark - TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _infoviewArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    UITableViewCell *lCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (lCell == nil) {
        lCell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID]autorelease];
        lCell.selectionStyle = UITableViewCellSelectionStyleNone;
        lCell.backgroundColor = [UIColor clearColor];
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 110, 30)];
        nameLabel.tag = 11;
        nameLabel.backgroundColor = [UIColor whiteColor];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.font = [UIFont systemFontOfSize:16];
        [lCell addSubview:nameLabel];
        [nameLabel release];
        UILabel *telephoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 5, 150, 30)];
        telephoneLabel.tag = 22;
        telephoneLabel.backgroundColor = [UIColor whiteColor];
        telephoneLabel.textColor = [UIColor blackColor];
        telephoneLabel.textAlignment = NSTextAlignmentRight;
        telephoneLabel.font = [UIFont systemFontOfSize:16];
        [lCell addSubview:telephoneLabel];
        [telephoneLabel release];
        UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, 260, 70)];
        addressLabel.tag = 33;
        addressLabel.backgroundColor = [UIColor whiteColor];
        addressLabel.textColor = [UIColor blackColor];
        addressLabel.textAlignment = NSTextAlignmentLeft;
        addressLabel.font = [UIFont systemFontOfSize:16];
        addressLabel.lineBreakMode = NSLineBreakByWordWrapping;
        addressLabel.numberOfLines = 2;
        [lCell addSubview:addressLabel];
        [addressLabel release];
    }
    NSDictionary *lDictionary = [_infoviewArray objectAtIndex:[indexPath section]];
    UILabel *nameLabel = (UILabel *)[lCell viewWithTag:11];
    nameLabel.text = [NSString stringWithFormat:@"收货人:%@",[lDictionary objectForKey:@"name"]];
    UILabel *telephoneLabel = (UILabel *)[lCell viewWithTag:22];
    telephoneLabel.text = [NSString stringWithFormat:@"电话:%@",[lDictionary objectForKey:@"telephone"]];
    UILabel *addressLabel = (UILabel *)[lCell viewWithTag:33];
    addressLabel.text = [NSString stringWithFormat:@"收货地址:%@",[lDictionary objectForKey:@"address"]];
    lCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return lCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *lDictionary = [_infoviewArray objectAtIndex:[indexPath section]];
    AddressInfoViewController *lAddressInfoViewController = [[AddressInfoViewController alloc]init];
    [self.navigationController pushViewController:lAddressInfoViewController animated:YES];
    [lAddressInfoViewController release];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"info" object:self userInfo:lDictionary];
}
@end
