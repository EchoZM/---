//
//  JD_Review.m
//  京东商城
//
//  Created by TY on 14-1-17.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import "JD_Review.h"

@interface JD_Review ()

@end

@implementation JD_Review

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
    UIButton *addReviewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addReviewButton addTarget:self action:@selector(addReview:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addReviewButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 40, 40);
    [backButton setImage:[UIImage imageNamed:@"title_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backToGoods:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    [leftBarButton release];
    self.navigationItem.title = @"添加评论";
}

-(void)addReview:(UIButton *)sender
{
    //请求数据
    NSString *bodyString = [NSString stringWithFormat:@"goodsid=%@&customerid=%@&star=%@&detail=%@",[JD_DataManager shareGoodsDataManager].goodsID,[JD_DataManager shareGoodsDataManager].userID,_star,_detail];
    [[JD_DataManager shareGoodsDataManager] downloadDataWithHTTPMethod:@"post" WithBodyString:bodyString WithURLString:@"addreview.php" AndSuccess:^(NSData *data){
        NSDictionary *lDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSString *lString = [lDictionary objectForKey:@"error"];
        if ([lString isEqualToString:@"0"]) {
            UIAlertView *lAlertview = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"添加成功" delegate:self cancelButtonTitle:@"返回" otherButtonTitles: nil];
            [lAlertview show];
            [lAlertview release];
        }else{
            UIAlertView *lAlertview = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"添加失败" delegate:self cancelButtonTitle:@"返回" otherButtonTitles: nil];
            [lAlertview show];
            [lAlertview release];
        }
    }AndFailed:^(){
        
    }];
}

@end
