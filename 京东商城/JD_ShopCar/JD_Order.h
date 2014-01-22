//
//  JD_Order.h
//  京东商城
//
//  Created by TY on 14-1-16.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JD_Order : UIViewController<NSURLConnectionDataDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    CGRect shareRect;
    UIScrollView *lScrollView;
    int   orderPayTotal;
    UIButton *postOrderButton;
    NSMutableData *lData;
    NSMutableArray *lAdressArray;
   // NSMutableDictionary *lAdressDictionary;
    UILabel *lLabel;
    UITableView *lTableView;
    UIImageView *lSelectPlaceImage;
    NSMutableArray *lSelectPlaceImageArray;
    // NSMutableArray *lSigleAdressArray;
    UIButton *deleteButton;
   int Sgin; UIButton *byOptionAdress;
}

@end
