//
//  JD_Home_Page.m
//  京东商城
//
//  Created by TY on 14-1-3.
//  Copyright (c) 2014年 张闽. All rights reserved.
//

#import "JD_Home_Page.h"
#import "JD_AccountManage.h"
#import "ASIFormDataRequest.h"
#import "JD_Goods.h"
@interface JD_Home_Page ()

@end

@implementation JD_Home_Page

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabBar_item0_1@2x" ofType:@"png"]];
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
    [lScrollView removeFromSuperview];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.navigationItem.title = nil;
    UIImageView *lLogo = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)]autorelease];
    UIBarButtonItem *FristBarButton = [[[UIBarButtonItem alloc]initWithCustomView:lLogo]autorelease];
    lSearchBar = [[[UISearchBar alloc]initWithFrame:CGRectMake(44, 0, 257, 44)]autorelease];
    [[lSearchBar.subviews objectAtIndex:0] removeFromSuperview];
    lSearchBar.delegate=self;
    [lSearchBar setBackgroundColor:[UIColor clearColor]];
    [lSearchBar setPlaceholder:@"搜索商品"];
    for (id custom in [lSearchBar subviews]) {
        if([custom isKindOfClass:[UITextField class]])
        {
            UITextField *textFiled = (UITextField *)custom;
            [textFiled setBorderStyle:UITextBorderStyleRoundedRect];
        }
    }
    UIBarButtonItem *LastBarButton = [[[UIBarButtonItem alloc]initWithCustomView:lSearchBar]autorelease];
    [lLogo setImage:[UIImage imageNamed:@"logo.jpg"]];
    self.tabBarController.navigationItem.leftBarButtonItems = @[FristBarButton,LastBarButton];
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    
    //添加scrollerview
    lScrollView=[[UIScrollView alloc]initWithFrame:self.view.frame];
    lScrollView.contentSize=CGSizeMake(320, self.view.frame.size.height);
    [self.view addSubview:lScrollView];
    lView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 115)];
    [lView1 setBackgroundColor:[UIColor clearColor]];
    [lScrollView addSubview:lView1];
    //滑动翻页
    _arrayImages=[NSArray arrayWithObjects:[UIImage imageNamed:@"11"],[UIImage imageNamed:@"22"],[UIImage imageNamed:@"33"],[UIImage imageNamed:@"44"],[UIImage imageNamed:@"55"], nil];
    [lView1 addSubview:lImageView];
    //设置scroll的属性
    _scrollView=[[UIScrollView alloc]initWithFrame:lView1.frame];
    _scrollView.showsVerticalScrollIndicator=NO;//不显示垂直滑动线
    _scrollView.showsHorizontalScrollIndicator=NO;//不显示水平滑动线
    _scrollView.pagingEnabled=YES;
    _scrollView.scrollsToTop=NO;
    _scrollView.delegate=self;
    [lView1 addSubview:_scrollView];
    for (int i=0; i<_arrayImages.count; i++) {
        CGRect frame;
        frame.origin.x=_scrollView.frame.size.width*i;
        frame.origin.y=0;
        frame.size=_scrollView.frame.size;
        
        UIImageView *subView=[[UIImageView alloc]initWithFrame:frame];
        [subView setBackgroundColor:[UIColor clearColor]];
        subView.image=[_arrayImages objectAtIndex:i];
        [_scrollView addSubview:subView];
    }
    //设置scroll view的contentsize属性
    _scrollView.contentSize=CGSizeMake(CGRectGetWidth(lView1.frame)*_arrayImages.count,lView1.frame.size.height);
    
    //定义uipagecontrol
    _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(150, 100, 10, 10)];
    _pageControl.numberOfPages=_arrayImages.count;//设置页数
    [_pageControl setBackgroundColor:[UIColor clearColor]];
    _pageControl.currentPage=0;//设置当前页
    _pageControl.hidesForSinglePage=NO;
    [_pageControl addTarget:self action:@selector(pageControlChanged:) forControlEvents:UIControlEventValueChanged];
    [lView1 addSubview:_pageControl];
    
    _viewController=[[NSMutableArray alloc]init];
    for (NSInteger i=0; i<_arrayImages.count; i++) {
        [_viewController addObject:[NSNull null]];
    }
    //nstimer的用法
    _timer=[NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(scrollPages) userInfo:nil repeats:YES];
    [self loadScrollViewPage:0];
    [self loadScrollViewPage:1];
    [self loadScrollViewPage:2];
    [self loadScrollViewPage:3];
    [self loadScrollViewPage:4];
    
    UILabel *lLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 115, 300, 50)];
    [lLabel setBackgroundColor:[UIColor clearColor]];
    [lLabel setText:@"热门商品"];
    [lLabel setTextColor:[UIColor blueColor]];
    [lLabel setFont:[UIFont fontWithName:@"Helvetica" size:20]];
    [lScrollView addSubview:lLabel];
    
    justTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 165, 320, self.view.frame.size.height-165)];
    justTableView.delegate=self;
    justTableView.dataSource=self;
    justTableView.tag=99;
    [lScrollView addSubview:justTableView];
    
    lTableView=[[UITableView alloc]initWithFrame:self.view.frame];
    lTableView.hidden=YES;
    lTableView.tag=100;
    lTableView.backgroundView = nil;
    lTableView.backgroundColor = [UIColor clearColor];
    lTableView.delegate=self;
    lTableView.dataSource=self;
    [self.view addSubview:lTableView];
    //点击空白处
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapped:)];
    [lView1 addGestureRecognizer:tap];
    
    //网络请求数据
    NSString *bodyString=[NSString stringWithFormat:@"goodscount=0"];
    [[JD_DataManager shareGoodsDataManager] downloadDataWithHTTPMethod:@"post" WithBodyString:bodyString WithURLString:@"hotgoods.php" AndSuccess:^(NSData *data){
        NSDictionary *lDictionary=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        lArray=[[lDictionary objectForKey:@"msg"]retain];
        [justTableView reloadData];
    }AndFailed:^(){
        
    }];
    
}
#pragma scrollView And UIPageControl//自动翻页和手动翻页效果
-(void)loadScrollViewPage:(NSInteger)page{
    //当page大于数组时，自动返回
    if (page>_arrayImages.count) {
        return;
    }
    //创建一个视图控制器，并将空的地址导人
    UIViewController *imageViewController=[_viewController objectAtIndex:page];
    if ((NSNull *)imageViewController==[NSNull null]) {
        imageViewController=[[UIViewController alloc]init];
        [_viewController replaceObjectAtIndex:page withObject:imageViewController];
    }
    //假如imageviewcontroller没有子视图，那么就添加
    if (imageViewController.view.superview==nil) {
        CGRect frame=_scrollView.frame;
        frame.origin.x=CGRectGetWidth(frame)*page;
        frame.origin.y=0;
        imageViewController.view.frame=frame;
        
        [_scrollView addSubview:imageViewController.view];
        [imageViewController didMoveToParentViewController:self];
        [imageViewController.view setBackgroundColor:[UIColor colorWithPatternImage:(UIImage *)[self.arrayImages objectAtIndex:page]]];
    }
}
//scrollview的代理方法，横向滚动切换到下一张图片
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat pageWidth=CGRectGetWidth(_scrollView.frame);
    NSInteger page=floor((_scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1;
    _pageControl.currentPage=page;
}
-(void)pageControlChanged:(UIPageControl *)sender{
    NSInteger page=_pageControl.currentPage;
    CGRect bounds=_scrollView.bounds;
    bounds.origin.x=CGRectGetWidth(bounds)*page;
    bounds.origin.y=0;
    [_scrollView scrollRectToVisible:bounds animated:YES];
}
//nstimer的方法，实现自动滚动
-(void)scrollPages{
    ++_pageControl.currentPage;
    CGFloat pageWidth=CGRectGetWidth(_scrollView.frame);
    if (isFromStart) {
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        _pageControl.currentPage=0;
    }else{
        [_scrollView setContentOffset:CGPointMake(pageWidth*_pageControl.currentPage, _scrollView.bounds.origin.y) animated:YES];
    }
    if (_pageControl.currentPage==_pageControl.numberOfPages-1) {
        isFromStart=YES;
    }else{
        isFromStart=NO;
    }
}
#pragma TableViewMethod
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag==99) {
        return lArray.count;
    }
    return searchGoodsArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID=@"cell";
    UITableViewCell *lCell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (lCell==nil) {
        lCell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        lCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (tableView.tag==99) {
        NSInteger row=[indexPath row];
        NSDictionary *dictionary=[lArray objectAtIndex:row];
        UIImage *lImage=[[JD_DataManager shareGoodsDataManager] getgoodsImage:[dictionary objectForKey:@"headerimage"]];
        lCell.textLabel.text=[dictionary objectForKey:@"name"];
        lCell.imageView.image=lImage;
        lCell.detailTextLabel.text=[[@"价格:" stringByAppendingString:[dictionary objectForKey:@"price"]] stringByAppendingString:@"元"];
        return  lCell;
    }else{
        NSInteger row=[indexPath row];
        NSDictionary *dictionary=[searchGoodsArray objectAtIndex:row];
        UIImage *lImage=[[JD_DataManager shareGoodsDataManager] getgoodsImage:[dictionary objectForKey:@"headerimage"]];
        lCell.textLabel.text=[dictionary objectForKey:@"name"];
        lCell.backgroundColor = [UIColor clearColor];
        lCell.textLabel.text=[dictionary objectForKey:@"name"];
        lCell.imageView.image=lImage;
        lCell.detailTextLabel.text=[[@"价格:" stringByAppendingString:[dictionary objectForKey:@"price"]] stringByAppendingString:@"元"];;
        return lCell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row=[indexPath row];
    if (tableView.tag==99) {
        NSDictionary *dictionary=[lArray objectAtIndex:row];
        [JD_DataManager shareGoodsDataManager].goodsID=[dictionary objectForKey:@"goodsid"];
        JD_Goods *goodsViewController=[[JD_Goods alloc]init];
        [self.navigationController pushViewController:goodsViewController animated:YES];
        [goodsViewController release];
    }else{
        NSDictionary *dictionary=[searchGoodsArray objectAtIndex:row];
        [JD_DataManager shareGoodsDataManager].goodsID=[dictionary objectForKey:@"goodsid"];
        JD_Goods *goodsViewController=[[JD_Goods alloc]init];
        [self.navigationController pushViewController:goodsViewController animated:YES];
        [goodsViewController release];
    }
}

#define searthMothed
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton=YES;
    for (id custom in [searchBar subviews]) {
        if ([custom isKindOfClass:[UIButton class]]) {
            UIButton *cancelButton = (UIButton *)custom;
            [cancelButton setTitle:@"取消"  forState:UIControlStateNormal];
            [cancelButton setTintColor:[UIColor redColor]];
        }
    }
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (![searchText isEqualToString:@""]) {
        lScrollView.hidden=YES;
        lTableView.hidden=NO;
        [self downloadData:searchText Type:@"0" Order:@"0" Owncount:@"0"];
    }else{
        lScrollView.hidden=NO;
        lTableView.hidden=YES;
        [searchBar resignFirstResponder];
    }
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    searchBar.showsCancelButton=NO;
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    searchBar.showsCancelButton=NO;
}
#pragma downloadData
-(void)downloadData:(NSString *)search Type:(NSString *)type Order:(NSString *)order Owncount:(NSString *)owncount{
    NSString *bodyString = [NSString stringWithFormat:@"search=%@&type=%@&order=%@&owncount=%@",search,type,order,owncount];
    [[JD_DataManager shareGoodsDataManager] downloadDataWithHTTPMethod:@"post" WithBodyString:bodyString WithURLString:@"searchgoods.php" AndSuccess:^(NSData *data){
        NSDictionary *lDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *msgDictionary = [lDictionary objectForKey:@"msg"];
        NSArray *infoArray = [msgDictionary objectForKey:@"infos"];
        searchGoodsArray = [[NSMutableArray alloc]initWithArray:infoArray];
        [lTableView reloadData];
    }AndFailed:^{
        
    }];
}
-(void)viewTapped:(UITapGestureRecognizer *)sender{
    [lSearchBar resignFirstResponder];
}
-(void)dealloc{
    [lSearchBar release];
    [_scrollView release];
    [_pageControl release];
    [lView1 release];
    [lArray release];
    [justTableView release];
    [lImageView release];
    [lScrollView release];
    [lTableView release];
    [searchGoodsArray release];
    [_timer release];
    [_arrayImages release];
    [_viewController release];
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
