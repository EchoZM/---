//
//  JD_Goods.m
//  京东商城
//
//  Created by TY on 14-1-8.
//  Copyright (c) 2014年 张闽. All rights reserved.
//

#import "JD_Goods.h"
#import "JD_Goods_Info.h"
#import "JD_Goods_Evaluate.h"
#import "JD_ShopCar.h"
#import "ASIFormDataRequest.h"

@interface JD_Goods ()

@end

@implementation JD_Goods

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
    _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+44)];
    _backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"self"]];
    [self.view addSubview:_backgroundView];
    //返回按钮
    UIImageView *backButton = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"back"]];
    backButton.frame = CGRectMake(10, 10, 40, 40);
    backButton.layer.cornerRadius = 20;
    backButton.userInteractionEnabled = YES;
    UITapGestureRecognizer *lTap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(popToView:)];
    [backButton addGestureRecognizer:lTap1];
    [self.view addSubview:backButton];
    //去往购物车按钮
    UIImageView *carButton = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"car"]];
    carButton.frame = CGRectMake(self.view.frame.size.width-50, 10, 40, 40);
    carButton.userInteractionEnabled = YES;
    UITapGestureRecognizer *lTap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(popToShopCar:)];
    [carButton addGestureRecognizer:lTap2];
    [self.view addSubview:carButton];
    //释放
    [backButton release];
    [carButton release];
    [lTap1 release];
    [lTap2 release];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //隐藏NavigationBar
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //请求数据
    NSString *bodyString = [NSString stringWithFormat:@"goodsid=%@",[JD_DataManager shareGoodsDataManager].goodsID];
    NSDictionary *lDictionary = [NSJSONSerialization JSONObjectWithData:[[JD_DataManager shareGoodsDataManager] downloadDataWithBody:bodyString URL:@"getgoodsinfo.php"] options:NSJSONReadingAllowFragments error:nil];
    _goodsInfo = [lDictionary objectForKey:@"msg"];
    goodsNumber = 1;
    float f = [[_goodsInfo objectForKey:@"price"] floatValue]*goodsNumber;
    NSString *fS = [NSString stringWithFormat:@"%.2f",f];
    NSLog(@"%@",fS);
    [self setGoodsInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [super dealloc];
}
#pragma mark - BackButton
-(void)popToView:(UITapGestureRecognizer *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)popToShopCar:(UITapGestureRecognizer *)sender
{
    NSLog(@"ToShopCar");
}
#pragma mark - setGoods
-(void)setGoodsInfo
{
    //商品图片
    UIImageView *headerImageView = [[UIImageView alloc]initWithImage:[[JD_DataManager shareGoodsDataManager] getgoodsImage:[_goodsInfo objectForKey:@"headerimage"]]];
    headerImageView.frame = CGRectMake(self.view.frame.size.width/2-50, 30, 100, 100);
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 160)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [_backgroundView addSubview:backgroundView];
    [backgroundView addSubview:headerImageView];
    //商品信息
    UIView *informationView = [[UIView alloc]initWithFrame:CGRectMake(5, 165, 310, 151)];
    informationView.backgroundColor = [UIColor whiteColor];
    informationView.layer.cornerRadius = 8;
    [_backgroundView addSubview:informationView];
    UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 284, 50)];
    infoLabel.backgroundColor = [UIColor whiteColor];
    infoLabel.layer.cornerRadius = 8;
    infoLabel.text = @"商品信息";
    infoLabel.textAlignment = NSTextAlignmentLeft;
    infoLabel.textColor = [UIColor blackColor];
    [informationView addSubview:infoLabel];
    UIImageView *intoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(285, 15, 20, 20)];
    intoImageView.backgroundColor = [UIColor whiteColor];
    intoImageView.image = [UIImage imageNamed:@"into"];
    [informationView addSubview:intoImageView];
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    infoButton.frame = CGRectMake(0, 0, 310, 50);
    infoButton.backgroundColor = [UIColor clearColor];
    infoButton.layer.cornerRadius = 8;
    [infoButton addTarget:self action:@selector(toGoodsInfo:) forControlEvents:UIControlEventTouchUpInside];
    [informationView addSubview:infoButton];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(5, 50, 300, 1)];
    lineView.backgroundColor = [UIColor grayColor];
    [informationView addSubview:lineView];
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 51, 300, 50)];
    nameLabel.backgroundColor = [UIColor whiteColor];
    nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    nameLabel.numberOfLines = 2;
    nameLabel.text = [@"名称：" stringByAppendingString:[_goodsInfo objectForKey:@"name"]];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    [informationView addSubview:nameLabel];
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 101, 300, 50)];
    priceLabel.backgroundColor = [UIColor whiteColor];
    priceLabel.text = [[@"价格：" stringByAppendingString:[_goodsInfo objectForKey:@"price"]] stringByAppendingString:@"元"];
    priceLabel.textColor = [UIColor blackColor];
    priceLabel.textAlignment = NSTextAlignmentLeft;
    [informationView addSubview:priceLabel];
    //商品评价
    UIView *evaluateView = [[UIView alloc]initWithFrame:CGRectMake(5, 320, 310, 50)];
    evaluateView.backgroundColor = [UIColor whiteColor];
    evaluateView.layer.cornerRadius = 8;
    [_backgroundView addSubview:evaluateView];
    UILabel *evaluateLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 129, 50)];
    evaluateLabel.backgroundColor = [UIColor whiteColor];
    evaluateLabel.layer.cornerRadius = 8;
    evaluateLabel.text = @"商品评价";
    evaluateLabel.textAlignment = NSTextAlignmentLeft;
    evaluateLabel.textColor = [UIColor blackColor];
    [evaluateView addSubview:evaluateLabel];
    UIImageView *starImageView = [[UIImageView alloc]initWithFrame:CGRectMake(130, 50, 100, 50)];
    [evaluateView addSubview:starImageView];
    UILabel *reviewcountLabel = [[UILabel alloc]initWithFrame:CGRectMake(230, 0, 50, 50)];
    reviewcountLabel.backgroundColor = [UIColor whiteColor];
    reviewcountLabel.layer.cornerRadius = 8;
    reviewcountLabel.text = [NSString stringWithFormat:@"(%@)",[_goodsInfo objectForKey:@"reviewcount"]];
    reviewcountLabel.textAlignment = NSTextAlignmentRight;
    reviewcountLabel.textColor = [UIColor blackColor];
    [evaluateView addSubview:reviewcountLabel];
    UIImageView *intooImageView = [[UIImageView alloc]initWithFrame:CGRectMake(285, 15, 20, 20)];
    intooImageView.backgroundColor = [UIColor whiteColor];
    intooImageView.image = [UIImage imageNamed:@"into"];
    [evaluateView addSubview:intooImageView];
    UIButton *evaluateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    evaluateButton.frame = CGRectMake(0, 0, 310, 50);
    evaluateButton.layer.cornerRadius = 8;
    evaluateButton.backgroundColor = [UIColor clearColor];
    [evaluateButton addTarget:self action:@selector(toGoodsEvaluate:) forControlEvents:UIControlEventTouchUpInside];
    [evaluateView addSubview:evaluateButton];
    //商品型号
    UIView *modelView = [[UIView alloc]initWithFrame:CGRectMake(5, 375, 310, 101)];
    modelView.backgroundColor = [UIColor whiteColor];
    modelView.layer.cornerRadius = 8;
    [_backgroundView addSubview:modelView];
    UILabel *modelLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 300, 50)];
    modelLabel.backgroundColor = [UIColor whiteColor];
    modelLabel.layer.cornerRadius = 8;
    modelLabel.text = [@"型号：" stringByAppendingString:[_goodsInfo objectForKey:@"size"]];
    modelLabel.textAlignment = NSTextAlignmentLeft;
    modelLabel.textColor = [UIColor blackColor];
    [modelView addSubview:modelLabel];
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(5, 50, 300, 1)];
    lineView2.backgroundColor = [UIColor grayColor];
    [modelView addSubview:lineView2];
    UILabel *colorLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 51, 300, 50)];
    colorLabel.backgroundColor = [UIColor whiteColor];
    colorLabel.layer.cornerRadius = 8;
    colorLabel.text = [@"颜色：" stringByAppendingString:[_goodsInfo objectForKey:@"color"]];
    colorLabel.textAlignment = NSTextAlignmentLeft;
    colorLabel.textColor = [UIColor blackColor];
    [modelView addSubview:colorLabel];
    //商品描述
    //加入购物车及欲购买商品的信息
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.backgroundColor = [UIColor redColor];
    addButton.layer.cornerRadius = 8;
    addButton.frame = CGRectMake(10, self.view.frame.size.height-16, 100, 50);
    [addButton setTitle:@"加入购物车" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addToShopCar:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    UIView *numberView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-200, self.view.frame.size.height-16, 100, 50)];
    numberView.backgroundColor = [UIColor whiteColor];
    numberView.layer.cornerRadius = 8;
    [self.view addSubview:numberView];
    UIButton *subtractButton = [UIButton buttonWithType:UIButtonTypeCustom];
    subtractButton.frame = CGRectMake(5, 15, 20, 20);
    subtractButton.layer.cornerRadius = 10;
    [subtractButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [subtractButton addTarget:self action:@selector(subtractGoods:) forControlEvents:UIControlEventTouchUpInside];
    [numberView addSubview:subtractButton];
    UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    plusButton.frame = CGRectMake(75, 15, 20, 20);
    plusButton.layer.cornerRadius = 10;
    [plusButton setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [plusButton addTarget:self action:@selector(plusGoods:) forControlEvents:UIControlEventTouchUpInside];
    [numberView addSubview:plusButton];
    numberLabel = [[UITextField alloc]initWithFrame:CGRectMake(25, 15, 50, 20)];
    [numberLabel setBorderStyle:UITextBorderStyleLine];
    numberLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.text = [NSString stringWithFormat:@"%i",goodsNumber];
    [numberView addSubview:numberLabel];
    priceView = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-90, self.view.frame.size.height-16, 80, 50)];
    priceView.backgroundColor = [UIColor whiteColor];
    priceView.text = [[@"总价" stringByAppendingString:[_goodsInfo objectForKey:@"price"]] stringByAppendingString:@"元"];
    priceView.textColor = [UIColor blackColor];
    priceView.font = [UIFont systemFontOfSize:18];
    priceView.textAlignment = NSTextAlignmentCenter;
    priceView.layer.cornerRadius = 8;
    priceView.lineBreakMode = NSLineBreakByWordWrapping;//自动换行
    priceView.numberOfLines = 2;//行数
    [self.view addSubview:priceView];
    //释放
    [headerImageView release];
    [backgroundView release];
    [informationView release];
    [infoLabel release];
    [lineView release];
    [modelView release];
    [modelLabel release];
    [lineView2 release];
    [colorLabel release];
    [numberLabel release];
    [priceView release];
    [numberView release];
}

-(void)toGoodsInfo:(UIButton *)sender
{
    JD_Goods_Info *lInfo = [[JD_Goods_Info alloc]init];
    [self.navigationController pushViewController:lInfo animated:YES];
    [lInfo release];
}

-(void)toGoodsEvaluate:(UIButton *)sender
{
    JD_Goods_Evaluate *lEvaluate = [[JD_Goods_Evaluate alloc]init];
    [self.navigationController pushViewController:lEvaluate animated:YES];
    [lEvaluate release];
}

-(void)addToShopCar:(UIButton *)sender
{
    [JD_DataManager shareGoodsDataManager].userID = @"20";
    NSString *bodyString = [NSString stringWithFormat:@"goodsid=%@&customerid=%@&goodscount=%i",[JD_DataManager shareGoodsDataManager].goodsID,[JD_DataManager shareGoodsDataManager].userID,goodsNumber];
    NSDictionary *goodsInfo = [NSJSONSerialization JSONObjectWithData:[[JD_DataManager shareGoodsDataManager] downloadDataWithBody:bodyString URL:@"addcart.php"] options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"%@",goodsInfo);
    //    if ([[goodsInfo objectForKey:@"error"] isEqualToString:@"0"]) {
    //        NSLog(@"success");
    //    }else{
    //        UIAlertView *lAlertView = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"添加失败请重新添加" delegate:self cancelButtonTitle:@"返回" otherButtonTitles: nil];
    //        [lAlertView show];
    //        [lAlertView release];
    //    }
}

-(void)plusGoods:(UIButton *)sender
{
    goodsNumber++;
    numberLabel.text = [NSString stringWithFormat:@"%i",goodsNumber];
}

-(void)subtractGoods:(UIButton *)sender
{
    if (goodsNumber == 1) {
        goodsNumber = 1;
        numberLabel.text = [NSString stringWithFormat:@"%i",goodsNumber];
    }else{
        goodsNumber--;
        numberLabel.text = [NSString stringWithFormat:@"%i",goodsNumber];
    }
}

@end
