//
//  StarView.m
//  京东商城
//
//  Created by TY on 14-1-15.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import "StarView.h"

@implementation StarView

-(id)initWithFrame:(CGRect)frame AndStar:(double)star{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setStarValue:star];
    }
    return self;
}
-(void)setStarValue:(double)star{
    for (UIView *lView in self.subviews) {
        [lView removeFromSuperview];
    }
    NSAssert(star<=1&&star>=0, @"star必须在0～1之间");
    if (star!=1) {
        UIImage *lImageLine=[UIImage imageNamed:@"star_dark.png"];
        CGImageRef lImageRefLine=[lImageLine CGImage];
        lImageLine=[UIImage imageWithCGImage:CGImageCreateWithImageInRect(lImageRefLine, CGRectMake(0, 0, lImageLine.size.width*2, lImageLine.size.height*2))];
        UIImageView *lImageViewLine=[[[UIImageView alloc]initWithImage:lImageLine]autorelease];
        [lImageViewLine setFrame:self.bounds];
        [self addSubview:lImageViewLine];
    }
    if (star!=0) {
        UIImage *lImageLine=[UIImage imageNamed:@"star_light.png"];
        CGImageRef lImageRefLine=[lImageLine CGImage];
        lImageLine=[UIImage imageWithCGImage:CGImageCreateWithImageInRect(lImageRefLine, CGRectMake(0, 0, lImageLine.size.width*star*2, lImageLine.size.height*2))];
        UIImageView *lImageViewLine=[[[UIImageView alloc]initWithImage:lImageLine]autorelease];
        [lImageViewLine setFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width*star, self.bounds.size.height)];
        [self addSubview:lImageViewLine];
    }
}

@end
