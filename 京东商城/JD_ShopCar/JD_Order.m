//
//  JD_Order.m
//  京东商城
//
//  Created by TY on 14-1-16.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import "JD_Order.h"
#import "JD_AddAdress.h"
#import "AllOrderFrom.h"
@interface JD_Order ()

@end

@implementation JD_Order

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        //[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"self"]]];
        self.title=@"订单填写";
        for (int i=0; i<self.view.subviews.count; i++) {
            [[self.view.subviews objectAtIndex:i]removeFromSuperview];
        }
         
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
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



-(void)returnBuycarPage:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)shareButtonClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 1:
        {
            
            JD_AddAdress *JDAdress=[[JD_AddAdress alloc]init];
            [self.navigationController pushViewController:JDAdress animated:YES];
            [JDAdress release];
        }
            break;
        case 2:
        {
            
        }
            
            break;
        case 3:
        {
            
        }
            
            break;
        case 4:
        {
            
        }
            
            break;
        case 5:
        {
            
        }
            
            break;
        case 6:
        {
            
        }
            
            break;
        default:
            break;
    }
}

-(UIButton *)CreateButton:(CGRect)rect setTag:(NSInteger)tag
{
    UIButton *button=[[UIButton alloc]initWithFrame:rect];
    button.tag=tag;
    [button setTitle:@">" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor clearColor]];
    return button;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

 
 -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return [[JD_DataManager shareGoodsDataManager].AddressArray count];
   
    
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    static NSString *CellId=@"CllId";
      UITableViewCell *Cell = [tableView cellForRowAtIndexPath:indexPath];
    if (Cell==nil) {
        Cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId]autorelease];
       }
    NSInteger row=[indexPath row];
    if (row==0) {
        Cell.selected=YES;
        Cell.selectionStyle=UITableViewCellSelectionStyleNone;
         
    }
    NSInteger Row =[indexPath row];
    NSDictionary *lFirstDictionary=[[JD_DataManager shareGoodsDataManager].AddressArray  objectAtIndex:Row];
    NSDictionary *lCellDictionary=[lFirstDictionary objectForKey:@"dictionary"];
     
    UIButton *lButtonx=[lFirstDictionary objectForKey:@"button"];
    lButtonx.layer.cornerRadius=10;
    [lButtonx setTitle:@"√" forState:UIControlStateNormal];
    if (lButtonx.titleLabel.textColor==[UIColor blackColor]) {
       
    }
    else
    {
        [lButtonx setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [lButtonx setBackgroundColor:[UIColor grayColor]];
    }
    [lButtonx   setFrame:CGRectMake(5, 80/2-10, 20, 20)];
    [lButtonx addTarget:self action:@selector(ChangeBackgroundImage:) forControlEvents:UIControlEventTouchUpInside];
    
    
  
    UIButton *deleteButton1=[lFirstDictionary  objectForKey:@"deleteButton"];
    
    if (deleteButton1!=nil) {
        [Cell addSubview:deleteButton1];
    }
    
    UILabel *name=[[UILabel alloc]initWithFrame:CGRectMake(30, 5, 200, 20)];
    [name setFont:[UIFont  systemFontOfSize:13]];
    [name setText: [NSString stringWithFormat:@"%@%@",@"姓名:",[lCellDictionary  objectForKey:@"name"]]];  
    [name setTextColor:[UIColor blackColor]];
    [Cell addSubview:name];
    [name  release];
    
    
    UILabel *phone=[[UILabel alloc]initWithFrame:CGRectMake(30, 25, 200, 20)];
    [phone setFont:[UIFont  systemFontOfSize:13]];
    [phone setText: [NSString stringWithFormat:@"%@%@",@"电话:",[lCellDictionary  objectForKey:@"telephone"]]];
    [phone setTextColor:[UIColor blackColor]];
    [Cell addSubview:phone];
    [phone  release];

     UILabel *lAddressLabel=[[UILabel alloc]init];
    [lAddressLabel setFont:[UIFont systemFontOfSize:12]];
    NSString *Adress=[NSString stringWithFormat:@"%@%@",@"地址:",[lCellDictionary  objectForKey:@"address"]];
    if (Adress.length>19) {
        CGSize labelSize = [Adress sizeWithFont:[UIFont systemFontOfSize:12]
                           constrainedToSize:CGSizeMake(210, 30)
                               lineBreakMode:NSLineBreakByWordWrapping]; 
        [lAddressLabel   setFrame:CGRectMake(25, 46, labelSize.width, labelSize.height)];
        lAddressLabel.text = Adress;
        lAddressLabel.font = [UIFont systemFontOfSize:12];
        lAddressLabel.numberOfLines = 0;    
        lAddressLabel.lineBreakMode = NSLineBreakByWordWrapping;   

    }
    else
    {
        [lAddressLabel   setFrame:CGRectMake(25, 42, 210, 30)];
      [lAddressLabel setText:Adress];
    } 
    Cell.layer.borderWidth=1;
    Cell.layer.borderColor=[self getColorFromRed:150 Green:50 Blue:50 Alpha:12];
     
    
    [Cell addSubview:lAddressLabel];
    
     [Cell addSubview:lButtonx];
  
    
     [lAddressLabel release];
    return Cell;
   
     
}
-(void)ChangeBackgroundImage:(UIButton *)sender
{
    for (int i=0; i<[[JD_DataManager shareGoodsDataManager].AddressArray count]; i++) {
       
        UIButton *lButton=(UIButton *)[[[JD_DataManager shareGoodsDataManager].AddressArray objectAtIndex:i] objectForKey:@"button"];
        if (lButton==sender) {
           
                                               
            if (lButton.titleLabel.textColor==[UIColor blackColor]) {
                 [lButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [lButton  setBackgroundColor:[UIColor grayColor]];
               
            }
            else
            {
                 [lButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                 [lButton  setBackgroundColor:[UIColor redColor]];
                NSMutableDictionary *lDictionary =[[JD_DataManager shareGoodsDataManager].AddressArray objectAtIndex:i] ;
                
                
                NSDictionary *lLastDictionary;
                if ([lDictionary objectForKey:@"deleteButton"]==nil) {
                    NSDictionary *lCellDictionary=[lDictionary objectForKey:@"dictionary"];
                   
                   lLastDictionary=[NSDictionary dictionaryWithObjectsAndKeys:lCellDictionary,@"dictionary",lButton,@"button", nil];
                    
                }
                else
                {
                    NSDictionary *lCellDictionary=[lDictionary objectForKey:@"dictionary"];
                    UIButton  *deleteButton2=[lDictionary objectForKey:@"deleteButton"];
                    
                    lLastDictionary=[NSDictionary dictionaryWithObjectsAndKeys:lCellDictionary,@"dictionary",lButton,@"button",deleteButton2,@"deleteButton" ,nil];
                }
 

                [[JD_DataManager shareGoodsDataManager].AddressArray replaceObjectAtIndex:i withObject:lLastDictionary];
               
                
            }
            
           
        }
 else
      {
          [lButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          [lButton  setBackgroundColor:[UIColor grayColor]];
      }
    }
}
//1创建收货人  2:支付方式 3:配送方式
-(void)viewWillAppear:(BOOL)animated
{
    orderPayTotal=0;
     [lScrollView removeFromSuperview];
    for(int i=0;i<[[JD_DataManager shareGoodsDataManager].AddressArray count];i++)
    {
        NSMutableDictionary *lDictionary=[[JD_DataManager shareGoodsDataManager].AddressArray objectAtIndex:i];
        if ([lDictionary objectForKey:@"deleteButton"]==nil) {
            
        }
        else
        {
            
               
            NSDictionary *lCreateDictionary=[NSDictionary dictionaryWithObjectsAndKeys:[lDictionary objectForKey:@"dictionary"],@"dictionary",  [lDictionary objectForKey:@"button"],@"button" , nil];
            [[JD_DataManager shareGoodsDataManager].AddressArray  replaceObjectAtIndex:i withObject:lCreateDictionary];
            
        }
    }
    
    
    lData=[[NSMutableData alloc]init];
    lAdressArray=[[NSMutableArray alloc]init];
    lScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-50)];
    //[lScrollView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"self"]]];
    [lScrollView setContentSize:CGSizeMake(320, 500)];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(returnBuycarPage:)];
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor redColor];
    UIView  *lCreateReceiverView=[[UIView alloc]initWithFrame:CGRectMake(10, 5, 300, 170)];
    
    lCreateReceiverView.layer.cornerRadius=10;
     lCreateReceiverView.layer.borderWidth=1;
    lCreateReceiverView.layer.borderColor=[self getColorFromRed:0 Green:225 Blue:1 Alpha:12];
    //100 1 1 12
    //176,196,222
    lCreateReceiverView.layer.backgroundColor=[self getColorFromRed:300 Green:0 Blue:0 Alpha:25];
    shareRect=CGRectMake(275,lCreateReceiverView.frame.size.height/2-10, 20, 20);
    UIButton  *lbutton=[self CreateButton:shareRect setTag:1];
    [lCreateReceiverView addSubview:lbutton];
    int Count= [[JD_DataManager shareGoodsDataManager].AddressArray  count];
       if (Count>0) {
          self.navigationItem.rightBarButtonItem=nil;
//           self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleBordered target:self action:@selector(EditionCell:)];
//           self.navigationItem.rightBarButtonItem.tintColor=[UIColor redColor];

          
          
        lLabel=[[UILabel alloc]initWithFrame:CGRectMake(8, 15, 200, 20)];
        [lLabel setTextColor:[UIColor blackColor]];
        [lLabel setBackgroundColor:[UIColor clearColor]];
        [lLabel setFont:[UIFont systemFontOfSize:13]];
        [lCreateReceiverView addSubview:lLabel];
        [lLabel setText:@"下面是你所增加的地址"];
        lTableView=[[UITableView alloc]initWithFrame:CGRectMake(8, 35, 267, 130) style:UITableViewStylePlain];
        lTableView.layer.cornerRadius=5;
        [lTableView setContentSize:CGSizeMake(250, 2000)];
           //[lTableView.backgroundView removeFromSuperview];
        lTableView.delegate=self;
        lTableView.dataSource=self;
           [lTableView reloadData];
        [lCreateReceiverView addSubview:lTableView];
    }
    else
    {
        lLabel=[[UILabel alloc]initWithFrame:CGRectMake(8, 15, 200, 20)];
        [lLabel setTextColor:[UIColor blackColor]];
        [lLabel setBackgroundColor:[UIColor clearColor]];
        [lLabel setFont:[UIFont systemFontOfSize:13]];
        [lCreateReceiverView addSubview:lLabel];
        [lLabel setText:@"你还没有创建收货人信息"];
    }
    
     
  
         [lScrollView addSubview:lCreateReceiverView];
    
    
    UIView *PayWay=[[UIView alloc]initWithFrame:CGRectMake(10, 180, 300, 50)];
    PayWay.layer.borderWidth=1;
    PayWay.layer.borderColor=[self getColorFromRed:0 Green:225 Blue:1 Alpha:12];
    //100 1 1 12
    //176,196,222
    PayWay.layer.backgroundColor=[self getColorFromRed:300 Green:0 Blue:0 Alpha:25];
    PayWay.layer.cornerRadius=5;
    UILabel *lable1=[[UILabel alloc]initWithFrame:CGRectMake(8, PayWay.frame.size.height/2-15, 100, 30)];
    [lable1 setText:@"支付方式"];
    [lable1 setBackgroundColor:[UIColor clearColor]];
   
    [lable1 setTextColor:[UIColor blackColor]];
    [PayWay addSubview:lable1];
    UILabel *lable11=[[UILabel alloc]initWithFrame:CGRectMake(118, PayWay.frame.size.height/2-15, 100, 30)];
    [lable11 setText:@"在线支付"];
    [lable11 setBackgroundColor:[UIColor clearColor]];
    [lable11 setTextColor:[UIColor blackColor]];
    [lable11 setFont:[UIFont systemFontOfSize:15]];
    [PayWay addSubview:lable11];
    
    
    shareRect=CGRectMake(275,PayWay.frame.size.height/2-10, 20, 20);
     UIButton  *lbutton1=[self CreateButton:shareRect setTag:2];
    [PayWay addSubview:lbutton1];
    [lScrollView addSubview:PayWay];
    
    
    UIView *dispatchingView=[[UIView alloc]initWithFrame:CGRectMake(10, 235, 300, 50)];
    dispatchingView.layer.cornerRadius=5;
    dispatchingView.layer.borderWidth=1;
    dispatchingView.layer.borderColor=[self getColorFromRed:0 Green:225 Blue:1 Alpha:12];
    //100 1 1 12
    //176,196,222
    dispatchingView.layer.backgroundColor=[self getColorFromRed:300 Green:0 Blue:0 Alpha:25];;
    UILabel *lable2=[[UILabel alloc]initWithFrame:CGRectMake(8, dispatchingView.frame.size.height/2-15, 200, 30)];
    [lable2 setText:@"配送方式"];
    [lable2 setBackgroundColor:[UIColor clearColor]];
        [lable2 setTextColor:[UIColor blackColor]];
    [dispatchingView addSubview:lable2];
    shareRect=CGRectMake(275,dispatchingView.frame.size.height/2-10, 20, 20);
    UIButton  *lbutton2=[self CreateButton:shareRect setTag:3];
     
      UILabel *lable22=[[UILabel alloc]initWithFrame:CGRectMake(118, dispatchingView.frame.size.height/2-15, 100, 30)];
    [lable22 setText:@"快速运输"];
    [lable22 setBackgroundColor:[UIColor clearColor]];
    [lable22 setTextColor:[UIColor blackColor]];
    [lable22 setFont:[UIFont systemFontOfSize:15]];
    [dispatchingView addSubview:lable22];
    [dispatchingView addSubview:lbutton2];
    [lScrollView addSubview:dispatchingView];
    
    
    
    UIView  *InvoiceView=[[UIView alloc]initWithFrame:CGRectMake(10, 290, 300, 150)];
    InvoiceView.layer.borderWidth=1;
    InvoiceView.layer.borderColor=[self getColorFromRed:0 Green:225 Blue:1 Alpha:12];
    //100 1 1 12
    //176,196,222
    InvoiceView.layer.backgroundColor=[self getColorFromRed:300 Green:0 Blue:0 Alpha:25];
   
    InvoiceView.layer.cornerRadius=5;
    [lScrollView addSubview:InvoiceView];
    UILabel *lable3=[[UILabel alloc]initWithFrame:CGRectMake(8, 15, 100, 30)];
    [lable3 setText:@"发票信息"];
    [lable3 setBackgroundColor:[UIColor clearColor]];
    [lable3 setTextColor:[UIColor blackColor]];
    [InvoiceView addSubview:lable3];
    UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(0, 58, 300, 2)];
    [line setBackgroundColor:[UIColor blackColor]];
    [InvoiceView addSubview:line];
    
      UILabel *lable4=[[UILabel alloc]initWithFrame:CGRectMake(8, 67, 200, 20)];
    [lable4 setText:@"发票类型: 普通发票"];
    [lable4 setFont:[UIFont systemFontOfSize:15]];
    [lable4 setBackgroundColor:[UIColor clearColor]];
    [lable4 setTextColor:[UIColor blackColor]];
    [InvoiceView addSubview:lable4];

    
    UILabel *lable44=[[UILabel alloc]initWithFrame:CGRectMake(8, 90, 200, 20)];
    [lable44 setText:@"发票抬头: 个人"];
    [lable44 setFont:[UIFont systemFontOfSize:15]];
    [lable44 setBackgroundColor:[UIColor clearColor]];
    [lable44 setTextColor:[UIColor blackColor]];
    [InvoiceView addSubview:lable44];
    
    
    UILabel *lable444=[[UILabel alloc]initWithFrame:CGRectMake(8, 113, 200, 20)];
    [lable444 setText:@"发票内容: 非图书商品-明细"];
    [lable444 setFont:[UIFont systemFontOfSize:15]];
    [lable444 setBackgroundColor:[UIColor clearColor]];
    [lable444 setTextColor:[UIColor blackColor]];
    [InvoiceView addSubview:lable444];
    
    shareRect=CGRectMake(275, 130-58/2-10, 20, 20);
    UIButton  *lbutton3=[self CreateButton:shareRect setTag:4];
    [InvoiceView addSubview:lbutton3];
    [self.view addSubview:lScrollView];
    
    
    
    UIView  *PostOrderView=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-50, 320, 50)];
    PostOrderView.layer.borderWidth=1;
    PostOrderView.layer.borderColor=[self getColorFromRed:0 Green:225 Blue:1 Alpha:12];
    //100 1 1 12
    //176,196,222
    PostOrderView.layer.backgroundColor=[self getColorFromRed:300 Green:0 Blue:0 Alpha:25];
    [PostOrderView setBackgroundColor:[UIColor redColor]];
     
    [self.view addSubview:PostOrderView];
    
    UILabel *PayTitle=[[UILabel alloc]initWithFrame:CGRectMake(5, PostOrderView.frame.size.height/2-10, 70, 20)];
    [PayTitle setFont:[UIFont systemFontOfSize:15]];
    [PayTitle setText:@"应付总额:"];
    [PayTitle  setTextColor:[UIColor blackColor]];
    [PayTitle setBackgroundColor:[UIColor clearColor]];
    [PostOrderView addSubview:PayTitle];
    
    
     PayTitleTotal=[[UILabel alloc]initWithFrame:CGRectMake(75, PostOrderView.frame.size.height/2-10, 170, 20)];
    [PayTitleTotal setFont:[UIFont systemFontOfSize:15]];
    for (int i=0;i<[[JD_DataManager shareGoodsDataManager].BuyCardInfoArray count] ; i++) {
        NSDictionary *FirstDictionary=[[JD_DataManager shareGoodsDataManager].BuyCardInfoArray objectAtIndex:i];
        if ([[FirstDictionary objectForKey:@"sgin"]intValue]==1) {
            NSDictionary *dictionary=[FirstDictionary objectForKey:@"dictionary"];
            int count=[[dictionary objectForKey:@"goodscount"]intValue];
            int price=[[dictionary objectForKey:@"price"]intValue];
            orderPayTotal=orderPayTotal+(count*price);
              [PayTitleTotal  setText:[NSString stringWithFormat:@"%@%i%@",@"¥",orderPayTotal,@".00"]];
              
        }
        
    }
    [PayTitleTotal  setTextColor:[UIColor blackColor]];
    [PayTitleTotal setBackgroundColor:[UIColor clearColor]];
    [PostOrderView addSubview:PayTitleTotal];
    
    
     
    postOrderButton=[[UIButton alloc]initWithFrame:CGRectMake(220, PostOrderView.frame.size.height/2-15 , 90, 30)] ;
    [postOrderButton setTitle:@"提交订单" forState:UIControlStateNormal];
    postOrderButton.layer.cornerRadius=5;
    [postOrderButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    
    postOrderButton.layer.borderWidth=1;
    postOrderButton.backgroundColor=[UIColor redColor];
    //100 1 1 12
    //176,196,222
    
    [postOrderButton addTarget:self action:@selector(addOrderClick:) forControlEvents:UIControlEventTouchUpInside];
    [postOrderButton  addTarget:self action:@selector(ChangeBackgroundColor:) forControlEvents:UIControlEventTouchDown];
    [PostOrderView addSubview:postOrderButton];
    
   
    [lCreateReceiverView release];
    
    [PayTitle release];
    [PostOrderView release];
    [lLabel release];
    [lable11 release];
    [lable22 release];
    [lable2 release];
    [line release];
    [lable3 release];
    [lable4 release];
    [lable44 release];
    [lable444 release];
    
}

 








-(void)deleteAddress:(UIButton *)sender
{
    
   
    for (int i=0; i<[[JD_DataManager shareGoodsDataManager].AddressArray count]; i++) {
        NSDictionary *Dicitonary=[[JD_DataManager shareGoodsDataManager].AddressArray objectAtIndex:i];
        NSDictionary *AdressDictionary=[Dicitonary objectForKey:@"dictionary"];
        UIButton *lButton=[Dicitonary objectForKey:@"deleteButton"];
      
        if (lButton==(UIButton *)sender) {
            NSURL *lUrl=[NSURL URLWithString:@"http://192.168.1.120/shop/deleteaddress.php"];
            NSMutableURLRequest *lRequest=[NSMutableURLRequest requestWithURL:lUrl];
            lRequest.HTTPMethod=@"post";
            NSString *PostData=[NSString stringWithFormat:@"addressid=%@",[AdressDictionary  objectForKey:@"addressid"]];
            lRequest.HTTPBody=[PostData dataUsingEncoding:NSUTF8StringEncoding];
            
            NSURLConnection *Connection=[NSURLConnection connectionWithRequest:lRequest delegate:self];
            [Connection start]; 
             [[JD_DataManager shareGoodsDataManager].AddressArray removeObject:Dicitonary];
            break;
        }
   
    }
  [lTableView reloadData];

   

}



//-(void)EditionCell:(UIBarButtonItem *)sender
//{
//   
//   
//        for (int i=0; i<[[JD_DataManager shareGoodsDataManager].AddressArray count]; i++) {
//             NSDictionary  *lDictionary =[[JD_DataManager shareGoodsDataManager].AddressArray objectAtIndex:i];
//             if ([lDictionary objectForKey:@"deleteButton"]==nil) {
//                 deleteButton=[[UIButton alloc]initWithFrame:CGRectMake(240, 30, 20, 20)];
//                 deleteButton.layer.cornerRadius=10;
//                 [deleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//                 [deleteButton setTitle:@"x" forState:UIControlStateNormal];
//                 [deleteButton setBackgroundColor:[UIColor redColor]];
//                 [deleteButton addTarget:self action:@selector(deleteAddress:) forControlEvents:UIControlEventTouchUpInside];
//                 NSDictionary *UpdateDictionary=[NSDictionary dictionaryWithObjectsAndKeys:[lDictionary  objectForKey:@"dictionary"],@"dictionary", [lDictionary  objectForKey:@"button"],@"button",deleteButton,@"deleteButton" ,nil];
//                 [[JD_DataManager shareGoodsDataManager].AddressArray replaceObjectAtIndex:i withObject:UpdateDictionary];
//             }
//            else
//            {
//                UIButton  *Button=[lDictionary objectForKey:@"button"];
//                NSDictionary *Dictionary=[lDictionary objectForKey:@"dictionary"];
//                NSDictionary *newDictionary=[NSDictionary dictionaryWithObjectsAndKeys:Dictionary,@"dictionary",Button,@"button",nil];
//                [[JD_DataManager shareGoodsDataManager].AddressArray replaceObjectAtIndex:i withObject:newDictionary];
//            }
//           
//        }
//
//      
//    
//    
//        [lTableView reloadData];
//}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
     
        lTableView.scrollEnabled=YES;
         lScrollView.scrollEnabled=YES;
     
}
 
 
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [lData setLength:0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [lData appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
     
    //NSString *lstring  =[[NSString alloc]initWithData:lData encoding:NSUTF8StringEncoding];
    if (Sgin==1) {

   NSDictionary *lDictionary = [NSJSONSerialization JSONObjectWithData:lData options:NSJSONReadingAllowFragments error:nil];
    if ([[lDictionary objectForKey:@"error"]intValue]==0) {
        AllOrderFrom *AllOrder=[[AllOrderFrom alloc]init];
        [self.navigationController pushViewController:AllOrder animated:YES];
        [AllOrder release];
    }
    else
    {
        UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"失败" message:@"提交失败!" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
        [lAlertView show];
        [lAlertView release];
    }
        Sgin=0;
 }
}


//创建订单提交数组
-(NSString *)CreateOrderId
{
    NSString  *OrderIdArrray=[[NSString alloc]init];
    NSMutableArray *tempArray=[JD_DataManager shareGoodsDataManager].BuyCardInfoArray;
    for (int i=0; i<[tempArray count]; i++) {
        NSDictionary *lDictioanry=[[tempArray objectAtIndex:i] objectForKey:@"dictionary"];
        NSString *optionSgin=[[tempArray objectAtIndex:i]objectForKey:@"sgin"];
        if ([optionSgin intValue]==1) {
            NSMutableString *Str=[lDictioanry objectForKey:@"cartid"];
            OrderIdArrray=[OrderIdArrray stringByAppendingFormat:@"&cartids[%d]=%@",i,Str];
            [[JD_DataManager shareGoodsDataManager].BuyCardInfoArray removeObjectAtIndex:i];
        
            }
      }
    return OrderIdArrray;
 
    [OrderIdArrray release];
}

-(void)addOrderClick:(UIButton *)sender
{
      Sgin=1;
    if (PayTitleTotal.text.length<1) {
        UIAlertView *lAlertView =[[UIAlertView alloc]initWithTitle:@"错误" message:@"请返回选中提交商品" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
        [lAlertView show];
        [lAlertView release];
    }
    else
    {
    NSString *Adressx=@"";
    for (int i=0; i<[JD_DataManager shareGoodsDataManager].AddressArray.count; i++) {
        NSDictionary *dictionary=[[JD_DataManager shareGoodsDataManager].AddressArray objectAtIndex:i];
        UIButton *lbutton=[dictionary objectForKey:@"button"];
        if (lbutton.backgroundColor==[UIColor redColor]) {
            NSDictionary *adressDictionary=[dictionary objectForKey:@"dictionary"];
           Adressx=[adressDictionary objectForKey:@"addressid"];
             
        }
       
    }

if (Adressx.length>0) {
    
  postOrderButton.backgroundColor=[UIColor redColor];
 NSURL *URL=[NSURL URLWithString:@"http://192.168.1.120/shop/addorder.php"];
 NSString *PostData=[NSString stringWithFormat:@"customerid=%@&addressid=%@&cartids=%@",[JD_DataManager shareGoodsDataManager].userID,Adressx,[self CreateOrderId]];
 NSMutableURLRequest *lRequest=[NSMutableURLRequest requestWithURL:URL];
 [lRequest setHTTPMethod:@"post"];
 [lRequest setHTTPBody: [PostData dataUsingEncoding:NSUTF8StringEncoding]];
 NSURLConnection *connection=[NSURLConnection connectionWithRequest:lRequest delegate:self];
 [connection start];
   
 }
else
{
    UIAlertView *lAlertView =[[UIAlertView alloc]initWithTitle:@"错误" message:@"请选中收货地址" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
    [lAlertView show];
    [lAlertView release];
}
    }

}

-(void)ChangeBackgroundColor:(UIButton *)sender
{
    
    postOrderButton.layer.backgroundColor=[self getColorFromRed:0 Green:500 Blue:0 Alpha:25];
     
}
-(void)dealloc
{
    [PayTitleTotal release];
    [deleteButton release];
    [lSelectPlaceImageArray release];
    [lSelectPlaceImage release];
    [lTableView release];
    [lAdressArray release];
    [lData release];
    [postOrderButton release];
    [lScrollView release];
    
    [super dealloc];
}
@end
