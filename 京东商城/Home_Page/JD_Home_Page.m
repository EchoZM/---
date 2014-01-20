//
//  JD_Home_Page.m
//  京东商城
//
//  Created by TY on 14-1-3.
//  Copyright (c) 2014年 张闽. All rights reserved.
//

#import "JD_Home_Page.h"
#import "JD_UserLogin.h"
#import "ASIFormDataRequest.h"
#import "JD_Goods.h"
#define ip @"http://192.168.1.121/shop/"
@interface JD_Home_Page ()

@end

@implementation JD_Home_Page

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabBar_item0_1@2x" ofType:@"png"]];
        _data=[[NSMutableData alloc]init];
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
    UIBarButtonItem *LastBarButton = [[[UIBarButtonItem alloc]initWithCustomView:lSearchBar]autorelease];
    [lLogo setImage:[UIImage imageNamed:@"companyLogo.png"]];
    self.tabBarController.navigationItem.leftBarButtonItems = @[FristBarButton,LastBarButton];
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    
    //添加scrollerview
    lScrollView=[[UIScrollView alloc]initWithFrame:self.view.frame];
    lScrollView.contentSize=CGSizeMake(320, self.view.frame.size.height);
    [self.view addSubview:lScrollView];
    lView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 150)];
    [lView1 setBackgroundColor:[UIColor clearColor]];
    [lScrollView addSubview:lView1];
    //滑动翻页
    _arrayImages=[NSArray arrayWithObjects:[UIImage imageNamed:@"1.jpg"],[UIImage imageNamed:@"2.jpg"],[UIImage imageNamed:@"3.jpg"],[UIImage imageNamed:@"4.jpg"],[UIImage imageNamed:@"5.jpg"], nil];
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
    _timer=[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(scrollPages) userInfo:nil repeats:YES];
    [self loadScrollViewPage:0];
    [self loadScrollViewPage:1];
    [self loadScrollViewPage:2];
    [self loadScrollViewPage:3];
    [self loadScrollViewPage:4];
    //    //4个button
    //    UIView *lView2=[[UIView alloc]initWithFrame:CGRectMake(0, 150, 320, 120)];
    //    [lView2 setBackgroundColor:[UIColor blackColor]];
    //    lView2.alpha=0.7;
    //    UIImage *image1=[UIImage imageNamed:@"ico_menu07@2x.png"];
    //    UIImage *image2=[UIImage imageNamed:@"ico_menu09@2x.png"];
    //    UIImage *image3=[UIImage imageNamed:@"xiang3@2x.png"];
    //    UIImage *image4=[UIImage imageNamed:@"ico_menu04@2x.png"];
    //    NSArray *imageArray=[[NSArray alloc]initWithObjects:image1,image2,image3,image4,nil];
    //    NSArray *textArray=[[NSArray alloc]initWithObjects:@"我的关注",@"喜摇摇",@"充值",@"彩票", nil];
    //    for (int i=0; i<imageArray.count; i++) {
    //        UIButton *lButton=[UIButton buttonWithType:UIButtonTypeCustom];
    //        [lButton setFrame:CGRectMake(10+i%4*75, 10, 70, 70)];
    //        [lButton setImage:[imageArray objectAtIndex:i] forState:UIControlStateNormal];
    //        [lButton setBackgroundColor:[UIColor whiteColor]];
    //        UILabel *lLabel=[[UILabel alloc]initWithFrame:CGRectMake(10+i%4*75, 80, 70, 30)];
    //        lLabel.text=[textArray objectAtIndex:i];
    //        [lLabel setTextAlignment:NSTextAlignmentCenter];
    //        [lLabel setBackgroundColor:[UIColor whiteColor]];
    //        [lView2 addSubview:lLabel];
    //        [lView2 addSubview:lButton];
    //    }
    //    [lScrollView addSubview:lView2];
    
    UILabel *lLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 150, 300, 50)];
    [lLabel setBackgroundColor:[UIColor clearColor]];
    [lLabel setText:@"热门商品"];
    [lLabel setFont:[UIFont fontWithName:@"Helvetica" size:23]];
    [lScrollView addSubview:lLabel];
    justTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 200, 300, self.view.frame.size.height-200)];
    //    justTableView.showsVerticalScrollIndicator=NO;
    //    justTableView.scrollEnabled=NO;//固定tableview
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
    NSString *lBodyString=[NSString stringWithFormat:@"goodscount=0"];//请求内容
    NSURL *lURL=[NSURL URLWithString:[ip stringByAppendingString:@"hotgoods.php"] ];
    NSMutableURLRequest *lRequest=[NSMutableURLRequest requestWithURL:lURL];
    [lRequest setHTTPMethod:@"post"];//发送请求
    [lRequest setHTTPBody:[lBodyString dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *lConnection=[NSURLConnection connectionWithRequest:lRequest delegate:self];
    [lConnection start];
    
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
#pragma loadData
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [_data setLength:0];
}//开始接收
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_data appendData:data];
}//保存到缓存data里面
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSDictionary *lDictionary=[NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingAllowFragments error:nil];
    lArray=[[lDictionary objectForKey:@"msg"]retain];
    [justTableView reloadData];
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
    }
    if (tableView.tag==99) {
        NSInteger row=[indexPath row];
        NSDictionary *dictionary=[lArray objectAtIndex:row];
        NSURL *lURL=[NSURL URLWithString:[[ip stringByAppendingString:@"goodsimage/"] stringByAppendingString:[dictionary objectForKey:@"headerimage"]]];
        NSData *lData=[NSData dataWithContentsOfURL:lURL];
        UIImage *lImage=[UIImage imageWithData:lData];
        lCell.textLabel.text=[dictionary objectForKey:@"name"];
        lCell.imageView.image=lImage;
        lCell.detailTextLabel.text=[[@"价格:" stringByAppendingString:[dictionary objectForKey:@"price"]] stringByAppendingString:@"元"];
        return  lCell;
    }else{
        NSInteger row=[indexPath row];
        NSDictionary *dictionary=[searchGoodsArray objectAtIndex:row];
        NSURL *lURL=[NSURL URLWithString:[[ip stringByAppendingString:@"goodsimage/"] stringByAppendingString:[dictionary objectForKey:@"headerimage"]]];
        NSData *lData=[NSData dataWithContentsOfURL:lURL];
        UIImage *lImage=[UIImage imageWithData:lData];
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
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (![searchText isEqualToString:@""]) {
        lScrollView.hidden=YES;
        lTableView.hidden=NO;
        [self downloadData:searchText Type:@"0" Order:@"0" Owncount:@"0"];
        [lTableView reloadData];
    }else{
        lScrollView.hidden=NO;
        lTableView.hidden=YES;
        [searchBar resignFirstResponder];
    }
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}
#pragma downloadData
-(NSMutableArray *)downloadData:(NSString *)search Type:(NSString *)type Order:(NSString *)order Owncount:(NSString *)owncount{
    NSURL *lURL=[NSURL URLWithString:[ip stringByAppendingString:@"searchgoods.php"]];
    ASIFormDataRequest *lRequest = [ASIFormDataRequest requestWithURL:lURL];
    [lRequest setPostValue:search forKey:@"search"];
    [lRequest setPostValue:type forKey:@"type"];
    [lRequest setPostValue:order forKey:@"order"];
    [lRequest setPostValue:owncount forKey:@"owncount"];
    [lRequest startSynchronous];
    NSDictionary *lDictionary = [NSJSONSerialization JSONObjectWithData:[lRequest responseData] options:NSJSONReadingAllowFragments error:nil];
    NSDictionary *msgDictionary = [lDictionary objectForKey:@"msg"];
    NSArray *infoArray = [msgDictionary objectForKey:@"infos"];
    searchGoodsArray = [[NSMutableArray alloc]initWithArray:infoArray];
    return searchGoodsArray;
}
-(void)viewTapped:(UITapGestureRecognizer *)sender{
    [lSearchBar resignFirstResponder];
}
-(void)dealloc{
    [lSearchBar release];
    [_scrollView release];
    [_pageControl release];
    [lView1 release];
    [_data release];
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
