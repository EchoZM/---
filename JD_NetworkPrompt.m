//
//  JD_NetworkPrompt.m
//  京东商城
//
//  Created by TY on 14-1-16.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import "JD_NetworkPrompt.h"

@implementation JD_NetworkPrompt

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 548)];
    if (self) {
        // Initialization code
        
        NetworkNetworkView = [[[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-75, self.frame.size.width/2-50, 150, 100)]autorelease];
        NetworkNetworkView.layer.cornerRadius = 6.0;
        [NetworkNetworkView setBackgroundColor:[UIColor clearColor]];
        UIView *View = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 100)]autorelease];
        [View setBackgroundColor:[UIColor blackColor]];
        View.alpha = 0.5;
        View.layer.cornerRadius = 6.0;
        [NetworkNetworkView addSubview:View];
        UIImageView *lImageView = [[[UIImageView alloc]initWithFrame:CGRectMake(50, 3, 50, 50)]autorelease];
        [lImageView setImage:[UIImage imageNamed:@"37x-Failmark.png"]];
        [NetworkNetworkView addSubview:lImageView];
        [self addSubview:NetworkNetworkView];
        UILabel *lNetWork = [[[UILabel alloc]initWithFrame:CGRectMake(5, 52, 100, 25)]autorelease];
        [lNetWork setBackgroundColor:[UIColor clearColor]];
        [lNetWork setTextColor:[UIColor whiteColor]];
        [lNetWork setFont:[UIFont boldSystemFontOfSize:19]];
        [lNetWork setText:@"网络不给力"];
        [NetworkNetworkView addSubview:lNetWork];
        UILabel *lCheck= [[[UILabel alloc]initWithFrame:CGRectMake(20, 75, 130, 25)]autorelease];
        [lCheck setBackgroundColor:[UIColor clearColor]];
        [lCheck setTextColor:[UIColor whiteColor]];
        [lCheck setFont:[UIFont boldSystemFontOfSize:19]];
        [lCheck setText:@"查看网络连接!"];
        [NetworkNetworkView addSubview:lCheck];
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(performDismiss:) userInfo:nil repeats:NO];
    }
    return self;
}

-(void) performDismiss:(NSTimer *)timer
{
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
