//
//  JD_Search.m
//  京东商城
//
//  Created by TY on 14-1-3.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import "JD_Search.h"

@interface JD_Search ()

@end

@implementation JD_Search

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabBar_item1_1@2x" ofType:@"png"]];
        self.view.backgroundColor = [UIColor darkGrayColor];
        //        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"search_bg"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _data = [[NSMutableData alloc]init];
    [self requestData];
    //TableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tag = 101;
    _tableView.backgroundView = nil;
    [_tableView.tableHeaderView removeFromSuperview];
    _tableView.layer.cornerRadius = 8;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
            [cancelButton setBackgroundColor:[UIColor redColor]];
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
    [_data release];
    [_goodsArray release];
    [_searchBar release];
    [_tableView release];
    [super dealloc];
}
#pragma mark - 请求数据
-(void)requestData
{
    NSString *bodyString = @"type=0&order=0&owncount=0";
    NSURL *lURL = [NSURL URLWithString:@"http://192.168.1.136/shop/getgoods.php"];
    NSMutableURLRequest *lRequest = [NSMutableURLRequest requestWithURL:lURL];
    [lRequest setHTTPMethod:@"post"];
    [lRequest setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *lConnection = [NSURLConnection connectionWithRequest:lRequest delegate:self];
    [lConnection start];
}
#pragma mark - ConnectionDataDelegate
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_data setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (_tableView.tag == 101) {
        NSDictionary *lDictionary = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *msgDictionary = [lDictionary objectForKey:@"msg"];
        NSArray *infoArray = [msgDictionary objectForKey:@"infos"];
        _goodsArray = [[NSMutableArray alloc]initWithArray:infoArray];
    }else{
        NSDictionary *lDictionary = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *msgDictionary = [lDictionary objectForKey:@"msg"];
        NSArray *infoArray = [msgDictionary objectForKey:@"infos"];
        _searchArray = [[NSMutableArray alloc]initWithArray:infoArray];
    }
}
#pragma mark - SearchBarDelegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchText isEqualToString:@""]) {
        _tableView.tag = 101;
        [_tableView reloadData];
    }else{
        _tableView.tag = 100;
        NSString *bodyString = [NSString stringWithFormat:@"search=%@&type=0&order=0&owncount=0",searchText];
        NSURL *lURL = [NSURL URLWithString:@"http://192.168.1.136/shop/searchgoods.php"];
        NSMutableURLRequest *lRequest = [NSMutableURLRequest requestWithURL:lURL];
        [lRequest setHTTPMethod:@"post"];
        [lRequest setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
        NSURLConnection *lConnection = [NSURLConnection connectionWithRequest:lRequest delegate:self];
        [lConnection start];
        [_tableView reloadData];
        NSLog(@"searchArray:%@",_searchArray);
    }
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    _tableView.tag = 101;
    [searchBar resignFirstResponder];
    [_tableView reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}
#pragma mark - TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_tableView.tag == 101) {
        return _goodsArray.count;
    }else{
        return _searchArray.count;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    UITableViewCell *lCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (lCell == nil) {
        lCell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID]autorelease];
        lCell.selectionStyle = UITableViewCellSelectionStyleNone;
        lCell.backgroundColor = [UIColor whiteColor];
    }
    if (_tableView.tag == 101) {
        NSURL *imageURL=[NSURL URLWithString:[@"http://192.168.1.136/shop/goodsimage/" stringByAppendingString:[[_goodsArray objectAtIndex:[indexPath section]] objectForKey:@"headerimage"]]];
        NSData *lData=[NSData dataWithContentsOfURL:imageURL];
        lCell.imageView.image = [UIImage imageWithData:lData];
        lCell.textLabel.text = [[_goodsArray objectAtIndex:[indexPath section]] objectForKey:@"name"];
        lCell.textLabel.font = [UIFont systemFontOfSize:20];
        lCell.detailTextLabel.text = [@"单价:" stringByAppendingString:[[[_goodsArray objectAtIndex:[indexPath section]] objectForKey:@"price"] stringByAppendingString:@"元"]];
        lCell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        lCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        NSURL *imageURL=[NSURL URLWithString:[@"http://192.168.1.136/shop/goodsimage/" stringByAppendingString:[[_searchArray objectAtIndex:[indexPath section]] objectForKey:@"headerimage"]]];
        NSData *lData=[NSData dataWithContentsOfURL:imageURL];
        lCell.imageView.image = [UIImage imageWithData:lData];
        lCell.textLabel.text = [[_searchArray objectAtIndex:[indexPath section]] objectForKey:@"name"];
        lCell.textLabel.font = [UIFont systemFontOfSize:20];
        lCell.detailTextLabel.text = [@"单价:" stringByAppendingString:[[[_searchArray objectAtIndex:[indexPath section]] objectForKey:@"price"] stringByAppendingString:@"元"]];
        lCell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        lCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return lCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击之后进入商品详情页面
}

@end
