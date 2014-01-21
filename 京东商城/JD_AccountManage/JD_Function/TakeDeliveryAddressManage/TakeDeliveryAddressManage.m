//
//  TakeDeliveryAddressManage.m
//  京东商城
//
//  Created by TY on 14-1-13.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import "TakeDeliveryAddressManage.h"
#import "AddComment.h"
#import "InfoView.h"
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:@"custom" object:nil];
    _infoviewArray = [[NSMutableArray alloc]init];
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
                int number = [count intValue];
                for (int i=0; i<number; i++) {
                    InfoView *lInfoView = [[InfoView alloc]init];
                    [_infoviewArray addObject:lInfoView];
                    [lInfoView release];
                }
                for (int i=0; i<_infoviewArray.count; i++) {
                    InfoView *lInfoView = [_infoviewArray objectAtIndex:i];
                    lInfoView.frame = CGRectMake(10, 20+220*i, 300, 200);
                    [self.view addSubview:lInfoView];
                }
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

-(void)notification:(NSNotification *)sender
{
    AddressInfoViewController *lAddressInfoViewController = [[AddressInfoViewController alloc]init];
    [self.navigationController pushViewController:lAddressInfoViewController animated:YES];
    [lAddressInfoViewController release];
}

@end
