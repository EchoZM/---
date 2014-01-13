//
//  JD_ShopCar.m
//  京东商城
//
//  Created by TY on 14-1-3.
//  Copyright (c) 2014年 张闽. All rights reserved.
//

#import "JD_ShopCar.h"
#import  "JD_UserLogin.h"
#import "JD_Home_Page.h"
@interface JD_ShopCar ()

@end

@implementation JD_ShopCar

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabBar_item2_1@2x" ofType:@"png"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
-(NSMutableArray *)LoadAllGoods:(NSString *)CustomerId
{
    NSURL *lURL = [NSURL URLWithString:@"http://192.168.1.138/shop/getcart.php"];
    ASIFormDataRequest *lRequest = [ASIFormDataRequest requestWithURL:lURL];
    [lRequest setPostValue:CustomerId forKey:@"customerid"];
    [lRequest startSynchronous];
    
    
    
    NSDictionary *lDictionary = [NSJSONSerialization JSONObjectWithData:[lRequest responseData] options:NSJSONReadingAllowFragments error:nil];
    int ErrorJudge= [[lDictionary objectForKey:@"error"]intValue];
    
    if (ErrorJudge==1) {
        lAlertView=[[UIAlertView alloc]initWithTitle:@"错误" message:@"请求数据不完整!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
        [lAlertView show];
        return  nil;
    }
    else if(ErrorJudge==2)
    {
        lAlertView=[[UIAlertView alloc]initWithTitle:@"错误" message:@"请求数据格式错误!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
        [lAlertView show];
        return  nil;
    }
    else if(ErrorJudge==3)
    {
        
        return  nil;
    }
    else if(ErrorJudge==98)
    {
        lAlertView=[[UIAlertView alloc]initWithTitle:@"错误" message:@"数据库查找数据不存在!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
        [lAlertView show];
        return  nil;
    }
    else if(ErrorJudge==99)
    {
        lAlertView=[[UIAlertView alloc]initWithTitle:@"错误" message:@"数据库操作失败!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
        [lAlertView show];
        return  nil;
    }
    else
    {   NSDictionary *msgDictionary = [lDictionary objectForKey:@"msg"];
        NSMutableArray *BuyCarAllGoodsArrayx= [msgDictionary objectForKey:@"info"];
        return BuyCarAllGoodsArrayx;
        
    }
    
}


-(void)ChangeButtonBackColor:(UIButton *)sender
{
    [GoPayButton setBackgroundColor:[UIColor blueColor]];
    GoPayButton.alpha=0.5;
}
-(void)PayClick:(UIButton *)sender
{
    [GoPayButton setBackgroundColor:[UIColor redColor]];
    GoPayButton.alpha=1;
}

-(void)KipLogin:(UIButton *)sender
{
    [loginButton setBackgroundColor:[UIColor blueColor]];
    loginButton.alpha=0.5;
}
-(void)KipLoginAnimation:(UIButton *)sender
{
    [loginButton setBackgroundColor:[UIColor redColor]];
    loginButton.alpha=1;
    JD_UserLogin *loginView=[[JD_UserLogin alloc]init];
    [self.navigationController pushViewController:loginView animated:YES];
    [loginView release];
}

//删除购物车
-(void)deleteByOptionGoods:(UIButton *)sender
{
    //http://127.0.0.1/shop/deletecart.php
    
    
    
    /*NSURL *lURL = [NSURL URLWithString:@"http://192.168.1.138/shop/deletecart.php"];
     ASIFormDataRequest *lRequest = [ASIFormDataRequest requestWithURL:lURL];
     [lRequest setPostValue:CustomerId forKey:@"customerid"];
     [lRequest startSynchronous];*/
    
    
}

-(void)SkipBuyGoodsPageClick:(UIButton *)sender
{
    JD_Home_Page *lHomeView=[[JD_Home_Page alloc]init];
    [self.navigationController pushViewController:lHomeView animated:YES];
    [lHomeView release];
    
}

-(CGColorRef) getColorFromRed:(int)red Green:(int)green Blue:(int)blue Alpha:(int)alpha
{
    CGFloat r = (CGFloat) red/255.0;
    CGFloat g = (CGFloat) green/255.0;
    CGFloat b = (CGFloat) blue/255.0;
    CGFloat a = (CGFloat) alpha/255.0;
    CGFloat components[4] = {r,g,b,a};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef color = (CGColorRef)[(id)CGColorCreate(colorSpace, components) autorelease];
    CGColorSpaceRelease(colorSpace);
    return color;
}




-(void )changeImage:(UIButton *)sender
{
    
    for (int i=0; i<[lTablViewCellImageButton count]; i++) {
        NSDictionary *item=[lTablViewCellImageButton objectAtIndex:i];
        UIButton *lButton=[item objectForKey:@"Button"];
        if (lButton==(UIButton *)sender) {
            if ([[item objectForKey:@"Sgin"]intValue]==1) {
                
                [lButton setImage:[UIImage imageNamed:@"round_check1@2x"] forState:UIControlStateNormal];
                NSMutableDictionary *mutableItem = [NSMutableDictionary dictionaryWithDictionary:item];
                [mutableItem setObject:@"0" forKey:@"Sgin"];
                [lTablViewCellImageButton setObject: mutableItem atIndexedSubscript:i];
                
                int count=[[mutableItem objectForKey:@"count"]intValue];
                int price=[[mutableItem objectForKey:@"price"]floatValue];
                PayTotal=PayTotal-(count*price);
                TotalLabel.text=[NSString stringWithFormat:@"%@%f",@"总额:¥",PayTotal];
                
            }
            else
            {
                [lButton setImage:[UIImage imageNamed:@"round_check2@2x"] forState:UIControlStateNormal];
                NSMutableDictionary *mutableItem = [NSMutableDictionary dictionaryWithDictionary:item];
                [mutableItem setObject:@"1" forKey:@"Sgin"];
                [lTablViewCellImageButton setObject: mutableItem atIndexedSubscript:i];
                int count=[[mutableItem objectForKey:@"count"]intValue];
                int price=[[mutableItem objectForKey:@"price"]floatValue];
                PayTotal=PayTotal+(count*price);
                TotalLabel.text=[NSString stringWithFormat:@"%@%f",@"总额:¥",PayTotal];
                
            }
        }
        
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellID=@"Cell";
    UITableViewCell *Cell = [tableView cellForRowAtIndexPath:indexPath];
    if (Cell==nil) {
        Cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID] autorelease];
    }
    NSArray *lArray=[self  LoadAllGoods:@"20"];
    NSInteger Row=[indexPath row];
    NSDictionary *lDictionary=[lArray objectAtIndex:Row];
    UIButton *lButton=[[UIButton alloc]initWithFrame:CGRectMake(5, 80/2-13, 30, 26)];
    [lButton setImage:[UIImage imageNamed:@"round_check2@2x"] forState:UIControlStateNormal];
    [lButton addTarget:self action:@selector(changeImage:) forControlEvents:UIControlEventTouchUpInside];
    [Cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    NSString *SelectSgin=@"1";
    NSDictionary *GroupDictionary=[NSDictionary dictionaryWithObjectsAndKeys:lButton,@"Button",SelectSgin,@"Sgin",[lDictionary objectForKey:@"price"],@"price",[lDictionary objectForKey:@"goodscount"],@"count", nil];
    [lTablViewCellImageButton addObject: GroupDictionary];
    [Cell addSubview:lButton];
    UIImageView *lImageView=[[UIImageView alloc]initWithFrame:CGRectMake(40, 10, 60, 60)];
    lImage=[[UIImage alloc]init];
    Request=[[ASIHTTPRequest alloc]init];
    NSString  *UrlPathCreat=[NSString stringWithFormat:@"%@%@",@"http://192.168.1.138/shop/goodsimage/",[lDictionary objectForKey:@"headerimage"]];
    NSURL *url=[NSURL URLWithString:UrlPathCreat];
    Request=[ASIHTTPRequest requestWithURL:url];
    [Request startSynchronous];
    lImage=[UIImage imageWithData:[Request responseData]];
    [lImageView setImage:lImage];
    [Cell addSubview:lImageView];
    NSString *str=[lDictionary objectForKey:@"name"];
    CGSize labelSize = [str sizeWithFont:[UIFont systemFontOfSize:10]
                       constrainedToSize:CGSizeMake(200, 30)
                           lineBreakMode:NSLineBreakByWordWrapping];   // str是要显示的字符串
    UILabel *patternLabel = [[UILabel alloc] initWithFrame:CGRectMake(105, 5, labelSize.width, labelSize.height)];
    patternLabel.text = str;
    patternLabel.font = [UIFont systemFontOfSize:10];
    patternLabel.numberOfLines = 0;     // 不可少Label属性之一
    patternLabel.lineBreakMode = NSLineBreakByWordWrapping;    // 不可少Label属性之二
    [Cell addSubview:patternLabel];
    UILabel *lSerialCode=[[UILabel alloc]initWithFrame:CGRectMake(105, 45, 100, 13)];
    NSString *Strt= [NSString stringWithFormat:@"%@%@",@"编号:",[lDictionary objectForKey:@"goodsid"]];
    [lSerialCode setTextColor:[UIColor grayColor]];
    [lSerialCode setText:Strt];
    lSerialCode.font=[UIFont systemFontOfSize:13];
    [Cell addSubview:lSerialCode];
    UILabel *lCount=[[UILabel alloc]initWithFrame:CGRectMake(105, 62, 30, 13)];
    [lCount setTextColor:[UIColor grayColor]];
    [lCount setText:@"数量:"];
    [lCount setFont:[UIFont systemFontOfSize:13]];
    [Cell addSubview:lCount];
    
    
    UITextField *lCountText=[[UITextField alloc]initWithFrame:CGRectMake(138, 60, 70, 18)];
    [lCountText setBorderStyle:UITextBorderStyleLine];
    [lCountText setFont:[UIFont systemFontOfSize:10]];
    [lCountText   setTextColor:[UIColor blackColor]];
    [lCountText setText:[lDictionary objectForKey:@"goodscount"]];
    [Cell addSubview:lCountText];
    
    
    NSString *Price=[NSString stringWithFormat:@"%@%@",@"¥",[lDictionary objectForKey:@"price"]];
    UILabel *SingleGoodsTotal=[[UILabel alloc]initWithFrame:CGRectMake(215,62,100,15)];
    [SingleGoodsTotal setTextColor:[UIColor redColor]];
    [SingleGoodsTotal setFont:[UIFont systemFontOfSize:10]];
    [SingleGoodsTotal setText:Price];
    [Cell addSubview:SingleGoodsTotal];
    [SingleGoodsTotal release];
    [lCountText release];
    [lCount release];
    [patternLabel release];
    [lButton release];
    [lImageView release];
    [lSerialCode release];
    
    return Cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *lArray=[self  LoadAllGoods:@"20"];
    return  [lArray count];
    
}


//应付总额
-(NSString *)initAllPayTotal
{
    CGFloat total=0;
    NSArray *lArray=[self  LoadAllGoods:@"20"];
    for (int i=0; i<[lArray count]; i++) {
        NSDictionary *lDictionary=[lArray objectAtIndex:i];
        int  count=[[lDictionary objectForKey:@"goodscount"]intValue];
        CGFloat  singleTotal=[[lDictionary objectForKey:@"price"]floatValue];
        singleTotal=singleTotal*count;
        total=total+singleTotal;
    }
    
    PayTotal=total;
    NSString *TotalStr=[NSString stringWithFormat:@"%@%f",@"总额:¥",total];
    return TotalStr;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    TotalLabel=[[UILabel alloc]init];
    lTablViewCellImageButton=[[NSMutableArray alloc]init];
    NSArray *lArray=[self  LoadAllGoods:@"20"];
    self.tabBarController.navigationItem.title = @"购物车";
    for (UIView *subView in self.view.subviews ) {
        [subView removeFromSuperview];
    }
    [JD_DataManager shareGoodsDataManager].userID=@"20";
    if ([JD_DataManager shareGoodsDataManager].userID.length>0) {
        
        if ([lArray count]>0) {
            self.tabBarController.navigationItem.leftBarButtonItems=nil;
            self.tabBarController.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"删除" style:UIBarButtonItemStyleBordered target:self action:@selector(deleteByOptionGoods:)];
            self.tabBarController.navigationItem.rightBarButtonItem.tintColor=[UIColor redColor];
            UITableView    *lTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 5, 320, self.view.frame.size.height-90)];
            lTableView.layer.cornerRadius=5;
            lTableView.dataSource=self;
            lTableView.delegate=self;
            [self.view addSubview:lTableView];
            UIView *GotoPayView=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-80, 320, 80)];
            GotoPayView.layer.borderColor=[self getColorFromRed:0 Green:0 Blue:0 Alpha:50];
            GotoPayView.layer.borderWidth=3;
            [GotoPayView setBackgroundColor:[UIColor lightGrayColor]];
            
            
            TotalLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, GotoPayView.frame.size.height/2-10, 200, 20)];
            TotalLabel.backgroundColor=[UIColor clearColor];
            TotalLabel.text=[self initAllPayTotal];
            
            
            
            
            GoPayButton=[[UIButton alloc]initWithFrame:CGRectMake(200, 15, 100, 50)];
            [GoPayButton addTarget:self action:@selector(PayClick:) forControlEvents:UIControlEventTouchUpInside];
            [GoPayButton addTarget:self action:@selector(ChangeButtonBackColor:) forControlEvents:UIControlEventTouchDown];
            
            [GoPayButton setTitle:@"去结算" forState:UIControlStateNormal];
            [GoPayButton setBackgroundColor:[UIColor redColor]];
            GoPayButton.layer.cornerRadius=5;
            [GotoPayView addSubview:GoPayButton];
            [GotoPayView addSubview:TotalLabel];
            
            
            [self.view addSubview:GotoPayView];
            [GotoPayView release];
            [GoPayButton release];
            [lTableView release];
            
            
        }
        else
        {
            
            [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"self"]]];
            UIImageView *lImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-29,80, 58, 58)];
            [lImageView setImage:[UIImage imageNamed:@"ico_menu_shopcart@2x"]];
            UILabel *lLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-70, 150, 200, 15)];
            [lLabel setText:@"购物车还是空的,去逛逛吧!"];
            [lLabel setTextColor:[UIColor grayColor]];
            [lLabel  setBackgroundColor:[UIColor clearColor]];
            [lLabel setFont:[UIFont systemFontOfSize:13]];
            UIButton *lButton=[[UIButton alloc]init];
            [lButton  setFrame:CGRectMake(self.view.frame.size.width/2-40, 185, 90, 25)];
            [lButton setTitle:@"现在去逛逛" forState:UIControlStateNormal];
            [lButton setFont:[UIFont systemFontOfSize:14]];
            [lButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            lButton.layer.cornerRadius=3;
            [lButton setBackgroundColor:[UIColor lightGrayColor]];
            [lButton addTarget:self
                        action:@selector(SkipBuyGoodsPageClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:lImageView];
            [self.view  addSubview:lLabel];
            [self.view addSubview:lButton];
            [lImageView release];
            [lLabel release];
            [lButton release];
        }
        
    }
    else
    {
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 320,50)];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setFont:[UIFont systemFontOfSize:19]];
        [label setText:@"温馨提示: 你未登陆，请登陆用户"];
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(20, 23, 320, 50)];
        [label1 setText:@"后查看。"];
        [label setTextColor:[UIColor grayColor]];
        [label1 setTextColor:[UIColor grayColor]];
        [self.view addSubview:label1];
        [self.view addSubview:label];
        [label release];    [label1 release];
        UIView *lView=[[UIView alloc]initWithFrame:CGRectMake(0, 70, 320, self.view.frame.size.height-70)];
        [lView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"self.png"]]];
        lView.layer.borderColor=[self getColorFromRed:0 Green:0 Blue:0 Alpha:50];
        lView.layer.borderWidth=3;
        loginButton=[[UIButton alloc]initWithFrame:CGRectMake(lView.frame.size.width/2-50, lView.frame.size.height/2-25, 100, 50)];
        [loginButton setBackgroundColor:[UIColor redColor]];
        [loginButton setTitle:@"登 陆" forState:UIControlStateNormal];
        loginButton.layer.cornerRadius=5;
        [loginButton addTarget:self action:@selector(KipLogin:) forControlEvents:UIControlEventTouchDown];
        [loginButton addTarget:self action:@selector(KipLoginAnimation:) forControlEvents:UIControlEventTouchUpInside];
        [lView addSubview:loginButton];
        [self.view addSubview:lView];
        [lView release];
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

-(void)dealloc
{
    [TotalLabel release];
    [Request  release];
    [lImage release];
    [lTablViewCellImageButton release];
    [loginButton release];
    // [_BuyCarAllGoodsArray release];
    [lAlertView release];
    [GoPayButton release];
    
    [super dealloc];
}

@end
