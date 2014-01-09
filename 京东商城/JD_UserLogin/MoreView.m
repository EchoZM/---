//
//  MoreView.m
//  京东商城
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 张闽. All rights reserved.
//

#import "MoreView.h"

@interface MoreView ()

@end

@implementation MoreView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.view setBackgroundColor:[UIColor orangeColor]];
        TextArray = [[NSArray alloc]initWithObjects:@"浏览历史",@"应用推荐",@"设置",@"帮助",@"意见反馈",@"关于",@"监测更新",@"退出", nil];
        ImageArray = [[NSArray alloc]initWithObjects:@"浏览历史",@"more_commend@2x.png",@"more_setting@2x.png",@"more_help@2x.png",@"more_feed@2x.png",@"more_about@2x.png",@"监测更新",@"退出", nil];
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
    self.navigationItem.title = @"更多";
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(CancelButton:)]autorelease];
    self.navigationItem.leftBarButtonItem.tintColor= [UIColor redColor];
    self.navigationItem.rightBarButtonItem = nil;
    TableView = [[[UITableView alloc]initWithFrame:CGRectMake(10, 15, 300, [TextArray count]*45) style:UITableViewStylePlain]autorelease];
    NSLog(@"%f",self.view.frame.size.height);
    TableView.backgroundView = nil;
    TableView.backgroundColor = [UIColor greenColor];
    TableView.delegate = self;
    TableView.dataSource = self;
    [self.view addSubview:TableView];
}

-(void)CancelButton:(UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return TextArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cell = @"cell";
    UITableViewCell *lcell = [tableView dequeueReusableCellWithIdentifier:cell];
    if (lcell == nil) {
        lcell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cell]autorelease];
    }
    lcell.imageView.image = [UIImage imageNamed:[ImageArray objectAtIndex:[indexPath row]]];
    lcell.textLabel.text = [TextArray objectAtIndex:[indexPath row]];
    
    return lcell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
