//
//  JD_ShopCar.m
//  京东商城
//
//  Created by TY on 14-1-3.
//  Copyright (c) 2014年 张闽. All rights reserved.
//

#import "JD_ShopCar.h"
#import  "JD_Login.h"
#import "JD_Home_Page.h"
#import "JD_Order.h"
#import "JD_Search.h"
#import "JD_ShopCar.h"
#import "JD_AccountManage.h"
#import "JD_Goods.h"
@interface JD_ShopCar ()

@end

@implementation JD_ShopCar

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabBar_item2_1@2x" ofType:@"png"]];
//        lData=[[NSMutableData alloc]init];
        
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
/*(-(NSMutableArray *)LoadAllGoods:(NSString *)CustomerId
{
    ShareDictionary=[[NSDictionary alloc]init];
         return ReturnArray;
    [ReturnArray release];
   
    
         
}*/






 
-(void)ChangeButtonBackColor:(UIButton *)sender
{
    [GoPayButton setBackgroundColor:[UIColor blueColor]];
    GoPayButton.alpha=0.5;
}
-(void)PayClick:(UIButton *)sender
{
    int  bySelectPayGoodsCount=0;
    for (int i=0; i<[[JD_DataManager shareGoodsDataManager].BuyCardInfoArray count]; i++) {
        if ([[[[JD_DataManager shareGoodsDataManager].BuyCardInfoArray objectAtIndex:i] objectForKey:@"sgin"]intValue]==1) {
            bySelectPayGoodsCount++;
            break;
        }
    }
    if (bySelectPayGoodsCount>0) {
        [GoPayButton setBackgroundColor:[UIColor redColor]];
        GoPayButton.alpha=1;
        Sgin=1;
        NSURL *URL=[NSURL URLWithString:@"http://192.168.1.120/shop/getaddress.php"];
        NSString *PostData=[NSString stringWithFormat:@"customerid=%@",[JD_DataManager shareGoodsDataManager].userID];
        NSMutableURLRequest *lRequest=[NSMutableURLRequest requestWithURL:URL];
        [lRequest setHTTPMethod:@"post"];
        [lRequest setHTTPBody:
         [PostData dataUsingEncoding:NSUTF8StringEncoding]];
        NSURLConnection *connection=[NSURLConnection connectionWithRequest:lRequest delegate:self];
        [connection start];
    }else
    {
        UIAlertView *AlertView=[[UIAlertView alloc]initWithTitle:@"错误" message:@"请选中需要提交的商品" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
        [AlertView show];
        [AlertView release];
    }
   
   
    
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
    JD_Login *loginView=[[JD_Login alloc]init];
    [self.navigationController pushViewController:loginView animated:YES];
    [loginView release];
}


 
//修改对应商品Count
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return  YES;
}


-(void)hiddenView:(UIButton *)sender
{
    [SkipLayer removeFromSuperview];
    [FunctionLayer removeFromSuperview];
    self.navigationController.navigationBar.alpha=1;
    for (int i=0; i<[JD_DataManager shareGoodsDataManager].BuyCardInfoArray.count; i++) {
        NSDictionary *FirstDictionary=[[JD_DataManager shareGoodsDataManager].BuyCardInfoArray objectAtIndex:i];
        if (bySelectKeyBoard==(UITextField *)[FirstDictionary objectForKey:@"text"]) {
            NSMutableDictionary *lDictionary= [NSMutableDictionary dictionaryWithDictionary:[FirstDictionary objectForKey:@"dictionary"]];
            if ([[FirstDictionary objectForKey:@"sgin"]intValue]==1) {
                float Price=[[lDictionary objectForKey:@"price"]floatValue];
                int Count=[[lDictionary objectForKey:@"goodscount"]intValue];
                PayTotal=PayTotal-(Price*Count);
                int ChangeCount=[UpdateBySelectKeyBoard.text intValue];
                PayTotal=PayTotal+(Price*ChangeCount);
                [TotalLabel  setText:[NSString stringWithFormat:@"%@%f",@"总额:¥",PayTotal]];
            }
            [lDictionary setObject:UpdateBySelectKeyBoard.text forKey:@"goodscount"];
            NSMutableDictionary *mutableItem = [NSMutableDictionary dictionaryWithDictionary:FirstDictionary];
            [mutableItem setObject:lDictionary forKey:@"dictionary"];
            [[JD_DataManager shareGoodsDataManager].BuyCardInfoArray setObject: mutableItem atIndexedSubscript:i];
            
            NSURL *URL=[NSURL URLWithString:@"http://192.168.1.120/shop/changecart.php"];
            NSString *cartid=[lDictionary objectForKey:@"cartid"];
            NSString *goodscount=[lDictionary objectForKey:@"goodscount"];
            NSString *goodsid=[lDictionary objectForKey:@"goodsid"];
           
           
            NSString *lPostData=[NSString stringWithFormat:@"cartid=%@&goodscount=%@&goodsid=%@&customerid=%@",cartid,goodscount,goodsid,[JD_DataManager shareGoodsDataManager].userID];
          //  NSLog(@"%@",lPostData);
            NSMutableURLRequest *lRequest=[NSMutableURLRequest requestWithURL:URL];
             [lRequest setHTTPMethod:@"post"];
            [lRequest setHTTPBody: [lPostData dataUsingEncoding:NSUTF8StringEncoding]];
            NSURLConnection *lConnection=[NSURLConnection connectionWithRequest:lRequest delegate:self];
            [lConnection start];
            break;
        }
    }
         
        [lTableView reloadData];
 
}

-(void)subtractionCount:(UIButton *)sender
{
    if ([UpdateBySelectKeyBoard.text intValue]>0) {
            UpdateBySelectKeyBoard.text=[NSString stringWithFormat:@"%i",[UpdateBySelectKeyBoard.text intValue]-1];
    }
 
}
-(void)addCount:(UIButton *)sender
{
    UpdateBySelectKeyBoard.text=[NSString stringWithFormat:@"%i",[UpdateBySelectKeyBoard.text intValue]+1];
      
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
     
    if (textField.tag!=10010) {
        bySelectKeyBoard=[[UITextField alloc]init];
        bySelectKeyBoard=textField;
        
         SkipLayer=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-167)];
        [SkipLayer setBackgroundColor:[UIColor blackColor]];
        self.navigationController.navigationBar.alpha=0.7;
        SkipLayer.alpha=0.7;
        
        FunctionLayer=[[UIView alloc]initWithFrame:CGRectMake(10, 30, 300, 150)];
        FunctionLayer.layer.cornerRadius=5;
        [FunctionLayer setBackgroundColor:[UIColor whiteColor]];
        
        UILabel  *lable=[[UILabel alloc]initWithFrame:CGRectMake(5, 20, 100, 15)];
        [lable setText:@"修改数量:"];
        [lable setBackgroundColor:[UIColor clearColor]];
        
        [lable setFont:[UIFont systemFontOfSize:15]];
        [FunctionLayer addSubview:lable];
        
        UIButton *lButton=[[UIButton alloc]initWithFrame:CGRectMake(277,3 , 20, 20)];
        [lButton setTitle:@"x" forState:UIControlStateNormal];
        [lButton setTintColor:[UIColor whiteColor]];
        [lButton setBackgroundColor:[UIColor blackColor]];
        lButton.layer.cornerRadius=10;
        [lButton addTarget:self
                    action:@selector(hiddenView:) forControlEvents:UIControlEventTouchUpInside];
        [FunctionLayer addSubview:lButton];
        
        
        
        UIButton *lsubtractionButton=[[UIButton alloc]initWithFrame:CGRectMake(80, 70, 20, 20)];
        [lsubtractionButton setTitle:@"-" forState:UIControlStateNormal];
        [lsubtractionButton addTarget:self action:@selector(subtractionCount:) forControlEvents:UIControlEventTouchUpInside];
        
        lsubtractionButton.layer.cornerRadius=10;
        [lsubtractionButton setTintColor:[UIColor whiteColor]];
        [lsubtractionButton setBackgroundColor:[UIColor blackColor]];
        [FunctionLayer addSubview:lsubtractionButton];
        
 
        [UpdateBySelectKeyBoard  setFrame:CGRectMake(105, 66, 90, 30)];
        [UpdateBySelectKeyBoard setFont:[UIFont systemFontOfSize:20]];
        [UpdateBySelectKeyBoard setSelected:YES];
        //[UpdateBySelectKeyBoard becomeFirstResponder];
        [UpdateBySelectKeyBoard setKeyboardType:UIKeyboardTypeNumberPad];
        [UpdateBySelectKeyBoard setBorderStyle:UITextBorderStyleLine];
        [UpdateBySelectKeyBoard setText:textField.text];
        UpdateBySelectKeyBoard.delegate=self;
        [FunctionLayer addSubview:UpdateBySelectKeyBoard];
        
        UIButton *laddButton=[[UIButton alloc]initWithFrame:CGRectMake(200, 70, 20, 20)];
        [laddButton setTitle:@"+" forState:UIControlStateNormal];
        [laddButton addTarget:self action:@selector(addCount:) forControlEvents:UIControlEventTouchUpInside];
        laddButton.layer.cornerRadius=10;
        [laddButton setTintColor:[UIColor whiteColor]];
        [laddButton setBackgroundColor:[UIColor blackColor]];
        [FunctionLayer addSubview:laddButton];
        
        
        
        [self.view addSubview:SkipLayer];
        [self.view addSubview:FunctionLayer];
    
        [laddButton release];
        [lsubtractionButton release];
        [lButton release];
        [lable release];
    }
       
     
   
   

}

 

//删除购物车
-(void)deleteByOptionGoods:(UIButton *)sender
{
     NSMutableArray  *DeletelTempArray=[[NSMutableArray alloc]initWithArray:[JD_DataManager shareGoodsDataManager].BuyCardInfoArray];
    float subtraction=0.000;
    for (int i=0; i<[DeletelTempArray count]; i++) {
         NSDictionary *FirstDictionary=[DeletelTempArray objectAtIndex:i];
         NSDictionary *lDictionary=[FirstDictionary objectForKey:@"dictionary"];
         NSString *byOptionState=[FirstDictionary objectForKey:@"sgin"];
         NSString *CartId=[lDictionary objectForKey:@"cartid"];
        
        
        
        
        
        
        
        NSString *UserId=[JD_DataManager shareGoodsDataManager].userID;
         if ([byOptionState intValue]==1) {
             int count=[[lDictionary objectForKey:@"goodscount"]intValue];
             float price=[[lDictionary objectForKey:@"price"]floatValue];
             subtraction=subtraction+(count*price);
             
             NSURL *lURL=[NSURL URLWithString:@"http://192.168.1.120/shop/deletecart.php"];
             NSString *userInfo=[NSString stringWithFormat:@"cartid=%@&customerid=%@",CartId,UserId];
             NSMutableURLRequest *lRequest=[NSMutableURLRequest requestWithURL:lURL];
             [lRequest setHTTPMethod:@"post"];
             [lRequest setHTTPBody:[userInfo dataUsingEncoding:NSUTF8StringEncoding]];
             NSURLConnection *lConnection=[NSURLConnection connectionWithRequest:lRequest delegate:self];
             [lConnection start];
             [[JD_DataManager shareGoodsDataManager].BuyCardInfoArray removeObject:FirstDictionary];
         }
     }
    PayTotal=PayTotal-subtraction;
     TotalLabel.text=[NSString stringWithFormat:@"%@%f",@"总额:¥",PayTotal];
    [lTableView reloadData];
    [DeletelTempArray release];
   
}

 
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [lData setLength:0];
}

 
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [lData appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (Sgin==1) {
       
       NSDictionary *lDictionary=[[NSJSONSerialization JSONObjectWithData: lData options:NSJSONReadingAllowFragments error:nil] objectForKey:@"msg"];
        int Count= [[lDictionary objectForKey:@"count"]intValue];
        if (Count>0) {
            [JD_DataManager shareGoodsDataManager].AddressArray=[[NSMutableArray  alloc]initWithArray:[lDictionary objectForKey:@"info"]];
            for (int i=0; i<Count;i++) {
                 byOptionAdress=[[UIButton alloc]init];
                
                NSDictionary *singleAdress=[[JD_DataManager shareGoodsDataManager].AddressArray objectAtIndex:i];
                NSMutableDictionary *lUpdateDictionary=[NSMutableDictionary dictionaryWithObjectsAndKeys:singleAdress,@"dictionary",byOptionAdress,@"button", nil];
                 [[JD_DataManager shareGoodsDataManager].AddressArray replaceObjectAtIndex:i withObject:lUpdateDictionary];
            }
        Sgin=0;
       
         
        }
        JD_Order *order=[[JD_Order alloc]init];
        [self.navigationController pushViewController:order animated:YES];
        [order release];
    }
}

-(void)SkipBuyGoodsPageClick:(UIButton *)sender
{
    JD_Home_Page *lHome_Page = [[[JD_Home_Page alloc]init]autorelease];
    JD_Search *lJD_Search = [[[JD_Search alloc]init]autorelease];
    JD_ShopCar *lJD_ShopCar = [[[JD_ShopCar alloc]init]autorelease];
    JD_AccountManage *lJD_AccountManage = [[[JD_AccountManage alloc]init]autorelease];
    UITabBarController *lTabBarController = [[[UITabBarController alloc]init]autorelease];
    lTabBarController.viewControllers = @[lHome_Page,lJD_Search,lJD_ShopCar,lJD_AccountManage];
    UINavigationController *lNavigation = [[[UINavigationController alloc]initWithRootViewController:lTabBarController]autorelease];
    [self presentViewController:lNavigation animated:YES completion:nil];

    
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




-(void )updateGoodsOptionState:(UIButton *)sender
{
    
    for (int i=0; i<[[JD_DataManager shareGoodsDataManager].BuyCardInfoArray count]; i++) {
        NSDictionary *FirstDictionary=[[JD_DataManager shareGoodsDataManager].BuyCardInfoArray objectAtIndex:i];
         NSDictionary *item=[FirstDictionary objectForKey:@"dictionary"];
        UIButton *lButton=(UIButton *)[FirstDictionary objectForKey:@"button"];
        int  Sgin1=[[FirstDictionary objectForKey:@"sgin"]intValue];
        if (lButton ==(UIButton *)sender) {
            if (Sgin1==1) {
                
                [lButton setImage:[UIImage imageNamed:@"round_check1@2x"] forState:UIControlStateNormal];
                NSMutableDictionary *mutableItem = [NSMutableDictionary dictionaryWithDictionary:FirstDictionary];
                [mutableItem setObject:@"0" forKey:@"sgin"];
                [[JD_DataManager shareGoodsDataManager].BuyCardInfoArray setObject: mutableItem atIndexedSubscript:i];
                int count=[[item objectForKey:@"goodscount"]intValue];
                int price=[[item objectForKey:@"price"]floatValue];
                PayTotal=PayTotal-(count*price);
                TotalLabel.text=[NSString stringWithFormat:@"%@%.2f",@"总额:¥",PayTotal];
                
            }
            else
            {
                [lButton setImage:[UIImage imageNamed:@"round_check2@2x"] forState:UIControlStateNormal];
                NSMutableDictionary *mutableItem = [NSMutableDictionary dictionaryWithDictionary:FirstDictionary];
                [mutableItem setObject:@"1" forKey:@"sgin"];
                [[JD_DataManager shareGoodsDataManager].BuyCardInfoArray setObject: mutableItem atIndexedSubscript:i];
                int count=[[item objectForKey:@"goodscount"]intValue];
                int price=[[item objectForKey:@"price"]floatValue];
                PayTotal=PayTotal+(count*price);
                TotalLabel.text=[NSString stringWithFormat:@"%@%.2f",@"总额:¥",PayTotal];
                
            }
        }
        
    }
 

 
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row=[indexPath row];
    NSDictionary *dictionary=[[JD_DataManager shareGoodsDataManager].BuyCardInfoArray objectAtIndex:row];
    [JD_DataManager shareGoodsDataManager].goodsID =[[dictionary objectForKey:@"dictionary"] objectForKey:@"goodsid"];
    JD_Goods *lGoods=[[JD_Goods alloc]init];
    [self.navigationController pushViewController:lGoods animated:YES];
    [lGoods release]; 
          

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellID=@"Cell";
    UITableViewCell *Cell = [tableView cellForRowAtIndexPath:indexPath];
    if (Cell==nil) {
        Cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID] autorelease];
    }
    
    NSInteger Row=[indexPath row];
    if ([[JD_DataManager shareGoodsDataManager].BuyCardInfoArray count]>0) {
        NSDictionary *lFirstDictionary=[[JD_DataManager shareGoodsDataManager].BuyCardInfoArray objectAtIndex:Row];
        NSDictionary *lDictionary=[lFirstDictionary objectForKey:@"dictionary"];
        
        
        
        UIButton *lButton=(UIButton *)[lFirstDictionary objectForKey:@"button"];
        if ([[lFirstDictionary objectForKey:@"sgin"]intValue]==1) {
            [lButton setImage:[UIImage imageNamed:@"round_check2@2x"] forState:UIControlStateNormal];
        }
        else
        {
            [lButton setImage:[UIImage imageNamed:@"round_check1@2x"] forState:UIControlStateNormal];
        }
        
        [Cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [Cell addSubview:lButton];
        UIImageView *lImageView=[[UIImageView alloc]initWithFrame:CGRectMake(40, 10, 60, 60)];
        lImage=[[UIImage alloc]init];
        Request=[[ASIHTTPRequest alloc]init];
        NSString  *UrlPathCreat=[NSString stringWithFormat:@"%@%@",@"http://192.168.1.120/shop/goodsimage/",[lDictionary objectForKey:@"headerimage"]];
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
        patternLabel.numberOfLines = 0;      
        patternLabel.lineBreakMode = NSLineBreakByWordWrapping;   
        [Cell addSubview:patternLabel];
        UILabel *lSerialCode=[[UILabel alloc]initWithFrame:CGRectMake(105, 45, 100, 13)];
        NSString *Strt= [NSString stringWithFormat:@"%@%@",@"编号:",[lDictionary objectForKey:@"cartid"]];
        [lSerialCode setTextColor:[UIColor grayColor]];
        [lSerialCode setText:Strt];
        lSerialCode.font=[UIFont systemFontOfSize:13];
        [Cell addSubview:lSerialCode];
        UILabel *lCount=[[UILabel alloc]initWithFrame:CGRectMake(105, 62, 30, 13)];
        [lCount setTextColor:[UIColor grayColor]];
        [lCount setText:@"数量:"];
        [lCount setFont:[UIFont systemFontOfSize:13]];
        [Cell addSubview:lCount];
        
        
        
        
        UITextField *TextField=(UITextField *)[lFirstDictionary objectForKey:@"text"];
        [TextField setKeyboardType:UIKeyboardTypeNumberPad];
        [TextField setBorderStyle:UITextBorderStyleLine];
        [TextField setFont:[UIFont systemFontOfSize:10]];
        [TextField   setTextColor:[UIColor blackColor]];
        [TextField setText:[lDictionary objectForKey:@"goodscount"]];
        [Cell addSubview:TextField];
        
        
        
        
        NSString *Price=[NSString stringWithFormat:@"%@%@",@"¥",[lDictionary objectForKey:@"price"]];
        UILabel *SingleGoodsTotal=[[UILabel alloc]initWithFrame:CGRectMake(215,62,100,15)];
        [SingleGoodsTotal setTextColor:[UIColor redColor]];
        [SingleGoodsTotal setFont:[UIFont systemFontOfSize:10]];
        [SingleGoodsTotal setText:Price];
        [Cell addSubview:SingleGoodsTotal];
        [SingleGoodsTotal release];
        
        [lCount release];
        [patternLabel release];
        [lImageView release];
        [lSerialCode release];
    }
    
    
    return Cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return  [[JD_DataManager shareGoodsDataManager].BuyCardInfoArray count];

}


//应付总额
-(NSString *)initAllPayTotal
{
    CGFloat total=0;
  
    for (int i=0; i<[[JD_DataManager shareGoodsDataManager].BuyCardInfoArray count]; i++) {
        NSDictionary *FirstDictionary=[[JD_DataManager shareGoodsDataManager].BuyCardInfoArray objectAtIndex:i];
        NSDictionary *lDictionary=[FirstDictionary objectForKey:@"dictionary"];
        int  count=[[lDictionary objectForKey:@"goodscount"]intValue];
        CGFloat  singleTotal=[[lDictionary objectForKey:@"price"]floatValue];
        singleTotal=singleTotal*count;
        total=total+singleTotal;
    }
    
    PayTotal=total;
    NSString *TotalStr=[NSString stringWithFormat:@"%@%.2f",@"总额:¥",total];
    return TotalStr;
}


-(void)viewWillAppear:(BOOL)animated{
    [[JD_DataManager shareGoodsDataManager].BuyCardInfoArray removeAllObjects];
    [super viewWillAppear:animated];
  lImage=[[UIImage alloc]init];
    TotalLabel=[[UILabel alloc]init];
    lTablViewCellImageButton=[[NSMutableArray alloc]init];
    lData=[[NSMutableData alloc]init];
     UpdateBySelectKeyBoard=[[UITextField alloc]init];
     UpdateBySelectKeyBoard.tag=10010;
    
    
    self.tabBarController.navigationItem.title = @"购物车";
    for (UIView *subView in self.view.subviews ) {
        [subView removeFromSuperview];
    }
   
    
    if ([JD_DataManager shareGoodsDataManager].UserState==YES) {
        
      
        NSString *bodyString=[NSString stringWithFormat:@"customerid=%@",[JD_DataManager shareGoodsDataManager].userID];
        [[JD_DataManager shareGoodsDataManager] downloadDataWithHTTPMethod:@"post" WithBodyString:bodyString WithURLString:@"getcart.php" AndSuccess:^(NSData *data){
            
            NSDictionary *ShareDictionary= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            
            int ErrorJudge= [[ShareDictionary objectForKey:@"error"]intValue];
            
            if (ErrorJudge==1) {
                lAlertView=[[UIAlertView alloc]initWithTitle:@"错误" message:@"请求数据不完整!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
                [lAlertView show];
                
            }
            else if(ErrorJudge==2)
            {
                lAlertView=[[UIAlertView alloc]initWithTitle:@"错误" message:@"请求数据格式错误!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
                [lAlertView show];
                
            }
            else if(ErrorJudge==3)
            {
                
                
            }
            else if(ErrorJudge==98)
            {
                lAlertView=[[UIAlertView alloc]initWithTitle:@"错误" message:@"数据库查找数据不存在!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
                [lAlertView show];
                
            }
            else if(ErrorJudge==99)
            {
                lAlertView=[[UIAlertView alloc]initWithTitle:@"错误" message:@"数据库操作失败!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
                [lAlertView show];
                
            }
            else
                
            {
            
               
                NSDictionary *msgDictionary = [ShareDictionary objectForKey:@"msg"];
                int Count= [[msgDictionary objectForKey:@"count"]intValue];
            
                if (Count>0) {
                    NSMutableArray *BuyCarAllGoodsArrayx= [msgDictionary objectForKey:@"info"];
                        for (int i=0; i<[BuyCarAllGoodsArrayx count]; i++) {
                            NSDictionary *lDictionary=[BuyCarAllGoodsArrayx objectAtIndex:i];
                            lOptionButton=[[UIButton alloc]initWithFrame:CGRectMake(5, 80/2-13, 30, 26)];
                            [lOptionButton addTarget:self action:@selector(updateGoodsOptionState:) forControlEvents:UIControlEventTouchUpInside];
                            
                            lCountText=[[UITextField alloc]initWithFrame:CGRectMake(138, 60, 70, 18)];
                            lCountText.delegate=self;
                            NSString *selectState=@"1";
                            
                          
                            NSDictionary *GroupDictionary=[NSDictionary dictionaryWithObjectsAndKeys:lDictionary,@"dictionary",selectState,@"sgin",lOptionButton,@"button",lCountText,@"text",nil];
                            
                              
                                 [[JD_DataManager shareGoodsDataManager].BuyCardInfoArray addObject:GroupDictionary];
                         
                           
                      }
                       self.tabBarController.navigationItem.leftBarButtonItems=nil;
                       self.tabBarController.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"删除" style:UIBarButtonItemStyleBordered target:self action:@selector(deleteByOptionGoods:)];
                       self.tabBarController.navigationItem.rightBarButtonItem.tintColor=[UIColor redColor];
                       lTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 5, 320, self.view.frame.size.height-90)];
                       lTableView.layer.cornerRadius=5;
                       lTableView.dataSource=self;
                       lTableView.delegate=self;
                       [self.view addSubview:lTableView];
                       UIView *GotoPayView=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-80, 320, 80)];
                       GotoPayView.layer.borderColor=[self getColorFromRed:0 Green:0 Blue:0 Alpha:50];
                       GotoPayView.layer.borderWidth=3;
                       [GotoPayView setBackgroundColor:[UIColor whiteColor]];
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
                 
         
                    
                }
            else
            {
                self.tabBarController.navigationItem.leftBarButtonItems=nil;
                self.tabBarController.navigationItem.leftBarButtonItem=nil;
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
                [lButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
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
         
         
         
        }AndFailed:^(){
            
        }];
        
    }
    
    
    else
    {
      
        self.tabBarController.navigationItem.leftBarButtonItems=nil;
        self.tabBarController.navigationItem.leftBarButtonItem=nil;
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
    
   [byOptionAdress release];
    [SkipLayer release];
    [FunctionLayer release];
    [UpdateBySelectKeyBoard release];
    [bySelectKeyBoard release];
    [lCountText release];
    [lTableView release];
    [lData release];
    [lOptionButton release];
    [TotalLabel release];
    
    [lImage release];
    [lTablViewCellImageButton release];
    [loginButton release];
    // [_BuyCarAllGoodsArray release];
    [lAlertView release];
    [GoPayButton release];
    
    [super dealloc];
}

@end
