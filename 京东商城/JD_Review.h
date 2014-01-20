//
//  JD_Review.h
//  京东商城
//
//  Created by TY on 14-1-17.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomView.h"

@interface JD_Review : UIViewController
{
    NSString *_star;
    UITextField *_detailText;
    CustomView *_customView;
    UILabel *_persentLabel;
}
- (IBAction)screenExit:(UIControl *)sender;

@end
