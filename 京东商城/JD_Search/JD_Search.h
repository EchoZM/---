//
//  JD_Search.h
//  京东商城
//
//  Created by TY on 14-1-3.
//  Copyright (c) 2014年 张闽. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JD_Search : UIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_goodsArray;
    UISearchBar *_searchBar;
    UITableView *_tableView;
    UIView *lineView;
}
//@property(nonatomic,retain)NSMutableArray *goodsArray;

@end
