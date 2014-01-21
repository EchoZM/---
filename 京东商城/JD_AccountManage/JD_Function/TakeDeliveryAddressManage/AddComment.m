//
//  AddComment.m
//  JD_MALL
//
//  Created by TY on 14-1-14.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import "AddComment.h"

@interface AddComment ()

@end

@implementation AddComment

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"添加地址";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, 100, 50)];
    nameLabel.text = @"收货人姓名:";
    nameLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:nameLabel];
    [nameLabel release];
    UILabel *zoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 100, 50)];
    zoneLabel.text = @"所在地区:";
    zoneLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:zoneLabel];
    [zoneLabel release];
    UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 175, 100, 50)];
    addressLabel.text = @"详细地址:";
    addressLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:addressLabel];
    [addressLabel release];
    UILabel *telephoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 310, 100, 50)];
    telephoneLabel.text = @"手机号码:";
    telephoneLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:telephoneLabel];
    [telephoneLabel release];
    UILabel *codeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 385, 100, 50)];
    codeLabel.text = @"邮政编码:";
    codeLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:codeLabel];
    [codeLabel release];
    UITextField *nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(105, 35, 200, 30)];
    nameTextField.tag = 11;
    nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    nameTextField.placeholder = @"输入收货人";
    [self.view addSubview:nameTextField];
    [nameTextField release];
    UITextField *zoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(105, 110, 200, 30)];
    zoneTextField.tag = 22;
    zoneTextField.delegate = self;
    zoneTextField.borderStyle = UITextBorderStyleRoundedRect;
    zoneTextField.placeholder = @"选择地区";
    [self.view addSubview:zoneTextField];
    [zoneTextField release];
    UITextField *addressTextField = [[UITextField alloc]initWithFrame:CGRectMake(105, 185, 200, 90)];
    addressTextField.tag = 33;
    addressTextField.borderStyle = UITextBorderStyleRoundedRect;
    addressTextField.placeholder = @"输入详细地址";
    [self.view addSubview:addressTextField];
    [addressTextField release];
    UITextField *telephoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(105, 320, 200, 30)];
    telephoneTextField.tag = 44;
    telephoneTextField.borderStyle = UITextBorderStyleRoundedRect;
    telephoneTextField.placeholder = @"输入手机号码";
    [self.view addSubview:telephoneTextField];
    [telephoneTextField release];
    UITextField *codeTextField = [[UITextField alloc]initWithFrame:CGRectMake(105, 395, 200, 30)];
    codeTextField.tag = 55;
    codeTextField.borderStyle = UITextBorderStyleRoundedRect;
    codeTextField.placeholder = @"输入邮政编码";
    [self.view addSubview:codeTextField];
    [codeTextField release];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 40, 40);
    [backButton setImage:[UIImage imageNamed:@"title_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(BackButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    [leftBarButton release];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(FinishButton:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    self.navigationItem.rightBarButtonItem.tintColor= [UIColor redColor];
    [rightBarButton release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)BackButton:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)FinishButton:(UIBarButtonItem *)sender
{
    UITextField *nameTextField = (UITextField *)[self.view viewWithTag:11];
    UITextField *zoneTextField = (UITextField *)[self.view viewWithTag:22];
    UITextField *addressTextField = (UITextField *)[self.view viewWithTag:33];
    UITextField *telephoneTextField = (UITextField *)[self.view viewWithTag:44];
    UITextField *codeTextField = (UITextField *)[self.view viewWithTag:55];
    if (!(nameTextField.text==nil||[nameTextField.text isEqualToString:@""]) && !(zoneTextField.text==nil||[zoneTextField.text isEqualToString:@""]) && !(addressTextField.text==nil||[addressTextField.text isEqualToString:@""]) && !(telephoneTextField.text==nil||[telephoneTextField.text isEqualToString:@""]) && !(codeTextField.text==nil||[codeTextField.text isEqualToString:@""])) {
        NSString *bodyString = [NSString stringWithFormat:@"customerid=%@&name=%@&telephone=%@&code=%@&address=%@",[JD_DataManager shareGoodsDataManager].userID,nameTextField.text,telephoneTextField.text,codeTextField.text,[zoneTextField.text stringByAppendingString:addressTextField.text]];
        [[JD_DataManager shareGoodsDataManager] downloadDataWithHTTPMethod:@"post" WithBodyString:bodyString WithURLString:@"addaddress.php" AndSuccess:^(NSData *data){
            NSDictionary *lDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSString *errorString = [NSString stringWithFormat:@"%@",[lDictionary objectForKey:@"error"]];
            if ([errorString isEqualToString:@"0"]) {
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                UIAlertView *lAlertView = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"添加失败" delegate:self cancelButtonTitle:@"返回" otherButtonTitles: nil];
                [lAlertView show];
                [lAlertView release];
            }
        }AndFailed:^{
            
        }];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)screenExit:(UIControl *)sender
{
    UITextField *nameTextField = (UITextField *)[self.view viewWithTag:11];
    UITextField *zoneTextField = (UITextField *)[self.view viewWithTag:22];
    UITextField *addressTextField = (UITextField *)[self.view viewWithTag:33];
    UITextField *telephoneTextField = (UITextField *)[self.view viewWithTag:44];
    UITextField *codeTextField = (UITextField *)[self.view viewWithTag:55];
    [nameTextField resignFirstResponder];
    [zoneTextField resignFirstResponder];
    [addressTextField resignFirstResponder];
    [telephoneTextField resignFirstResponder];
    [codeTextField resignFirstResponder];
}
@end
