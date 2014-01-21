//
//  InfoView.m
//  京东商城
//
//  Created by TY on 14-1-20.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import "InfoView.h"

@implementation InfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, 300, 200)];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 200)];
        [self addSubview:lineLabel];
        
        UITapGestureRecognizer *lTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapGesture:)];
        [self addGestureRecognizer:lTap];
        [lTap release];
    }
    return self;
}

-(void)TapGesture:(UITapGestureRecognizer *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"custom" object:self userInfo:nil];
}

@end
