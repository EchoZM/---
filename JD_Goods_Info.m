//
//  JD_Goods_Info.m
//  京东商城
//
//  Created by TY on 14-1-8.
//  Copyright (c) 2014年 张闽. All rights reserved.
//

#import "JD_Goods_Info.h"

@interface JD_Goods_Info ()

@end

@implementation JD_Goods_Info

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
    self.navigationItem.title = @"商品信息";
    //请求数据
    NSString *bodyString = [NSString stringWithFormat:@"goodsid=%@",[JD_DataManager shareGoodsDataManager].goodsID];
    [[JD_DataManager shareGoodsDataManager] downloadDataWithHTTPMethod:@"post" WithBodyString:bodyString WithURLString:@"getgoodsinfo.php" AndSuccess:^(NSData *data){
        NSDictionary *lDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        _goodsInfo = [[lDictionary objectForKey:@"msg"]retain];
        [self setGoodsInfo];
    }AndFailed:^{
        
    }];
}

-(void)dealloc
{
    [_goodsInfo release];
    [selectImageView release];
    [_webView release];
    [super dealloc];
}

-(void)backToGoods:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setGoodsInfo
{
    UIImageView *headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
    headerImageView.image = [[JD_DataManager shareGoodsDataManager] getgoodsImage:[_goodsInfo objectForKey:@"headerimage"]];
    [self.view addSubview:headerImageView];
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, 190, 50)];
    nameLabel.backgroundColor = [UIColor whiteColor];
    nameLabel.text = [_goodsInfo objectForKey:@"name"];
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    nameLabel.numberOfLines = 2;
    [self.view addSubview:nameLabel];
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 70, 190, 15)];
    priceLabel.backgroundColor = [UIColor whiteColor];
    priceLabel.text = [NSString stringWithFormat:@"价格：%@元",[_goodsInfo objectForKey:@"price"]];
    priceLabel.textAlignment = NSTextAlignmentLeft;
    priceLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:priceLabel];
    UILabel *sellcountLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 95, 190, 15)];
    sellcountLabel.backgroundColor = [UIColor whiteColor];
    sellcountLabel.text = [NSString stringWithFormat:@"已售：%@件",[_goodsInfo objectForKey:@"sellcount"]];
    sellcountLabel.textAlignment = NSTextAlignmentLeft;
    sellcountLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:sellcountLabel];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(5, 121, 310, 1)];
    lineView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:lineView];
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(81.75, 125, 1, 40)];
    lineView1.backgroundColor = [UIColor blackColor];
    [self.view addSubview:lineView1];
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(159.5, 125, 1, 40)];
    lineView2.backgroundColor = [UIColor blackColor];
    [self.view addSubview:lineView2];
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(237.25, 125, 1, 40)];
    lineView3.backgroundColor = [UIColor blackColor];
    [self.view addSubview:lineView3];
    UIButton *introductionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    introductionButton.frame = CGRectMake(5, 125, 76.75, 40);
    introductionButton.backgroundColor = [UIColor whiteColor];
    [introductionButton setTitle:@"商品介绍" forState:UIControlStateNormal];
    [introductionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [introductionButton addTarget:self action:@selector(introduction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:introductionButton];
    UIButton *specificationsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    specificationsButton.frame = CGRectMake(82.75, 125, 76.75, 40);
    specificationsButton.backgroundColor = [UIColor whiteColor];
    [specificationsButton setTitle:@"详细参数" forState:UIControlStateNormal];
    [specificationsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [specificationsButton addTarget:self action:@selector(specifications:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:specificationsButton];
    UIButton *packinglistButton = [UIButton buttonWithType:UIButtonTypeCustom];
    packinglistButton.frame = CGRectMake(160.5, 125, 76.75, 40);
    packinglistButton.backgroundColor = [UIColor whiteColor];
    [packinglistButton setTitle:@"包装清单" forState:UIControlStateNormal];
    [packinglistButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [packinglistButton addTarget:self action:@selector(packinglist:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:packinglistButton];
    UIButton *serviceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    serviceButton.frame = CGRectMake(238.25, 125, 76.75, 40);
    serviceButton.backgroundColor = [UIColor whiteColor];
    [serviceButton setTitle:@"售后服务" forState:UIControlStateNormal];
    [serviceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [serviceButton addTarget:self action:@selector(service:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:serviceButton];
    selectImageView = [[UIImageView alloc]initWithFrame:CGRectMake(introductionButton.center.x-6, 165, 12, 8)];
    selectImageView.image = [UIImage imageNamed:@"select"];
    selectImageView.tag = 101;
    [self.view addSubview:selectImageView];
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(5, 174, 310, self.view.frame.size.height-174)];
    [self.view addSubview:_webView];
    [self setWebView];
    //释放
    [headerImageView release];
    [nameLabel release];
    [priceLabel release];
    [sellcountLabel release];
    [lineView release];
    [lineView1 release];
    [lineView2 release];
    [lineView3 release];
}
#pragma mark - ButtonMethod
-(void)introduction:(UIButton *)sender
{
    selectImageView.tag = 101;
    [UIView beginAnimations:@"animation" context:nil];
    selectImageView.frame = CGRectMake(sender.center.x-6, 165, 12, 8);
    [UIView commitAnimations];
    [self setWebView];
}

-(void)specifications:(UIButton *)sender
{
    selectImageView.tag = 102;
    [UIView beginAnimations:@"animation" context:nil];
    selectImageView.frame = CGRectMake(sender.center.x-6, 165, 12, 8);
    [UIView commitAnimations];
    [self setWebView];
}

-(void)packinglist:(UIButton *)sender
{
    selectImageView.tag = 103;
    [UIView beginAnimations:@"animation" context:nil];
    selectImageView.frame = CGRectMake(sender.center.x-6, 165, 12, 8);
    [UIView commitAnimations];
    [self setWebView];
}

-(void)service:(UIButton *)sender
{
    selectImageView.tag = 104;
    [UIView beginAnimations:@"animation" context:nil];
    selectImageView.frame = CGRectMake(sender.center.x-6, 165, 12, 8);
    [UIView commitAnimations];
    [self setWebView];
}

-(void)setWebView
{
    if (selectImageView.tag == 101) {
        NSURLRequest *lRequest = [[JD_DataManager shareGoodsDataManager] requestWithURLString:@"/introduction.php"];
        [_webView loadRequest:lRequest];
        return;
    }
    if (selectImageView.tag == 102) {
        NSURLRequest *lRequest = [[JD_DataManager shareGoodsDataManager] requestWithURLString:@"/specifications.php"];
        [_webView loadRequest:lRequest];
        return;
    }
    if (selectImageView.tag == 103) {
        NSURLRequest *lRequest = [[JD_DataManager shareGoodsDataManager] requestWithURLString:@"/packinglist.php"];
        [_webView loadRequest:lRequest];
        return;
    }
    if (selectImageView.tag == 104) {
        NSURLRequest *lRequest = [[JD_DataManager shareGoodsDataManager] requestWithURLString:@"/service.php"];
        [_webView loadRequest:lRequest];
        return;
    }
}

@end
