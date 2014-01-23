//
//  JD_AddAdress.m
//  京东商城
//
//  Created by TY on 14-1-16.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import "JD_AddAdress.h"

@interface JD_AddAdress ()

@end

@implementation JD_AddAdress

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
         self.title=@"新建发货人";
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


-(void)viewWillAppear:(BOOL)animated
{
    
  
    
    lData=[[NSMutableData alloc]init];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(returnBuycarPage:)];
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(postAdressClick:)];
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor redColor];
    self.navigationItem.rightBarButtonItem.tintColor=[UIColor redColor];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(15, 20, 83, 20)];
    [label setText:@"收货人姓名:"];
    [label setFont:[UIFont systemFontOfSize:15]];
    [label setBackgroundColor:[UIColor clearColor]];
     Field=[[UITextField alloc]initWithFrame:CGRectMake(98, 15, 180, 30)];
    Field.placeholder=@"请输入收货人姓名";
    [Field setBorderStyle:UITextBorderStyleRoundedRect];
    
    [self.view addSubview:label];
     [self.view addSubview:Field];
    [label release];  
    
    
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(15, 65, 83, 20)];
    [label1 setText:@"收货人电话:"];
    [label1 setFont:[UIFont systemFontOfSize:15]];
    [label1 setBackgroundColor:[UIColor clearColor]];
      Field1=[[UITextField alloc]initWithFrame:CGRectMake(98, 60, 180, 30)];
    Field1.placeholder=@"请输入收货人电话";
    [Field1 setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:label1];
    [self.view addSubview:Field1];
    [label1 release];   
    
    
    
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(15, 110, 83, 20)];
    [label2 setText:@"收货人邮编:"];
    
    [label2 setFont:[UIFont systemFontOfSize:15]];
    [label2 setBackgroundColor:[UIColor clearColor]];
    Field2=[[UITextField alloc]initWithFrame:CGRectMake(98, 105, 180, 30)];
    Field2.placeholder=@"请输入收货人邮编";
    [Field2 setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:label2];
    [self.view addSubview:Field2];
    [label2 release];   
    
    
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(15, 155, 83, 20)];
    [label3 setText:@"收货人地址:"];
    [label3 setFont:[UIFont systemFontOfSize:15]];
    [label3 setBackgroundColor:[UIColor clearColor]];
     Field3=[[UITextField alloc]initWithFrame:CGRectMake(98, 150, 200, 200)];
    Field3.placeholder=@"请输入收货人地址";
    [Field3 setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:label3];
    [self.view addSubview:Field3];
    [label3 release];
    
    
     
    
}






-(void)returnBuycarPage:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)postAdressClick:(UIBarButtonItem *)sender
{
    
    if (Field.text.length==0 || Field1.text.length==0 || Field2.text.length==0 || Field3.text.length==0 ) {
        UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"错误" message:@"增加信息不能为空!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
        [lAlertView show];
        [lAlertView release];
        return;
    }
    else
    {
      
           
             if([self isMobileNumber:Field1.text]==YES)
             {
                 
             }
           else
           {
               UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"错误" message:@"手机格式错误!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
               [lAlertView show];
               [lAlertView release];
               return;
           }
        
        
        
        
        if ([self  checkPostcode:Field2.text]==YES) {
                    
        }
        else
        {
            UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"错误" message:@"邮编格式错误!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
            [lAlertView show];
            [lAlertView release];
            return;
        }
        
        
        if (Field3.text.length<5) {
            UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"错误" message:@"地址信息错误!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
            [lAlertView show];
            [lAlertView release];
            return;
        }
       
        
    NSURL *URL=[NSURL URLWithString:@"http://192.168.1.120/shop/addaddress.php"];
    NSString *PostData=[NSString stringWithFormat:@"customerid=%@&name=%@&telephone=%@&code=%@&address=%@",[JD_DataManager shareGoodsDataManager].userID ,Field.text,Field1.text,Field2.text,Field3.text];
    
    NSMutableURLRequest *lRequest=[NSMutableURLRequest requestWithURL:URL];
    [lRequest setHTTPMethod:@"post"];
    [lRequest setHTTPBody:
     [PostData dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *connection=[NSURLConnection connectionWithRequest:lRequest delegate:self];
    [connection start];
   
        
    }
}
//验证邮政编码

- (BOOL) checkPostcode:(NSString *)postCode{
    
     NSString * PostCodeStyle = @"[0-9]{6}";
      NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PostCodeStyle];
     if  ([regextestmobile evaluateWithObject:postCode] == YES)
         {
             return YES;
         }
     else{
         return NO;
     }
        
}
    
//验证手机号
- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:mobileNum];
    
    if (!isMatch) {
        
  
        
        return NO;
        
    }
    return YES;
    
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
 
    NSDictionary *Dictionary=[NSJSONSerialization JSONObjectWithData:lData options:NSJSONReadingAllowFragments error:nil];
    
    if ([[Dictionary objectForKey:@"error"]intValue]==0) {
    [[JD_DataManager shareGoodsDataManager].AddressArray removeAllObjects];
    NSDictionary *lDictionary=[Dictionary objectForKey:@"msg"];
    NSArray *lArray=[lDictionary objectForKey:@"info"];
    for (int i=0; i<[lArray count]; i++) {
        NSDictionary *singleDictionary=[lArray objectAtIndex:i];
        lButton=[[UIButton alloc]init];
        NSMutableDictionary *lastDictionary=[NSMutableDictionary dictionaryWithObjectsAndKeys:singleDictionary,@"dictionary",lButton,@"button", nil];
        [[JD_DataManager shareGoodsDataManager].AddressArray addObject:lastDictionary];
     }
        UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"成功" message:@"增加地址成功!" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
        [lAlertView show];
        [lAlertView release];
    }
    else
    {
        UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"失败" message:@"增加地址失败!" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
        [lAlertView show];
        [lAlertView release];
    }
    
  
    
  
    
} 
-(void)dealloc{
    [lButton release];
    [Field release];
    [Field1 release];
    [Field2 release];
    [Field3 release];
    [super dealloc];
}
- (IBAction)CloseKeyboard:(UIControl *)sender {
    [Field resignFirstResponder];
    [Field1 resignFirstResponder];
    [Field2 resignFirstResponder];
    [Field3 resignFirstResponder];
    
}
@end
