//
//  JD_GoodsSingle.m
//  京东商城
//
//  Created by TY on 13-7-31.
//  Copyright (c) 2013年 张太松. All rights reserved.
//

#import "JD_GoodsSingle.h"

@interface JD_GoodsSingle ()

@end

@implementation JD_GoodsSingle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _textString=[[NSString alloc]init];
        _saveArray=[[NSArray alloc]init];
        array=[[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationItem.title=_textString;
//    for (NSArray *lArray in _saveArray) {
//        for (NSString *lString in lArray) {
//            [array addObject:lString];
//        }
//    }
    if ([_textString isEqualToString:@"订单状态速查"]) {
        UITableView *lTableView=[[UITableView alloc]initWithFrame:self.view.frame];
        [self.view addSubview:lTableView];
    }
    if ([_textString isEqualToString:@"待付款订单"]) {
        UIView *lView=[[UIView alloc]initWithFrame:self.view.frame];
        [lView setBackgroundColor:[UIColor redColor]];
        [self.view addSubview:lView];
    }
    if ([_textString isEqualToString:@"全部订单"]) {
        UIView *lView=[[UIView alloc]initWithFrame:self.view.frame];
        [lView setBackgroundColor:[UIColor greenColor]];
        [self.view addSubview:lView];
    }
    if ([_textString isEqualToString:@"消息中心"]) {
        UIView *lView=[[UIView alloc]initWithFrame:self.view.frame];
        [lView setBackgroundColor:[UIColor blackColor]];
        [self.view addSubview:lView];
    }
    if ([_textString isEqualToString:@"我的关注"]) {
        UIView *lView=[[UIView alloc]initWithFrame:self.view.frame];
        [lView setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:lView];
    }
    if ([_textString isEqualToString:@"浏览纪录"]) {
        UIView *lView=[[UIView alloc]initWithFrame:self.view.frame];
        [lView setBackgroundColor:[UIColor yellowColor]];
        [self.view addSubview:lView];
    }
    if ([_textString isEqualToString:@"商品评价/晒单"]) {
        UIView *lView=[[UIView alloc]initWithFrame:self.view.frame];
        [lView setBackgroundColor:[UIColor grayColor]];
        [self.view addSubview:lView];
    }
    if ([_textString isEqualToString:@"返修/退货"]) {
        UIView *lView=[[UIView alloc]initWithFrame:self.view.frame];
        [lView setBackgroundColor:[UIColor blueColor]];
        [self.view addSubview:lView];
    }
    if ([_textString isEqualToString:@"预约电话服务"]) {
        UIView *lView=[[UIView alloc]initWithFrame:self.view.frame];
        [lView setBackgroundColor:[UIColor orangeColor]];
        [self.view addSubview:lView];
    }
    if ([_textString isEqualToString:@"收货地址管理"]) {
        UIView *lView=[[UIView alloc]initWithFrame:self.view.frame];
        [lView setBackgroundColor:[UIColor darkGrayColor]];
        [self.view addSubview:lView];
    }
    if ([_textString isEqualToString:@"账户安全"]) {
        UIView *lView=[[UIView alloc]initWithFrame:self.view.frame];
        [lView setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:lView];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
