//
//  JD_Search.m
//  京东商城
//
//  Created by TY on 14-1-3.
//  Copyright (c) 2014年 张闽. All rights reserved.
//

#import "JD_Search.h"
#import "JD_Goods.h"
#import "ASIFormDataRequest.h"

@interface JD_Search ()

@end

@implementation JD_Search

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabBar_item1_1@2x" ofType:@"png"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //请求数据
    [self getAllGoodsPostType:@"0" Order:@"0" Owncount:@"0"];
    //TableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, self.view.frame.size.height-65) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tag = 101;
    _tableView.backgroundView = nil;
    [_tableView.tableHeaderView removeFromSuperview];
    _tableView.showsVerticalScrollIndicator = NO;//隐藏滚动条
    [self.view addSubview:_tableView];
    //排序按钮
    UITextField *priceField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/2-0.5, 30)];
    priceField.backgroundColor = [UIColor whiteColor];
    priceField.text = @"价格";
    priceField.textColor = [UIColor grayColor];
    priceField.font = [UIFont systemFontOfSize:20];
    priceField.textAlignment = NSTextAlignmentCenter;
    priceField.userInteractionEnabled = NO;
    [self.view addSubview:priceField];
    UITextField *salesField = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2+0.5, 0, self.view.frame.size.width/2-0.5, 30)];
    salesField.backgroundColor = [UIColor whiteColor];
    salesField.text = @"销量";
    salesField.textColor = [UIColor grayColor];
    salesField.font = [UIFont systemFontOfSize:20];
    salesField.textAlignment = NSTextAlignmentCenter;
    salesField.userInteractionEnabled = NO;
    [self.view addSubview:salesField];
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(5, 30, self.view.frame.size.width/2-10, 1)];
    lineView1.backgroundColor = [UIColor grayColor];
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2+5, 30, self.view.frame.size.width/2-10, 1)];
    lineView2.backgroundColor = [UIColor grayColor];
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-0.5, 5, 1, 50)];
    lineView3.backgroundColor = [UIColor grayColor];
    [self.view addSubview:lineView1];
    [self.view addSubview:lineView2];
    [self.view addSubview:lineView3];
    UILabel *priceUplabel = [[UILabel alloc]initWithFrame:CGRectMake(0.5, 31, 79.5, 29.5)];
    priceUplabel.backgroundColor = [UIColor whiteColor];
    priceUplabel.text = @"升序";
    priceUplabel.textColor = [UIColor grayColor];
    priceUplabel.font = [UIFont systemFontOfSize:14];
    priceUplabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:priceUplabel];
    UILabel *priceDownlabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 31, 79.5, 29.5)];
    priceDownlabel.backgroundColor = [UIColor whiteColor];
    priceDownlabel.text = @"降序";
    priceDownlabel.textColor = [UIColor grayColor];
    priceDownlabel.font = [UIFont systemFontOfSize:14];
    priceDownlabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:priceDownlabel];
    UILabel *salesUplabel = [[UILabel alloc]initWithFrame:CGRectMake(161, 31, 79.5, 29.5)];
    salesUplabel.backgroundColor = [UIColor whiteColor];
    salesUplabel.text = @"升序";
    salesUplabel.textColor = [UIColor grayColor];
    salesUplabel.font = [UIFont systemFontOfSize:14];
    salesUplabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:salesUplabel];
    UILabel *salesDownlabel = [[UILabel alloc]initWithFrame:CGRectMake(240.5, 31, 79.5, 29.5)];
    salesDownlabel.backgroundColor = [UIColor whiteColor];
    salesDownlabel.text = @"降序";
    salesDownlabel.textColor = [UIColor grayColor];
    salesDownlabel.font = [UIFont systemFontOfSize:14];
    salesDownlabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:salesDownlabel];
    UIButton *priceUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    priceUpButton.frame = CGRectMake(0.5, 31, 79.5, 29.5);
    priceUpButton.backgroundColor = [UIColor clearColor];
    [priceUpButton addTarget:self action:@selector(priceUpButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:priceUpButton];
    UIButton *priceDownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    priceDownButton.frame = CGRectMake(80, 31, 79.5, 29.5);
    priceDownButton.backgroundColor = [UIColor clearColor];
    [priceDownButton addTarget:self action:@selector(priceDownButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:priceDownButton];
    UIButton *salesUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    salesUpButton.frame = CGRectMake(161, 31, 79.5, 29.5);
    salesUpButton.backgroundColor = [UIColor clearColor];
    [salesUpButton addTarget:self action:@selector(salesUpButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:salesUpButton];
    UIButton *salesDownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    salesDownButton.frame = CGRectMake(240.5, 31, 79.5, 29.5);
    salesDownButton.backgroundColor = [UIColor clearColor];
    [salesDownButton addTarget:self action:@selector(salesDownButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:salesDownButton];
    lineView = [[UIView alloc]init];
    lineView.frame = CGRectMake(5.5, 61, 69.5, 2);
    lineView.backgroundColor = [UIColor redColor];
    lineView.tag = 10;
    [self.view addSubview:lineView];
    
    [priceField release];
    [salesField release];
    [lineView1 release];
    [lineView2 release];
    [lineView3 release];
    [priceUplabel release];
    [priceDownlabel release];
    [salesUplabel release];
    [salesDownlabel release];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.navigationItem.rightBarButtonItems = nil;
    self.tabBarController.navigationItem.title = nil;
    //SearchBar
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 310, 44)];
    _searchBar.delegate = self;
    _searchBar.showsCancelButton = YES;
    [_searchBar setPlaceholder:@"搜索商品"];
    [[_searchBar.subviews objectAtIndex:0] removeFromSuperview];
    [_searchBar setBackgroundColor:[UIColor clearColor]];
    for (id custom in [_searchBar subviews]) {
        if ([custom isKindOfClass:[UIButton class]]) {
            UIButton *cancelButton = (UIButton *)custom;
            [cancelButton setTitle:@"取消"  forState:UIControlStateNormal];
            [cancelButton setTintColor:[UIColor redColor]];
        }
        if([custom isKindOfClass:[UITextField class]])
        {
            UITextField *textFiled = (UITextField *)custom;
            [textFiled setBorderStyle:UITextBorderStyleRoundedRect];
        }
    }
    self.tabBarController.navigationItem.leftBarButtonItem=[[[UIBarButtonItem alloc]initWithCustomView:_searchBar]autorelease];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [_goodsArray release];
    [_searchBar release];
    [_tableView release];
    [lineView release];
    [super dealloc];
}
#pragma mark - DownLoadMethod
-(void)getAllGoodsPostType:(NSString *)type Order:(NSString *)order Owncount:(NSString *)owncount
{
    NSString *bodyString = [NSString stringWithFormat:@"type=%@&order=%@&owncount=%@",type,order,owncount];
    [[JD_DataManager shareGoodsDataManager] downloadDataWithBodyString:bodyString WithURLString:@"getgoods.php" AndSuccess:^(NSData *data){
        NSDictionary *lDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *msgDictionary = [lDictionary objectForKey:@"msg"];
        NSArray *infoArray = [msgDictionary objectForKey:@"infos"];
        _goodsArray = [[NSMutableArray alloc]initWithArray:infoArray];
        [_tableView reloadData];
    }AndFailed:^{
        
    }];
}

-(void)getSearchGoodsPostSearch:(NSString *)search Type:(NSString *)type Order:(NSString *)order Owncount:(NSString *)owncount
{
    NSString *bodyString = [NSString stringWithFormat:@"search=%@&type=%@&order=%@&owncount=%@",search,type,order,owncount];
    [[JD_DataManager shareGoodsDataManager] downloadDataWithBodyString:bodyString WithURLString:@"searchgoods.php" AndSuccess:^(NSData *data){
        NSDictionary *lDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *msgDictionary = [lDictionary objectForKey:@"msg"];
        NSArray *infoArray = [msgDictionary objectForKey:@"infos"];
        _goodsArray = [[NSMutableArray alloc]initWithArray:infoArray];
        [_tableView reloadData];
    }AndFailed:^{
        
    }];
}
#pragma mark - SearchBarDelegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchText isEqualToString:@""]) {
        _tableView.tag = 101;
        [self getAllGoodsPostType:@"0" Order:@"0" Owncount:@"0"];
        _tableView.contentOffset = CGPointMake(0, 0);
        [_tableView reloadData];
    }else{
        _tableView.tag = 100;
        [self getSearchGoodsPostSearch:searchText Type:@"0" Order:@"0" Owncount:@"0"];
        _tableView.contentOffset = CGPointMake(0, 0);
        [_tableView reloadData];
    }
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    _tableView.tag = 101;
    _tableView.contentOffset = CGPointMake(0, 0);
    [_tableView reloadData];
    [searchBar resignFirstResponder];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
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
    lCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return lCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [JD_DataManager shareGoodsDataManager].goodsID = [[_goodsArray objectAtIndex:[indexPath section]] objectForKey:@"goodsid"];
    JD_Goods *lGoods=[[JD_Goods alloc]init];
    [self.navigationController pushViewController:lGoods animated:YES];
    [lGoods release];
}
#pragma mark - TableView上拉加载
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    float contentOffset = _tableView.contentSize.height - _tableView.frame.size.height;
    if (_tableView.tag == 101) {
        if (_tableView.contentOffset.y > (contentOffset + self.view.frame.size.height/4)) {
            if (_goodsArray.count%15 == 0) {
                NSMutableArray *tempArray = [[NSMutableArray alloc]initWithArray:_goodsArray];
                if (lineView.tag == 10) {
                    [self reloaDataTableViewWithType:@"0" Order:@"0" Owncount:[NSString stringWithFormat:@"%i",_goodsArray.count] AndTempArray:tempArray];
                }
                if (lineView.tag == 11) {
                    [self reloaDataTableViewWithType:@"0" Order:@"1" Owncount:[NSString stringWithFormat:@"%i",_goodsArray.count] AndTempArray:tempArray];
                }
                if (lineView.tag == 20) {
                    [self reloaDataTableViewWithType:@"1" Order:@"0" Owncount:[NSString stringWithFormat:@"%i",_goodsArray.count] AndTempArray:tempArray];
                }
                if (lineView.tag == 21) {
                    [self reloaDataTableViewWithType:@"1" Order:@"1" Owncount:[NSString stringWithFormat:@"%i",_goodsArray.count] AndTempArray:tempArray];
                }
            }else{
                NSLog(@"加载");
            }
        }
    }
}

-(void)reloaDataTableViewWithType:(NSString *)type Order:(NSString *)order Owncount:(NSString *)owncount AndTempArray:(NSMutableArray *)tempArray
{
    NSString *bodyString = [NSString stringWithFormat:@"type=%@&order=%@&owncount=%@",type,order,owncount];
    [[JD_DataManager shareGoodsDataManager] downloadDataWithBodyString:bodyString WithURLString:@"getgoods.php" AndSuccess:^(NSData *data){
        NSDictionary *lDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *msgDictionary = [lDictionary objectForKey:@"msg"];
        NSArray *infoArray = [msgDictionary objectForKey:@"infos"];
        _goodsArray = [[NSMutableArray alloc]initWithArray:infoArray];
        [tempArray addObjectsFromArray:_goodsArray];
        [_goodsArray removeAllObjects];
        [_goodsArray addObjectsFromArray:tempArray];
        [_tableView reloadData];
    }AndFailed:^{
        
    }];
}

#pragma mark - ButtonEvent
-(void)priceUpButton:(UIButton *)sender//按商品价格升序
{
    lineView.tag = 10;
    [UIView beginAnimations:@"animation" context:nil];
    lineView.frame = CGRectMake(5.5, 61, 69.5, 2);
    [UIView commitAnimations];
    if (_tableView.tag == 101) {
        [self getAllGoodsPostType:@"0" Order:@"0" Owncount:@"0"];
        _tableView.contentOffset = CGPointMake(0, 0);
        [_tableView reloadData];
    }else{
        [self getSearchGoodsPostSearch:_searchBar.text Type:@"0" Order:@"0" Owncount:@"0"];
        _tableView.contentOffset = CGPointMake(0, 0);
        [_tableView reloadData];
    }
}

-(void)priceDownButton:(UIButton *)sender//按商品价格降序
{
    lineView.tag = 11;
    [UIView beginAnimations:@"animation" context:nil];
    lineView.frame = CGRectMake(85, 61, 69.5, 2);
    [UIView commitAnimations];
    if (_tableView.tag == 101) {
        [self getAllGoodsPostType:@"0" Order:@"1" Owncount:@"0"];
        _tableView.contentOffset = CGPointMake(0, 0);
        [_tableView reloadData];
    }else{
        [self getSearchGoodsPostSearch:_searchBar.text Type:@"0" Order:@"1" Owncount:@"0"];
        _tableView.contentOffset = CGPointMake(0, 0);
        [_tableView reloadData];
    }
}

-(void)salesUpButton:(UIButton *)sender//按商品销量升序
{
    lineView.tag = 20;
    [UIView beginAnimations:@"animation" context:nil];
    lineView.frame = CGRectMake(166, 61, 69.5, 2);
    [UIView commitAnimations];
    if (_tableView.tag == 101) {
        [self getAllGoodsPostType:@"1" Order:@"0" Owncount:@"0"];
        _tableView.contentOffset = CGPointMake(0, 0);
        [_tableView reloadData];
    }else{
        [self getSearchGoodsPostSearch:_searchBar.text Type:@"1" Order:@"0" Owncount:@"0"];
        _tableView.contentOffset = CGPointMake(0, 0);
        [_tableView reloadData];
    }
}

-(void)salesDownButton:(UIButton *)sender//按商品销量降序
{
    lineView.tag = 21;
    [UIView beginAnimations:@"animation" context:nil];
    lineView.frame = CGRectMake(245.5, 61, 69.5, 2);
    [UIView commitAnimations];
    if (_tableView.tag == 101) {
        [self getAllGoodsPostType:@"1" Order:@"1" Owncount:@"0"];
        _tableView.contentOffset = CGPointMake(0, 0);
        [_tableView reloadData];
    }else{
        [self getSearchGoodsPostSearch:_searchBar.text Type:@"1" Order:@"1" Owncount:@"0"];
        _tableView.contentOffset = CGPointMake(0, 0);
        [_tableView reloadData];
    }
}

@end
