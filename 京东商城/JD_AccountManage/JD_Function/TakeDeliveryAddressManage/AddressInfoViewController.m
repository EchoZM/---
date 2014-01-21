//
//  AddressInfoViewController.m
//  京东商城
//
//  Created by TY on 14-1-21.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import "AddressInfoViewController.h"

@interface AddressInfoViewController ()

@end

@implementation AddressInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"修改地址";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addressInfo:) name:@"info" object:nil];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 40, 40);
    [backButton setImage:[UIImage imageNamed:@"title_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(BackButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    [leftBarButton release];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(EditButton:)];
    rightBarButton.tag = 101;
    self.navigationItem.rightBarButtonItem = rightBarButton;
    self.navigationItem.rightBarButtonItem.tintColor= [UIColor redColor];
    [rightBarButton release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)BackButton:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)EditButton:(UIBarButtonItem *)sender
{
    if (sender.tag == 101) {
        sender.tag = 102;
        [sender setTitle:@"完成"];
        UITextField *nameTextField = (UITextField *)[self.view viewWithTag:11];
        UITextField *addressTextField = (UITextField *)[self.view viewWithTag:22];
        UITextField *telephoneTextField = (UITextField *)[self.view viewWithTag:33];
        UITextField *codeTextField = (UITextField *)[self.view viewWithTag:44];
        nameTextField.userInteractionEnabled = YES;
        addressTextField.userInteractionEnabled = YES;
        telephoneTextField.userInteractionEnabled = YES;
        codeTextField.userInteractionEnabled = YES;
        [nameTextField becomeFirstResponder];
        UIButton *deleteButton = (UIButton *)[self.view viewWithTag:520];
        deleteButton.backgroundColor = [UIColor redColor];
        deleteButton.tag = 521;
    }else{
        sender.tag = 101;
        [sender setTitle:@"编辑"];
        UITextField *nameTextField = (UITextField *)[self.view viewWithTag:11];
        UITextField *addressTextField = (UITextField *)[self.view viewWithTag:22];
        UITextField *telephoneTextField = (UITextField *)[self.view viewWithTag:33];
        UITextField *codeTextField = (UITextField *)[self.view viewWithTag:44];
        nameTextField.userInteractionEnabled = NO;
        addressTextField.userInteractionEnabled = NO;
        telephoneTextField.userInteractionEnabled = NO;
        codeTextField.userInteractionEnabled = NO;
        UIButton *deleteButton = (UIButton *)[self.view viewWithTag:521];
        deleteButton.backgroundColor = [UIColor grayColor];
        deleteButton.tag = 520;
    }
}

-(void)addressInfo:(NSNotification *)sender
{
    _dictionary = sender.userInfo;
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteButton.tag = 520;
    deleteButton.frame = CGRectMake(110, 25, 100, 50);
    deleteButton.backgroundColor = [UIColor grayColor];
    deleteButton.layer.cornerRadius = 8;
    [deleteButton setTitle:@"删除地址" forState:UIControlStateNormal];
    [deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(deleteButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteButton];
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 100, 50)];
    nameLabel.text = @"收货人姓名:";
    nameLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:nameLabel];
    [nameLabel release];
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
    UITextField *nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(105, 110, 200, 30)];
    nameTextField.tag = 11;
    nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    nameTextField.placeholder = @"输入收货人";
    nameTextField.text = [_dictionary objectForKey:@"name"];
    nameTextField.userInteractionEnabled = NO;
    [self.view addSubview:nameTextField];
    [nameTextField release];
    UITextField *addressTextField = [[UITextField alloc]initWithFrame:CGRectMake(105, 185, 200, 90)];
    addressTextField.tag = 22;
    addressTextField.borderStyle = UITextBorderStyleRoundedRect;
    addressTextField.placeholder = @"输入详细地址";
    addressTextField.text = [_dictionary objectForKey:@"address"];
    addressTextField.userInteractionEnabled = NO;
    [self.view addSubview:addressTextField];
    [addressTextField release];
    UITextField *telephoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(105, 320, 200, 30)];
    telephoneTextField.tag = 33;
    telephoneTextField.borderStyle = UITextBorderStyleRoundedRect;
    telephoneTextField.placeholder = @"输入手机号码";
    telephoneTextField.text = [_dictionary objectForKey:@"telephone"];
    telephoneTextField.userInteractionEnabled = NO;
    [self.view addSubview:telephoneTextField];
    [telephoneTextField release];
    UITextField *codeTextField = [[UITextField alloc]initWithFrame:CGRectMake(105, 395, 200, 30)];
    codeTextField.tag = 44;
    codeTextField.borderStyle = UITextBorderStyleRoundedRect;
    codeTextField.placeholder = @"输入邮政编码";
    codeTextField.text = [_dictionary objectForKey:@"code"];
    codeTextField.userInteractionEnabled = NO;
    [self.view addSubview:codeTextField];
    [codeTextField release];
}

-(void)deleteButton:(UIButton *)sender
{
    if (sender.tag == 520) {
        
    }else{
        NSString *bodyString = [NSString stringWithFormat:@"addressid=%@",[_dictionary objectForKey:@"addressid"]];
        [[JD_DataManager shareGoodsDataManager] downloadDataWithHTTPMethod:@"post" WithBodyString:bodyString WithURLString:@"deleteaddress.php" AndSuccess:^(NSData *data){
            NSDictionary *lDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSString *errorString = [NSString stringWithFormat:@"%@",[lDictionary objectForKey:@"error"]];
            if ([errorString isEqualToString:@"0"]) {
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                UIAlertView *lAlertView = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"删除失败" delegate:self cancelButtonTitle:@"返回" otherButtonTitles: nil];
                [lAlertView show];
                [lAlertView release];
            }
        }AndFailed:^{
            
        }];
    }
}

- (IBAction)screenExit:(UIControl *)sender
{
    UITextField *nameTextField = (UITextField *)[self.view viewWithTag:11];
    UITextField *addressTextField = (UITextField *)[self.view viewWithTag:22];
    UITextField *telephoneTextField = (UITextField *)[self.view viewWithTag:33];
    UITextField *codeTextField = (UITextField *)[self.view viewWithTag:44];
    [nameTextField resignFirstResponder];
    [addressTextField resignFirstResponder];
    [telephoneTextField resignFirstResponder];
    [codeTextField resignFirstResponder];
    nameTextField.userInteractionEnabled = NO;
    addressTextField.userInteractionEnabled = NO;
    telephoneTextField.userInteractionEnabled = NO;
    codeTextField.userInteractionEnabled = NO;
    UIButton *deleteButton = (UIButton *)[self.view viewWithTag:521];
    deleteButton.backgroundColor = [UIColor grayColor];
    deleteButton.tag = 520;
    UIBarButtonItem *rightBarButton = self.navigationItem.rightBarButtonItem;
    rightBarButton.tag = 101;
    [rightBarButton setTitle:@"编辑"];
}
@end
