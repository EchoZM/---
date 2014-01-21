//
//  JD_Login.h
//  JD_MALL
//
//  Created by TY on 14-1-14.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JD_Login : UIViewController {
    UIAlertView *ErrorAlertView;
    UIButton *RememberPassword;
}
@property (nonatomic,retain)UITextField *UserText;
@property (nonatomic,retain)UITextField *PasswordText;
@property (nonatomic,assign)BOOL Remember;
- (IBAction)View:(UIControl *)sender;

@end
