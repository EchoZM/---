//
//  JD_Home_Page.h
//  京东商城
//
//  Created by TY on 14-1-3.
//  Copyright (c) 2014年 张闽. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JD_Home_Page : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    
    UISearchBar *lSearchBar;
    UIScrollView *_scroll;
    UIPageControl *_pageController;
    UIView *lView1;
    NSMutableData *_data;
    NSArray *lArray;
    UITableView *justTableView;
    UIImageView *lImageView;
    UIScrollView *lScrollView;
    UITableView *lTableView;
    NSMutableArray *searchGoodsArray;
}
@end
