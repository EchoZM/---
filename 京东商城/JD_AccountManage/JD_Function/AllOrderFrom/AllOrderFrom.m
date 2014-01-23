//
//  AllOrderFrom.m
//  京东商城
//
//  Created by TY on 14-1-20.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import "AllOrderFrom.h"
#import "Orderetail.h"
@interface AllOrderFrom ()

@end

@implementation AllOrderFrom

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"全部订单";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    TableView = [[UITableView alloc]init];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    for (UIView *View in self.view.subviews) {
        [View removeFromSuperview];
    }
    UIView *lHeard = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 36)]autorelease];
    [lHeard setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:lHeard];
    UILabel *lOrderid = [[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 140, 36)]autorelease];
    [lOrderid setText:@"订单号"];
    lOrderid.textAlignment = NSTextAlignmentCenter;
    lOrderid.backgroundColor = [UIColor clearColor];
    lOrderid.font = [UIFont boldSystemFontOfSize:15];
    lOrderid.textColor = [UIColor purpleColor];
    [lHeard addSubview:lOrderid];
    UILabel *lAmount = [[[UILabel alloc]initWithFrame:CGRectMake(150, 0, 80, 36)]autorelease];
    [lAmount setText:@"订单价额"];
    lAmount.textAlignment = NSTextAlignmentCenter;
    lAmount.backgroundColor = [UIColor clearColor];
    lAmount.font = [UIFont boldSystemFontOfSize:15];
    lAmount.textColor = [UIColor purpleColor];
    [lHeard addSubview:lAmount];
    UILabel *lState = [[[UILabel alloc]initWithFrame:CGRectMake(240, 0, 80, 36)]autorelease];
    [lState setText:@"订单状态"];
    lState.textAlignment = NSTextAlignmentCenter;
    lState.backgroundColor = [UIColor clearColor];
    lState.font = [UIFont boldSystemFontOfSize:15];
    lState.textColor = [UIColor purpleColor];
    [lHeard addSubview:lState];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 40, 40);
    [backButton setImage:[UIImage imageNamed:@"title_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(BackButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    [leftBarButton release];
    self.navigationItem.rightBarButtonItem=nil;
//    self.navigationItem.rightBarButtonItem=[self editButtonItem];
//    self.navigationItem.rightBarButtonItem.title=@"编辑";
//    self.navigationItem.rightBarButtonItem.tintColor= [UIColor redColor];
    NSString *lBodyString = [NSString stringWithFormat:@"customerid=%@",[JD_DataManager shareGoodsDataManager].userID];
    [[JD_DataManager shareGoodsDataManager] downloadDataWithHTTPMethod:@"post" WithBodyString:lBodyString WithURLString:@"getorder.php" AndSuccess:^(NSData *data) {
        [[JD_DataManager shareGoodsDataManager].OrderArray removeAllObjects];
        [[JD_DataManager shareGoodsDataManager].OrderArray addObjectsFromArray:[[[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil] objectForKey:@"msg"] objectForKey:@"info"]];
        if ([JD_DataManager shareGoodsDataManager].OrderArray.count <= 7) {
            TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 35, 320, 64*[JD_DataManager shareGoodsDataManager].OrderArray.count) style:UITableViewStylePlain];
            TableView.scrollEnabled = NO;
        }else{
            TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 35, 320, self.view.frame.size.height-35) style:UITableViewStylePlain];
            TableView.scrollEnabled = YES;
        }
        TableView.backgroundView = nil;
        TableView.backgroundColor = [UIColor clearColor];
        TableView.delegate = self;
        TableView.dataSource = self;
        [self.view addSubview:TableView];
    } AndFailed:^{
        JD_NetworkPrompt *lNetWorkPrompt = [[[JD_NetworkPrompt alloc]init]autorelease];
        [self.view addSubview:lNetWorkPrompt];
    }];
}

-(void)BackButton:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

//- (void)setEditing:(BOOL)editing animated:(BOOL)animated
//{
//    [super setEditing:editing animated:animated];
//    if(editing==YES){
//        self.navigationItem.rightBarButtonItem.title=@"完成";
//    }else {
//        self.navigationItem.rightBarButtonItem.title=@"编辑";
//    }
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [JD_DataManager shareGoodsDataManager].OrderArray.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cell = @"cell";
    UITableViewCell *lcell = [tableView dequeueReusableCellWithIdentifier:cell];
    if (lcell == nil) {
        lcell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell]autorelease];
        lcell.accessoryType = UITableViewCellAccessoryNone;
        lcell.selectionStyle = UITableViewCellSelectionStyleBlue;
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
    lOrderidLable.text = [[[JD_DataManager shareGoodsDataManager].OrderArray objectAtIndex:[indexPath row]] objectForKey:@"ordercode"];
    lOrderidLable.textAlignment = NSTextAlignmentCenter;
    lOrderidLable.backgroundColor = [UIColor clearColor];
    lOrderidLable.font = [UIFont boldSystemFontOfSize:15];
    lOrderidLable.textColor = [UIColor purpleColor];
    UILabel *lAmountLable = (UILabel *)[lcell viewWithTag:10002];
    lAmountLable.text = [[[JD_DataManager shareGoodsDataManager].OrderArray objectAtIndex:[indexPath row]] objectForKey:@"amount"];
    lAmountLable.textAlignment = NSTextAlignmentCenter;
    lAmountLable.backgroundColor = [UIColor clearColor];
    lAmountLable.font = [UIFont boldSystemFontOfSize:15];
    lAmountLable.textColor = [UIColor purpleColor];
    UILabel *lStateLable = (UILabel *)[lcell viewWithTag:10003];
    if ([[[[JD_DataManager shareGoodsDataManager].OrderArray objectAtIndex:[indexPath row]] objectForKey:@"state"] intValue] == 0) {
        lStateLable.text = @"未完成";
    }else{
        lStateLable.text = @"已完成";
    }
    lStateLable.textAlignment = NSTextAlignmentCenter;
    lStateLable.backgroundColor = [UIColor clearColor];
    lStateLable.font = [UIFont boldSystemFontOfSize:15];
    lStateLable.textColor = [UIColor purpleColor];
    return lcell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [JD_DataManager shareGoodsDataManager].orderID = [[[JD_DataManager shareGoodsDataManager].OrderArray objectAtIndex:[indexPath row]] objectForKey:@"ordercode"];
    Orderetail *lOrderetail = [[[Orderetail alloc]init]autorelease];
    int section = [indexPath row];
    [self.navigationController pushViewController:lOrderetail animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"lalala" object:[NSNumber numberWithInt:section] userInfo:nil];
}

//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return @"删除";
//}
//
//-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewCellEditingStyleDelete;
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSInteger row=[indexPath row];
//    NSString *bodyString = [NSString stringWithFormat:@"ordercode=%@",[[[JD_DataManager shareGoodsDataManager].OrderArray objectAtIndex:row] objectForKey:@"ordercode"]];
//    NSLog(@"%@",bodyString);
//    ASIFormDataRequest *lRequest = [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:@"http://192.168.1.120/shop/deleteorder.php"]];
//    [lRequest setPostValue:[[[JD_DataManager shareGoodsDataManager].OrderArray objectAtIndex:row] objectForKey:@"ordercode"] forKey:@"ordercode"];
//    [lRequest startSynchronous];
//    NSDictionary *lDictionary = [NSJSONSerialization JSONObjectWithData:[lRequest responseData] options:NSJSONReadingAllowFragments error:nil];
//    NSString *errorString = [NSString stringWithFormat:@"%@",[lDictionary objectForKey:@"error"]];
//    if ([errorString isEqualToString:@"0"]) {
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
//    }
////    [[JD_DataManager shareGoodsDataManager] downloadDataWithHTTPMethod:@"post" WithBodyString:bodyString WithURLString:@"deleteorder.php" AndSuccess:^(NSData *data){
////        NSDictionary *lDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
////        NSString *errorString = [NSString stringWithFormat:@"%@",[lDictionary objectForKey:@"error"]];
////        if ([errorString isEqualToString:@"0"]) {
////            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
////        }
////    }AndFailed:^(){
////        
////    }];
//}

-(void)dealloc{
    [super dealloc];
    [TableView release];
    [HeardButton release];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
