//
//  CustomView.m
//  京东商城
//
//  Created by TY on 14-1-15.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import "CustomView.h"
#import "StarView.h"
#define kDistance 2

@implementation CustomView

-(id)initWithHeight:(double)height AndStar:(double)star{
    self = [super initWithFrame:CGRectMake(0, 0, (height+kDistance)*5, height)];
    if (self) {
        NSMutableArray *lArray=[NSMutableArray arrayWithCapacity:5];
        NSAssert(star<=5&&star>=0, @"star必须在0～5之间");
        for (int i=0; i<5; i++) {
            double value=[self changeValue:star-i];
            StarView *lStarView=[[[StarView alloc]initWithFrame:CGRectMake(i*(height+kDistance), 0, height, height) AndStar:value]autorelease];
            [self addSubview:lStarView];
            [lArray addObject:lStarView];
        }
        _array=[[NSArray alloc]initWithArray:lArray];
    }
    return self;
}
-(void)setStarValue:(double)star{
    NSAssert(star<=5&&star>=0, @"star必须在0～5之间");
    for (int i=0; i<5; i++) {
        double value=[self changeValue:star-i];
        StarView *lStarView=[_array objectAtIndex:i];
        [lStarView setStarValue:value];
    }
}
-(double)changeValue:(double)value{
    if (value>1) {
        value=1;
    }
    if (value<0) {
        value=0;
    }
    return value;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    float width = self.frame.size.width;
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    float value = location.x/width;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"post" object:[NSNumber numberWithFloat:value*10/2] userInfo:nil];
}
-(void)dealloc{
    [_array release];
    [super dealloc];
}

@end
