//
//  JD_Register.h
//  京东商城
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JD_Register : UIViewController{
    UITextField *UserText;
    UITextField *PasswordText;
    UITextField *RePasswordText;
    UITextField *EmailText;
    UITextField *TelephoneText;
    UIButton *ShowPassword;
    NSMutableData *Data;
}
- (IBAction)View:(UIControl *)sender;

@end
