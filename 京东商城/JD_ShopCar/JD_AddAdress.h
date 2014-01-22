//
//  JD_AddAdress.h
//  京东商城
//
//  Created by TY on 14-1-16.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JD_AddAdress : UIViewController<NSURLConnectionDataDelegate>
{
    NSMutableData *lData; UITextField *Field;UITextField *Field1;UITextField *Field2;UITextField *Field3;
    UIButton *lButton;
}
- (IBAction)CloseKeyboard:(UIControl *)sender;

@end
