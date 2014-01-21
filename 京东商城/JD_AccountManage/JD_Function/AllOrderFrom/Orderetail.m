//
//  Orderetail.m
//  京东商城
//
//  Created by TY on 14-1-20.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import "Orderetail.h"

@interface Orderetail ()

@end

@implementation Orderetail

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
    UIView *lHeard = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 36)]autorelease];
    [lHeard setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:lHeard];
    UILabel *lOrderid = [[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 36)]autorelease];
    [lOrderid setText:@"商品预览"];
    lOrderid.textAlignment = NSTextAlignmentCenter;
    lOrderid.backgroundColor = [UIColor clearColor];
    lOrderid.font = [UIFont boldSystemFontOfSize:15];
    lOrderid.textColor = [UIColor purpleColor];
    [lHeard addSubview:lOrderid];
    UILabel *lGoodsName = [[[UILabel alloc]initWithFrame:CGRectMake(80, 0, 80, 36)]autorelease];
    [lGoodsName setText:@"类型"];
    lGoodsName.textAlignment = NSTextAlignmentCenter;
    lGoodsName.backgroundColor = [UIColor clearColor];
    lGoodsName.font = [UIFont boldSystemFontOfSize:15];
    lGoodsName.textColor = [UIColor purpleColor];
    [lHeard addSubview:lGoodsName];
    UILabel *lAmount = [[[UILabel alloc]initWithFrame:CGRectMake(160, 0, 80, 36)]autorelease];
    [lAmount setText:@"单价"];
    lAmount.textAlignment = NSTextAlignmentCenter;
    lAmount.backgroundColor = [UIColor clearColor];
    lAmount.font = [UIFont boldSystemFontOfSize:15];
    lAmount.textColor = [UIColor purpleColor];
    [lHeard addSubview:lAmount];
    UILabel *lState = [[[UILabel alloc]initWithFrame:CGRectMake(240, 0, 80, 36)]autorelease];
    [lState setText:@"数量"];
    lState.textAlignment = NSTextAlignmentCenter;
    lState.backgroundColor = [UIColor clearColor];
    lState.font = [UIFont boldSystemFontOfSize:15];
    lState.textColor = [UIColor purpleColor];
    [lHeard addSubview:lState];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(BackButton:)];
    if ([[JD_DataManager shareGoodsDataManager] OrderArray].count <= 8) {
        TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 36, 320, 64*[[[[[JD_DataManager shareGoodsDataManager] OrderArray] objectAtIndex:_Section] objectForKey:@"carts"] count]) style:UITableViewStylePlain];
    }else{
        TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 36, 320, 548) style:UITableViewStylePlain];
    }
    if ([[JD_DataManager shareGoodsDataManager] OrderArray].count <= 0) {
        TableView.scrollEnabled = NO;
    }else{
        TableView.scrollEnabled = YES;
    }
    TableView.backgroundView = nil;
    TableView.backgroundColor = [UIColor clearColor];
    TableView.delegate = self;
    TableView.dataSource = self;
    TableView.contentSize = CGSizeMake(320, 64*[[[[[JD_DataManager shareGoodsDataManager] OrderArray] objectAtIndex:_Section] objectForKey:@"carts"] count]);
    [self.view addSubview:TableView];
}

-(void)Furbish{
    
}

-(void)BackButton:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[[[JD_DataManager shareGoodsDataManager] OrderArray] objectAtIndex:_Section] objectForKey:@"carts"] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cell = @"cell";
    UITableViewCell *lcell = [tableView dequeueReusableCellWithIdentifier:cell];
    if (lcell == nil) {
        lcell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell]autorelease];
        UIImageView *ImageView = [[[UIImageView alloc]initWithFrame:CGRectMake(10, 2, 60, 60)]autorelease];
        ImageView.tag = 10001;
        [lcell addSubview:ImageView];
        UILabel *lOrderidLable = [[[UILabel alloc]initWithFrame:CGRectMake(80, 0, 80, 64)]autorelease];
        lOrderidLable.tag = 10002;
        [lcell addSubview:lOrderidLable];
        UILabel *lAmountLable = [[[UILabel alloc]initWithFrame:CGRectMake(160, 0, 80, 64)]autorelease];
        lAmountLable.tag = 10003;
        [lcell addSubview:lAmountLable];
        UILabel *lStateLable = [[[UILabel alloc]initWithFrame:CGRectMake(240, 0, 80, 64)]autorelease];
        lStateLable.tag = 10004;
        [lcell addSubview:lStateLable];
    }
    lcell.backgroundColor = [UIColor clearColor];
    UIImageView *ImageView = (UIImageView *)[lcell viewWithTag:10001];
    ImageView.image = [[JD_DataManager shareGoodsDataManager] getgoodsImage:[[[[[[JD_DataManager shareGoodsDataManager] OrderArray] objectAtIndex:_Section] objectForKey:@"carts"] objectAtIndex:[indexPath row]] objectForKey:@"headerimage"]];
    UILabel *lOrderidLable = (UILabel *)[lcell viewWithTag:10002];
    [lOrderidLable setBackgroundColor:[UIColor redColor]];
    lOrderidLable.text = [NSString stringWithFormat:@"%@",[[[[[[JD_DataManager shareGoodsDataManager] OrderArray] objectAtIndex:_Section] objectForKey:@"carts"] objectAtIndex:[indexPath row]] objectForKey:@"size"]];
    lOrderidLable.textAlignment = NSTextAlignmentCenter;
    lOrderidLable.backgroundColor = [UIColor clearColor];
    lOrderidLable.font = [UIFont boldSystemFontOfSize:15];
    lOrderidLable.textColor = [UIColor purpleColor];
    UILabel *lAmountLable = (UILabel *)[lcell viewWithTag:10003];
    lAmountLable.text = [NSString stringWithFormat:@"%@",[[[[[[JD_DataManager shareGoodsDataManager] OrderArray] objectAtIndex:_Section] objectForKey:@"carts"] objectAtIndex:[indexPath row]] objectForKey:@"price"]];
    lAmountLable.textAlignment = NSTextAlignmentCenter;
    lAmountLable.backgroundColor = [UIColor clearColor];
    lAmountLable.font = [UIFont boldSystemFontOfSize:15];
    lAmountLable.textColor = [UIColor purpleColor];
    UILabel *lStateLable = (UILabel *)[lcell viewWithTag:10004];
    lStateLable.text = [NSString stringWithFormat:@"%@",[[[[[[JD_DataManager shareGoodsDataManager] OrderArray] objectAtIndex:_Section] objectForKey:@"carts"] objectAtIndex:[indexPath row]] objectForKey:@"goodscount"]];
    lStateLable.textAlignment = NSTextAlignmentCenter;
    lStateLable.backgroundColor = [UIColor clearColor];
    lStateLable.font = [UIFont boldSystemFontOfSize:15];
    lStateLable.textColor = [UIColor purpleColor];
    lcell.accessoryType = UITableViewCellAccessoryNone;
    lcell.selectionStyle = UITableViewCellEditingStyleNone;
    return lcell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
