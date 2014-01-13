//
//  JD_Goods_Evaluate.m
//  京东商城
//
//  Created by TY on 14-1-8.
//  Copyright (c) 2014年 张闽. All rights reserved.
//

#import "JD_Goods_Evaluate.h"

@interface JD_Goods_Evaluate ()

@end

@implementation JD_Goods_Evaluate

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 40, 40);
    [backButton setImage:[UIImage imageNamed:@"title_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backToGoods:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    [leftBarButton release];
    self.navigationItem.title = @"商品评价";
    //请求数据
    NSString *bodyString = [NSString stringWithFormat:@"goodsid=%@",[JD_DataManager shareGoodsDataManager].goodsID];
    NSDictionary *lDictionary = [NSJSONSerialization JSONObjectWithData:[[JD_DataManager shareGoodsDataManager] downloadDataWithBody:bodyString URL:@"getgoodsinfo.php"] options:NSJSONReadingAllowFragments error:nil];
    _goodsInfo = [[lDictionary objectForKey:@"msg"]retain];
    [self setGoodsInfo];
}

-(void)dealloc
{
    [_goodsInfo release];
    [super dealloc];
}

-(void)backToGoods:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setGoodsInfo
{
    
}

@end
