//
//  JD_Register.h
//  JD_MALL
//
//  Created by TY on 14-1-14.
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
//    NSMutableData *Data;
}
- (IBAction)View:(UIControl *)sender;

@end
