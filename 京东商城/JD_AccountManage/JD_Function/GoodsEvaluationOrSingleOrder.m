//
//  GoodsEvaluationOrSingleOrder.m
//  京东商城
//
//  Created by TY on 14-1-13.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import "GoodsEvaluationOrSingleOrder.h"
#import "JD_Review.h"

@interface GoodsEvaluationOrSingleOrder ()

@end

@implementation GoodsEvaluationOrSingleOrder

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"商品评价";
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
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 40, 40);
    [backButton setImage:[UIImage imageNamed:@"title_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(BackButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    [leftBarButton release];
    for (UIView *lView in self.view.subviews) {
        [lView removeFromSuperview];
    }
    NSString *bodyString = [NSString stringWithFormat:@"customerid=%@",[JD_DataManager shareGoodsDataManager].userID];
    _goodsArray = [[NSMutableArray alloc]init];
    [[JD_DataManager shareGoodsDataManager] downloadDataWithHTTPMethod:@"post" WithBodyString:bodyString WithURLString:@"getorder.php" AndSuccess:^(NSData *data){
        NSDictionary *lDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *lDic = [lDictionary objectForKey:@"msg"];
        NSArray *lArray = [NSArray arrayWithArray:[lDic objectForKey:@"info"]];
        for (NSDictionary *catsDic in lArray) {
            NSArray *goodsArray = [catsDic objectForKey:@"carts"];
            for (NSDictionary *goodsDic in goodsArray) {
                [_goodsArray addObject:goodsDic];
            }
        }
        UILabel *lLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        lLabel.backgroundColor = [UIColor grayColor];
        lLabel.text = @"点击相应商品添加评论";
        lLabel.textColor = [UIColor whiteColor];
        lLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:lLabel];
        [lLabel release];
        UITableView *lTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
        lTableView.dataSource = self;
        lTableView.delegate = self;
        lTableView.backgroundView = nil;
        [lTableView.tableHeaderView removeFromSuperview];
        lTableView.showsVerticalScrollIndicator = NO;//隐藏滚动条
        [self.view addSubview:lTableView];
    }AndFailed:^{
        
    }];
}

-(void)BackButton:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _goodsArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    UITableViewCell *lCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (lCell == nil) {
        lCell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID]autorelease];
        lCell.selectionStyle = UITableViewCellSelectionStyleNone;
        lCell.backgroundColor = [UIColor clearColor];
        UIImageView *logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 40, 40)];
        logoImageView.tag = 110;
        [lCell addSubview:logoImageView];
        [logoImageView release];
    }
    UIImageView *logoView = (UIImageView *)[lCell viewWithTag:110];
    logoView.image = [[JD_DataManager shareGoodsDataManager] getgoodsImage:[[_goodsArray objectAtIndex:[indexPath section]] objectForKey:@"headerimage"]];
    lCell.imageView.image = [UIImage imageNamed:@"white"];
    lCell.textLabel.text = [[_goodsArray objectAtIndex:[indexPath section]] objectForKey:@"name"];
    lCell.textLabel.font = [UIFont systemFontOfSize:16];
    lCell.detailTextLabel.text = [@"单价:" stringByAppendingString:[[[_goodsArray objectAtIndex:[indexPath section]] objectForKey:@"price"] stringByAppendingString:@"元"]];
    lCell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    return lCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [JD_DataManager shareGoodsDataManager].goodsID = [[_goodsArray objectAtIndex:[indexPath section]] objectForKey:@"goodsid"];
    JD_Review *lReview = [[JD_Review alloc]init];
    [self.navigationController pushViewController:lReview animated:YES];
    [lReview release];
}

@end
