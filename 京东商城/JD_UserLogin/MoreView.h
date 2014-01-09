//
//  MoreView.h
//  京东商城
//
//  Created by TY on 14-1-7.
//  Copyright (c) 2014年 张闽. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreView : UIViewController <UITableViewDataSource,UITableViewDelegate> {
    UITableView *TableView;
    NSArray *TextArray;
    NSArray *ImageArray;
//    NSMutableArray *Array;
}

@end
