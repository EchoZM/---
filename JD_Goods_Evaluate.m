//
//  JD_Goods_Evaluate.m
//  京东商城
//
//  Created by TY on 14-1-8.
//  Copyright (c) 2014年 张闽. All rights reserved.
//

#import "JD_Goods_Evaluate.h"
#import "CustomView.h"

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
    [[JD_DataManager shareGoodsDataManager] downloadDataWithHTTPMethod:@"post" WithBodyString:bodyString WithURLString:@"getgoodsinfo.php" AndSuccess:^(NSData *data){
        NSDictionary *lDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        _goodsInfo = [[lDictionary objectForKey:@"msg"]retain];
        [self setTitleView];
    }AndFailed:^{
        
    }];
}

-(void)dealloc
{
    [_goodsInfo release];
    [_reviewInfo release];
    [_customView release];
    [_tableView release];
    [super dealloc];
}

-(void)backToGoods:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setTitleView
{
    UILabel *evaluateLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 100, 30)];
    evaluateLabel.backgroundColor = [UIColor whiteColor];
    evaluateLabel.text = @"商品评价";
    evaluateLabel.font = [UIFont systemFontOfSize:24];
    evaluateLabel.textAlignment = NSTextAlignmentCenter;
    evaluateLabel.textColor = [UIColor blackColor];
    [self.view addSubview:evaluateLabel];
    UILabel *persentLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 60, 100, 20)];
    persentLabel.backgroundColor = [UIColor whiteColor];
    NSString *lString1 = [_goodsInfo objectForKey:@"star"];
    double value1 = [lString1 doubleValue]*20;
    persentLabel.text = [[NSString stringWithFormat:@"%.2f",value1] stringByAppendingString:@"%"];
    persentLabel.font = [UIFont systemFontOfSize:20];
    persentLabel.textAlignment = NSTextAlignmentCenter;
    persentLabel.textColor = [UIColor blackColor];
    [self.view addSubview:persentLabel];
    _customView = [[CustomView alloc]initWithHeight:30 AndStar:0];
    _customView.frame = CGRectMake(145, 35, 100, 30);
    NSString *lString = [_goodsInfo objectForKey:@"star"];
    double value = [lString doubleValue];
    [_customView setStarValue:value];
    [self.view addSubview:_customView];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 1)];
    lineView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:lineView];
    //释放
    [evaluateLabel release];
    [persentLabel release];
    [lineView release];
    //请求数据
    NSString *bodyString = [NSString stringWithFormat:@"goodsid=%@&owncount=0",[JD_DataManager shareGoodsDataManager].goodsID];
    [[JD_DataManager shareGoodsDataManager] downloadDataWithHTTPMethod:@"post" WithBodyString:bodyString WithURLString:@"getreview.php" AndSuccess:^(NSData *data){
        NSDictionary *lDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        _reviewInfo = [[lDictionary objectForKey:@"msg"]retain];
        [self setGoodsInfo];
    }AndFailed:^{
        
    }];
}

-(void)setGoodsInfo
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 106, self.view.frame.size.width, self.view.frame.size.height-106) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[_reviewInfo objectForKey:@"count"] intValue] <= 15) {
        return [[_reviewInfo objectForKey:@"count"] intValue];
    }else{
        return 15;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idString = @"cell";
    UITableViewCell *lCell = [tableView dequeueReusableCellWithIdentifier:idString];
    if (lCell == nil) {
        lCell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idString]autorelease];
        [lCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        UIImageView *lImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 75, 15)];
        [lCell addSubview:lImageView];
        [lImageView release];
        CustomView *lCustomView = [[CustomView alloc]initWithHeight:15 AndStar:0];
        lCustomView.frame = CGRectMake(0, 0, 85, 15);
        lCustomView.tag = 11;
        [lImageView addSubview:lCustomView];
        [lCustomView release];
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 0, 75, 15)];
        nameLabel.tag = 12;
        nameLabel.backgroundColor = [UIColor whiteColor];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.textAlignment = NSTextAlignmentRight;
        nameLabel.font = [UIFont systemFontOfSize:14];
        [lCell addSubview:nameLabel];
        [nameLabel release];
        UILabel *timaLabel = [[UILabel alloc]initWithFrame:CGRectMake(170, 0, 150, 15)];
        timaLabel.tag = 13;
        timaLabel.backgroundColor = [UIColor whiteColor];
        timaLabel.textColor = [UIColor blackColor];
        timaLabel.textAlignment = NSTextAlignmentLeft;
        timaLabel.font = [UIFont systemFontOfSize:14];
        [lCell addSubview:timaLabel];
        [timaLabel release];
        UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 320, 30)];
        detailLabel.tag = 14;
        detailLabel.backgroundColor = [UIColor whiteColor];
        detailLabel.textColor = [UIColor blackColor];
        detailLabel.textAlignment = NSTextAlignmentLeft;
        detailLabel.font = [UIFont systemFontOfSize:16];
        detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
        detailLabel.numberOfLines = 2;
        [lCell addSubview:detailLabel];
        [detailLabel release];
    }
    NSArray *lArray = [_reviewInfo objectForKey:@"infos"];
    NSDictionary *lDictionary = [lArray objectAtIndex:[indexPath row]];
    NSString *lString=[lDictionary objectForKey:@"star"];
    double value=[lString doubleValue];
    CustomView *lCustomView = (CustomView *)[lCell viewWithTag:11];
    [lCustomView setStarValue:value];
    UILabel *nameLabel = (UILabel *)[lCell viewWithTag:12];
    nameLabel.text = [lDictionary objectForKey:@"name"];
    UILabel *timeLabel = (UILabel *)[lCell viewWithTag:13];
    timeLabel.text = [lDictionary objectForKey:@"date"];
    UILabel *detailLabel = (UILabel *)[lCell viewWithTag:14];
    detailLabel.text = [lDictionary objectForKey:@"detail"];
    return lCell;
}

@end
