//
//  TakeDeliveryAddressManage.m
//  京东商城
//
//  Created by TY on 14-1-13.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import "TakeDeliveryAddressManage.h"
#import "AddComment.h"
@interface TakeDeliveryAddressManage ()

@end

@implementation TakeDeliveryAddressManage

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"收货地址管理";
        ActionButtonArray = [[NSArray alloc]initWithObjects:@"添加",@"修改",@"删除", nil];
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"JD_BG.png"]]];
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
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(BackButton:)];
    self.navigationItem.leftBarButtonItem.tintColor= [UIColor redColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(ConfirmButton:)];
    self.navigationItem.rightBarButtonItem.tintColor= [UIColor redColor];
    UIView *lView = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)]autorelease];
    [lView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:lView];
    
    for (int i = 0; i < ActionButtonArray.count; i++) {
        UIButton *lAddButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [lAddButton setFrame:CGRectMake(21+92*i, 0, 90, 40)];
        lAddButton.layer.cornerRadius = 6.0;
        [lAddButton setBackgroundColor:[UIColor  purpleColor]];
        [lAddButton setTitle:[ActionButtonArray objectAtIndex:i] forState:UIControlStateNormal];
        [lAddButton addTarget:self action:@selector(ActionButton:) forControlEvents:UIControlEventTouchUpInside];
        [lView addSubview:lAddButton];
    }
    
    TableView = [[[UITableView alloc]initWithFrame:CGRectMake(20, 40, 280, self.view.frame.size.height - 40)]autorelease];
    [TableView setBackgroundView:nil];
    [TableView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:TableView];
}

-(void)ActionButton:(UIButton *)sender{
    if ([sender.titleLabel.text isEqualToString:@"添加"]) {
        AddComment *lAddComment = [[[AddComment alloc]init]autorelease];
        [self.navigationController pushViewController:lAddComment animated:YES];
    }else if ([sender.titleLabel.text isEqualToString:@"修改"]){
    
    }else{
    
    }

        NSLog(@"%@",sender.titleLabel.text);

}

-(void)BackButton:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)ConfirmButton:(UIBarButtonItem *)sender{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
