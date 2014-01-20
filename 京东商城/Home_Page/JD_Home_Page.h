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
    BOOL isFromStart;
    UISearchBar *lSearchBar;
    UIView *lView1;
    NSArray *lArray;
    UITableView *justTableView;
    UIImageView *lImageView;
    UIScrollView *lScrollView;
    UITableView *lTableView;
    NSMutableArray *searchGoodsArray;
}
@property(nonatomic,retain)UIScrollView *scrollView;
@property(nonatomic,retain)UIPageControl *pageControl;
@property(nonatomic,retain)NSArray *arrayImages;
@property(nonatomic,retain)NSMutableArray *viewController;
@property(nonatomic,assign)NSTimer *timer;
@end
