//
//  JD_ShopCar.h
//  京东商城
//
//  Created by TY on 14-1-3.
//  Copyright (c) 2014年 张闽. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JD_ShopCar : UIViewController<UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate,NSURLConnectionDataDelegate,UITextFieldDelegate>
{
    UIButton *GoPayButton;
    UIAlertView *lAlertView;
    NSMutableArray *lTablViewCellImageButton;
    UIButton  *loginButton;
    ASIHTTPRequest   *Request;
    UIImage *lImage;
    UILabel *TotalLabel;
    CGFloat   PayTotal;
    UIButton *lOptionButton;
    NSMutableData *lData;
    UITableView    *lTableView;
    UITextField *lCountText;
    UITextField *bySelectKeyBoard;
    UITextField *UpdateBySelectKeyBoard;
    UIView *SkipLayer;
    UIView *FunctionLayer;
    int Sgin;
    UIButton *byOptionAdress; 
}

@end
