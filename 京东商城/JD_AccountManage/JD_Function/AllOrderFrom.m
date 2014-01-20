//
//  AllOrderFrom.m
//  京东商城
//
//  Created by TY on 14-1-13.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import "AllOrderFrom.h"

@interface AllOrderFrom ()

@end

@implementation AllOrderFrom

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"全部订单";
        OrderArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%f",self.view.frame.size.height);
    UIView *lHeard = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 36)]autorelease];
    [lHeard setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:lHeard];
    UILabel *lOrderid = [[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 140, 36)]autorelease];
    [lOrderid setText:@"订单号"];
    lOrderid.textAlignment = NSTextAlignmentCenter;
    lOrderid.backgroundColor = [UIColor clearColor];
    lOrderid.font = [UIFont boldSystemFontOfSize:15];
    lOrderid.textColor = [UIColor purpleColor];
    [lHeard addSubview:lOrderid];
    UILabel *lAmount = [[[UILabel alloc]initWithFrame:CGRectMake(110, 0, 80, 36)]autorelease];
    [lAmount setText:@"订单价额"];
    lAmount.textAlignment = NSTextAlignmentCenter;
    lAmount.backgroundColor = [UIColor clearColor];
    lAmount.font = [UIFont boldSystemFontOfSize:15];
    lAmount.textColor = [UIColor purpleColor];
    [lHeard addSubview:lAmount];
    UILabel *lState = [[[UILabel alloc]initWithFrame:CGRectMake(220, 0, 80, 36)]autorelease];
    [lState setText:@"订单状态"];
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
    self.navigationItem.leftBarButtonItem.tintColor= [UIColor redColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(NavigationFurbish:)];
    self.navigationItem.rightBarButtonItem.tintColor= [UIColor redColor];
    [self Furbish];
    if (OrderArray.count <= 8) {
        TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 35, 320, self.view.frame.size.height) style:UITableViewStylePlain];
    }else{
        TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 35, 320, 64*OrderArray.count) style:UITableViewStylePlain];
    }
    TableView.backgroundView = nil;
    TableView.backgroundColor = [UIColor clearColor];
    TableView.delegate = self;
    TableView.dataSource = self;
    [self.view addSubview:TableView];
    
}

-(void)NavigationFurbish:(UIBarButtonItem *)sender{
    [self Furbish];
}

-(void)Furbish{
    NSString *lBodyString = [NSString stringWithFormat:@"customerid=%@",[[[JD_DataManager shareGoodsDataManager] UserManage] objectAtIndex:0]];
    [[JD_DataManager shareGoodsDataManager] downloadDataWithHTTPMethod:@"post" WithBodyString:lBodyString WithURLString:@"getorder.php" AndSuccess:^(NSData *data) {
        [OrderArray removeAllObjects];
        [OrderArray addObjectsFromArray:[[[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil] objectForKey:@"msg"] objectForKey:@"info"]];
        [TableView reloadData];
    } AndFailed:^{
        JD_NetworkPrompt *lNetWorkPrompt = [[[JD_NetworkPrompt alloc]init]autorelease];
        [self.view addSubview:lNetWorkPrompt];
    }];
}

-(void)BackButton:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [OrderArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cell = @"cell";
    UITableViewCell *lcell = [tableView dequeueReusableCellWithIdentifier:cell];
    if (lcell == nil) {
        lcell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell]autorelease];
        UILabel *lOrderidLable = [[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 140, 64)]autorelease];
        lOrderidLable.tag = 10001;
        [lcell addSubview:lOrderidLable];
        UILabel *lAmountLable = [[[UILabel alloc]initWithFrame:CGRectMake(150, 0, 80, 64)]autorelease];
        lAmountLable.tag = 10002;
        [lcell addSubview:lAmountLable];
        UILabel *lStateLable = [[[UILabel alloc]initWithFrame:CGRectMake(240, 0, 80, 64)]autorelease];
        lStateLable.tag = 10003;
        [lcell addSubview:lStateLable];
    }
    UILabel *lOrderidLable = (UILabel *)[lcell viewWithTag:10001];
    lOrderidLable.text = [[OrderArray objectAtIndex:[indexPath row]] objectForKey:@"ordercode"];
    lOrderidLable.textAlignment = NSTextAlignmentCenter;
    lOrderidLable.backgroundColor = [UIColor clearColor];
    lOrderidLable.font = [UIFont boldSystemFontOfSize:15];
    lOrderidLable.textColor = [UIColor purpleColor];
    UILabel *lAmountLable = (UILabel *)[lcell viewWithTag:10002];
    lAmountLable.text = [[OrderArray objectAtIndex:[indexPath row]] objectForKey:@"amount"];
    lAmountLable.textAlignment = NSTextAlignmentCenter;
    lAmountLable.backgroundColor = [UIColor clearColor];
    lAmountLable.font = [UIFont boldSystemFontOfSize:15];
    lAmountLable.textColor = [UIColor purpleColor];
    UILabel *lStateLable = (UILabel *)[lcell viewWithTag:10003];
    lStateLable.text = [[OrderArray objectAtIndex:[indexPath row]] objectForKey:@"state"];
    lStateLable.textAlignment = NSTextAlignmentCenter;
    lStateLable.backgroundColor = [UIColor clearColor];
    lStateLable.font = [UIFont boldSystemFontOfSize:15];
    lStateLable.textColor = [UIColor purpleColor];
    lcell.accessoryType = UITableViewCellAccessoryNone;
    lcell.selectionStyle = UITableViewCellEditingStyleNone;
    return lcell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
