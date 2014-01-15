//
//  CustomView.h
//  京东商城
//
//  Created by TY on 14-1-15.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomView : UIView
{
    NSArray *_array;
}
-(id)initWithHeight:(double)height AndStar:(double)star;
-(void)setStarValue:(double)star;

@end
