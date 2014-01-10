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
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 31, self.view.frame.size.width, self.view.frame.size.height-31) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tag = 101;
    _tableView.backgroundView = nil;
    [_tableView.tableHeaderView removeFromSuperview];
    _tableView.showsVerticalScrollIndicator = NO;//隐藏滚动条
    [self.view addSubview:_tableView];
    //排序按钮
    UITextField *priceField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/2, 30)];
    priceField.backgroundColor = [UIColor whiteColor];
    priceField.text = @"价格";
    priceField.textColor = [UIColor grayColor];
    priceField.font = [UIFont systemFontOfSize:20];
    priceField.textAlignment = NSTextAlignmentLeft;
    [priceField setBorderStyle:UITextBorderStyleLine];
    UITextField *salesField = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2, 0, self.view.frame.size.width/2, 30)];
    salesField.backgroundColor = [UIColor whiteColor];
    salesField.text = @"销量";
    salesField.textColor = [UIColor grayColor];
    salesField.font = [UIFont systemFontOfSize:20];
    salesField.textAlignment = NSTextAlignmentLeft;
    [salesField setBorderStyle:UITextBorderStyleLine];
    priceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    priceButton.tag = 10;
    priceButton.frame = CGRectMake(0, 0, self.view.frame.size.width/2, 30);
    priceButton.backgroundColor = [UIColor clearColor];
    [priceButton addTarget:self action:@selector(priceButton:) forControlEvents:UIControlEventTouchUpInside];
    salesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    salesButton.tag = 20;
    salesButton.frame = CGRectMake(0, 0, self.view.frame.size.width/2, 30);
    salesButton.backgroundColor = [UIColor clearColor];
    [salesButton addTarget:self action:@selector(salesButton:) forControlEvents:UIControlEventTouchUpInside];
    [priceField addSubview:priceButton];
    [salesField addSubview:salesButton];
    [self.view addSubview:priceField];
    [self.view addSubview:salesField];
    [priceField release];
    [salesField release];
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
    [_searchBar setPlaceholder:@"搜索京东商品"];
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
    [super dealloc];
}
#pragma mark - DownLoadMethod
-(NSMutableArray *)getAllGoodsPostType:(NSString *)type Order:(NSString *)order Owncount:(NSString *)owncount
{
    NSURL *lURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/shop/getgoods.php",IP]];
    ASIFormDataRequest *lRequest = [ASIFormDataRequest requestWithURL:lURL];
    [lRequest setPostValue:type forKey:@"type"];
    [lRequest setPostValue:order forKey:@"order"];
    [lRequest setPostValue:owncount forKey:@"owncount"];
    [lRequest startSynchronous];
    NSDictionary *lDictionary = [NSJSONSerialization JSONObjectWithData:[lRequest responseData] options:NSJSONReadingAllowFragments error:nil];
    NSDictionary *msgDictionary = [lDictionary objectForKey:@"msg"];
    NSArray *infoArray = [msgDictionary objectForKey:@"infos"];
    _goodsArray = [[NSMutableArray alloc]initWithArray:infoArray];
    return _goodsArray;
}

-(NSMutableArray *)getSearchGoodsPostSearch:(NSString *)search Type:(NSString *)type Order:(NSString *)order Owncount:(NSString *)owncount
{
    NSURL *lURL = [NSURL URLWithString:@"http://192.168.1.136/shop/searchgoods.php"];
    ASIFormDataRequest *lRequest = [ASIFormDataRequest requestWithURL:lURL];
    [lRequest setPostValue:search forKey:@"search"];
    [lRequest setPostValue:type forKey:@"type"];
    [lRequest setPostValue:order forKey:@"order"];
    [lRequest setPostValue:owncount forKey:@"owncount"];
    [lRequest startSynchronous];
    NSDictionary *lDictionary = [NSJSONSerialization JSONObjectWithData:[lRequest responseData] options:NSJSONReadingAllowFragments error:nil];
    NSDictionary *msgDictionary = [lDictionary objectForKey:@"msg"];
    NSArray *infoArray = [msgDictionary objectForKey:@"infos"];
    _goodsArray = [[NSMutableArray alloc]initWithArray:infoArray];
    NSLog(@"%@",_goodsArray);
    return _goodsArray;
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
    return 110;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    UITableViewCell *lCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (lCell == nil) {
        lCell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID]autorelease];
        lCell.selectionStyle = UITableViewCellSelectionStyleNone;
        lCell.backgroundColor = [UIColor clearColor];
    }
    NSURL *imageURL = [NSURL URLWithString:[@"http://192.168.1.136/shop/goodsimage/" stringByAppendingString:[[_goodsArray objectAtIndex:[indexPath section]] objectForKey:@"headerimage"]]];
    NSData *lData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *goodsImage = [UIImage imageWithData:lData];
    lCell.imageView.image = goodsImage;
    lCell.textLabel.text = [[_goodsArray objectAtIndex:[indexPath section]] objectForKey:@"name"];
    lCell.textLabel.font = [UIFont systemFontOfSize:20];
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
//TableView上拉加载
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    float contentOffset = _tableView.contentSize.height - _tableView.frame.size.height;
    if (_tableView.tag == 101) {
        if (_tableView.contentOffset.y > (contentOffset + self.view.frame.size.height/4)) {
            if (_goodsArray.count%15 == 0) {
                NSMutableArray *tempArray = [[NSMutableArray alloc]initWithArray:_goodsArray];
                [self getAllGoodsPostType:@"0" Order:@"0" Owncount:[NSString stringWithFormat:@"%i",_goodsArray.count]];
                [tempArray addObjectsFromArray:_goodsArray];
                [_goodsArray removeAllObjects];
                [_goodsArray addObjectsFromArray:tempArray];
                [_tableView reloadData];
            }else{
                NSLog(@"上拉加载");
            }
        }
    }
}
#pragma mark - ButtonEvent
-(void)priceButton:(UIButton *)sender//按商品价格排序
{
    if (sender.tag == 10) {
        sender.tag = 11;
        if (_tableView.tag == 101) {
            [self getAllGoodsPostType:@"0" Order:@"1" Owncount:@"0"];
            _tableView.contentOffset = CGPointMake(0, 0);
            [_tableView reloadData];
        }else{
            [self getSearchGoodsPostSearch:_searchBar.text Type:@"0" Order:@"1" Owncount:@"0"];
            _tableView.contentOffset = CGPointMake(0, 0);
            [_tableView reloadData];
        }
    }else{
        sender.tag = 10;
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
}

-(void)salesButton:(UIButton *)sender//按商品销量排序
{
    if (sender.tag == 20) {
        sender.tag = 21;
        if (_tableView.tag == 101) {
            [self getAllGoodsPostType:@"1" Order:@"1" Owncount:@"0"];
            _tableView.contentOffset = CGPointMake(0, 0);
            [_tableView reloadData];
        }else{
            [self getSearchGoodsPostSearch:_searchBar.text Type:@"1" Order:@"1" Owncount:@"0"];
            _tableView.contentOffset = CGPointMake(0, 0);
            [_tableView reloadData];
        }
    }else{
        sender.tag = 20;
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
}

@end
