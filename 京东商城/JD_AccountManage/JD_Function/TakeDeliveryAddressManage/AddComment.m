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
        self.navigationItem.title = @"添加评论";
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
