//
//  MoreView.h
//  JD_MALL
//
//  Created by TY on 14-1-14.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreView : UIViewController <UITableViewDataSource,UITableViewDelegate> {
    UITableView *TableView;
    NSMutableArray *TextArray;
    NSMutableArray *ImageArray;
}

@end
