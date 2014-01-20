//
//  JD_Review.m
//  京东商城
//
//  Created by TY on 14-1-17.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import "JD_Review.h"
#import "CustomView.h"

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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notification:) name:@"post" object:nil];
    _star = @"1";
    [self setView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [_detailText release];
    [_customView release];
    [super dealloc];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 40, 40);
    [backButton setImage:[UIImage imageNamed:@"title_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    [leftBarButton release];
    self.navigationItem.title = @"添加评论";
}

-(void)notification:(NSNotification *)sender
{
    NSString *starString = [sender.object stringValue];
    float star = [starString floatValue];
    for (UIView *lView in self.view.subviews) {
        [lView removeFromSuperview];
    }
    if (star < 1) {
        star = 1;
    }
    _star = [NSString stringWithFormat:@"%.2f",star];
    [self setView];
}

-(void)setView
{
    UILabel *reviewLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 50)];
    reviewLabel.backgroundColor = [UIColor whiteColor];
    reviewLabel.text = @"商品评价:";
    reviewLabel.textColor = [UIColor blackColor];
    reviewLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:reviewLabel];
    [reviewLabel release];
    _customView = [[CustomView alloc]initWithHeight:20 AndStar:0];
    _customView.frame = CGRectMake(120, 25, 110, 20);
    [_customView setStarValue:[_star doubleValue]];
    [self.view addSubview:_customView];
    _persentLabel = [[UILabel alloc]initWithFrame:CGRectMake(230, 10, 80, 50)];
    _persentLabel.backgroundColor = [UIColor whiteColor];
    _persentLabel.text = [[NSString stringWithFormat:@"%.2f",[_star doubleValue]*20] stringByAppendingString:@"%"];
    _persentLabel.textColor = [UIColor blackColor];
    _persentLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:_persentLabel];
    _detailText = [[UITextField alloc]initWithFrame:CGRectMake(10, 70, 300, 150)];
    _detailText.borderStyle = UITextBorderStyleBezel;
    [self.view addSubview:_detailText];
    UIButton *addReviewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addReviewButton.frame = CGRectMake(210, 230, 100, 50);
    addReviewButton.layer.cornerRadius = 8;
    addReviewButton.backgroundColor = [UIColor redColor];
    [addReviewButton setTitle:@"提交评论" forState:UIControlStateNormal];
    [addReviewButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addReviewButton addTarget:self action:@selector(addReview:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addReviewButton];
}

-(void)addReview:(UIButton *)sender
{
    [_detailText resignFirstResponder];
    //请求数据
    NSString *bodyString = [NSString stringWithFormat:@"goodsid=%@&customerid=%@&star=%@&detail=%@",[JD_DataManager shareGoodsDataManager].goodsID,[JD_DataManager shareGoodsDataManager].userID,_star,_detailText.text];
    [[JD_DataManager shareGoodsDataManager] downloadDataWithHTTPMethod:@"post" WithBodyString:bodyString WithURLString:@"addreview.php" AndSuccess:^(NSData *data){
        NSDictionary *lDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSString *lString = [NSString stringWithFormat:@"%@",[lDictionary objectForKey:@"error"]];
        if ([lString isEqualToString:@"0"]) {
            UIAlertView *lAlertview = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"提交成功" delegate:self cancelButtonTitle:@"返回" otherButtonTitles: nil];
            [lAlertview show];
            [lAlertview release];
            _star = @"1";
            _detailText.text = @"";
        }else{
            UIAlertView *lAlertview = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"提交失败" delegate:self cancelButtonTitle:@"返回" otherButtonTitles: nil];
            [lAlertview show];
            [lAlertview release];
        }
    }AndFailed:^(){
        
    }];
}

-(void)back:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)screenExit:(UIControl *)sender {
    [_detailText resignFirstResponder];
}
@end
