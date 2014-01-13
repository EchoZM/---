//
//  JD_Goods.h
//  京东商城
//
//  Created by TY on 14-1-8.
//  Copyright (c) 2014年 张闽. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JD_Goods : UIViewController
{
    NSDictionary *_goodsInfo;
    UIView *_backgroundView;
    UILabel *goodsCount;
    int goodsNumber;
    NSString *goodsPrice;
    UITextField *numberLabel;
    UILabel *priceView;
}

@end
