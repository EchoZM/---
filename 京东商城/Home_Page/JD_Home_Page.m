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
//        // Custom initialization
        self.tabBarItem.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabBar_item0_1@2x" ofType:@"png"]];
//         _data=[[NSMutableData alloc]init];
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
    lScrollView.contentSize=CGSizeMake(320, 630);
    [self.view addSubview:lScrollView];
    lView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 150)];
    [lScrollView addSubview:lView1];
    //滑动翻页
    NSArray *colors=[NSArray arrayWithObjects:[UIImage imageNamed:@"1.jpg"],[UIImage imageNamed:@"2.jpg"],[UIImage imageNamed:@"3.jpg"],[UIImage imageNamed:@"4.jpg"],[UIImage imageNamed:@"5.jpg"], nil];
    [lView1 addSubview:lImageView];
    //设置scroll的属性
    _scroll=[[UIScrollView alloc]initWithFrame:lView1.frame];
    _scroll.showsVerticalScrollIndicator=NO;//不显示垂直滑动线
    _scroll.showsHorizontalScrollIndicator=NO;//不显示水平滑动线
    _scroll.pagingEnabled=YES;
    _scroll.scrollsToTop=NO;
    _scroll.delegate=self;
    [lView1 addSubview:_scroll];
    for (int i=0; i<colors.count; i++) {
        CGRect frame;
        frame.origin.x=_scroll.frame.size.width*i;
        frame.origin.y=0;
        frame.size=_scroll.frame.size;
        
        UIImageView *subView=[[UIImageView alloc]initWithFrame:frame];
        subView.image=[colors objectAtIndex:i];
        subView.animationDuration=20;
        subView.animationImages=colors;
        subView.animationRepeatCount=500;
        [subView startAnimating];
        [_scroll addSubview:subView];
    }
    //设置scroll view的contentsize属性
    _scroll.contentSize=CGSizeMake(_scroll.frame.size.width*colors.count, _scroll.frame.size.height);
    
    _pageController=[[UIPageControl alloc]initWithFrame:CGRectMake(150, 100, 5, 5)];
    _pageController.numberOfPages=colors.count;//设置页数
    _pageController.currentPage=0;//设置当前页
    _pageController.hidesForSinglePage=NO;
    
    _pageController.backgroundColor=[UIColor blackColor];
    [_pageController addTarget:self action:@selector(pageControlChanged:) forControlEvents:UIControlEventValueChanged];
    [lView1 addSubview:_pageController];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerChang:) userInfo:nil repeats:YES];
    
    UIView *lView2=[[UIView alloc]initWithFrame:CGRectMake(0, 150, 320, 120)];
    [lView2 setBackgroundColor:[UIColor blackColor]];
    lView2.alpha=0.7;
    UIImage *image1=[UIImage imageNamed:@"ico_menu07@2x.png"];
    UIImage *image2=[UIImage imageNamed:@"ico_menu09@2x.png"];
    UIImage *image3=[UIImage imageNamed:@"xiang3@2x.png"];
    UIImage *image4=[UIImage imageNamed:@"ico_menu04@2x.png"];
    NSArray *imageArray=[[NSArray alloc]initWithObjects:image1,image2,image3,image4,nil];
    NSArray *textArray=[[NSArray alloc]initWithObjects:@"我的关注",@"喜摇摇",@"充值",@"彩票", nil];
    for (int i=0; i<imageArray.count; i++) {
        UIButton *lButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [lButton setFrame:CGRectMake(10+i%4*75, 10, 70, 70)];
        [lButton setImage:[imageArray objectAtIndex:i] forState:UIControlStateNormal];
        [lButton setBackgroundColor:[UIColor whiteColor]];
        UILabel *lLabel=[[UILabel alloc]initWithFrame:CGRectMake(10+i%4*75, 80, 70, 30)];
        lLabel.text=[textArray objectAtIndex:i];
        [lLabel setTextAlignment:NSTextAlignmentCenter];
        [lLabel setBackgroundColor:[UIColor whiteColor]];
        [lView2 addSubview:lLabel];
        [lView2 addSubview:lButton];
    }
    [lScrollView addSubview:lView2];
    
    UILabel *lLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 270, 300, 50)];
    [lLabel setBackgroundColor:[UIColor clearColor]];
    [lLabel setText:@"掌上秒杀"];
    [lLabel setFont:[UIFont fontWithName:@"Helvetica" size:23]];
    [lScrollView addSubview:lLabel];
    justTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 330, 300, 300)];
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
//    NSString *lBodyString=[NSString stringWithFormat:@"goodscount=0"];//请求内容
    
//    NSURL *lURL=[NSURL URLWithString:@"http://192.168.1.138/shop/hotgoods.php "];//ip地址
//    NSMutableURLRequest *lRequest=[NSMutableURLRequest requestWithURL:lURL];//请求初始化
//    [lRequest setHTTPMethod:@"post"];//发送请求
//    [lRequest setHTTPBody:[lBodyString dataUsingEncoding:NSUTF8StringEncoding]];
//    NSURLConnection *lConnection=[NSURLConnection connectionWithRequest:lRequest delegate:self];
//    [lConnection start];
//    NSData *lData=[[JD_DataManager shareGoodsDataManager] downloadDataWithBody:lBodyString URL:@"hotgoods.php"];
//    NSLog(@"%@",[[NSString alloc]initWithData:lData encoding:NSUTF8StringEncoding]);
//    NSDictionary *lDictionary=[NSJSONSerialization JSONObjectWithData:lData options:NSJSONReadingAllowFragments error:nil];
//    lArray=[[lDictionary objectForKey:@"msg"]retain];
//    [justTableView reloadData];
}
-(void)timerChang:(NSTimer *)sender{
    

}
#pragma downloadData
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
#pragma scrollViewMethod
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat pageWidth=_scroll.frame.size.width;
    //在滚动超过50%的时候切换到新页面
    int page=floor((_scroll.contentOffset.x-pageWidth/2)/pageWidth)+1;
    _pageController.currentPage=page;
}
-(void)pageControlChanged:(id)sender{
    //更新scroll view到正确的页面
//    CGRect frame;
//    frame.origin.x=_scroll.frame.size.width*_pageController.currentPage;
//    frame.origin.y=0;
//    frame.size=_scroll.frame.size;
//    [_scroll scrollRectToVisible:frame animated:YES];
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
//        NSInteger row=[indexPath row];
//        NSDictionary *dictionary=[lArray objectAtIndex:row];
//        NSURL *lURL=[NSURL URLWithString:[@"http://192.168.1.141/shop/goodsimage/" stringByAppendingString:[dictionary objectForKey:@"headerimage"]]];
//        NSData *lData=[NSData dataWithContentsOfURL:lURL];
//        UIImage *lImage=[UIImage imageWithData:lData];
//        lCell.textLabel.text=[dictionary objectForKey:@"name"];
//        lCell.imageView.image=lImage;
//        lCell.detailTextLabel.text=[[@"价格:" stringByAppendingString:[dictionary objectForKey:@"price"]] stringByAppendingString:@"元"];
        return  lCell;
    }
//    NSInteger row=[indexPath row];
//    NSDictionary *dictionary=[searchGoodsArray objectAtIndex:row];
//    NSURL *lURL=[NSURL URLWithString:[@"http://192.168.1.141/shop/goodsimage/" stringByAppendingString:[dictionary objectForKey:@"headerimage"]]];
//    NSData *lData=[NSData dataWithContentsOfURL:lURL];
//    UIImage *lImage=[UIImage imageWithData:lData];
//    lCell.backgroundColor = [UIColor clearColor];
//    lCell.textLabel.text=[dictionary objectForKey:@"name"];
//    lCell.imageView.image=lImage;
//    lCell.detailTextLabel.text=[[@"价格:" stringByAppendingString:[dictionary objectForKey:@"price"]] stringByAppendingString:@"元"];;
    return lCell;
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
//        NSLog(@"%@",searchGoodsArray);
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
//        [self downloadData:searchText Type:@"0" Order:@"0" Owncount:@"0"];
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
    NSURL *lURL = [NSURL URLWithString:@"http://192.168.1.141/shop/searchgoods.php"];
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
//    NSLog(@"%@",searchGoodsArray);
    return searchGoodsArray;
}
-(void)viewTapped:(UITapGestureRecognizer *)sender{
//    [lSearchBar resignFirstResponder];
}
-(void)dealloc{
    [lSearchBar release];
    [_scroll release];
    [_pageController release];
    [lView1 release];
    [_data release];
    [lArray release];
    [justTableView release];
    [lImageView release];
    [lScrollView release];
    [lTableView release];
    [searchGoodsArray release];
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
