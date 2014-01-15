//
//  JD_Goods_Evaluate.h
//  京东商城
//
//  Created by TY on 14-1-8.
//  Copyright (c) 2014年 张闽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomView.h"

@interface JD_Goods_Evaluate : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSDictionary *_goodsInfo;
    NSDictionary *_reviewInfo;
    CustomView *_customView;
    UITableView *_tableView;
}

@end
