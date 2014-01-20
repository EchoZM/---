//
//  AllOrderFrom.h
//  京东商城
//
//  Created by TY on 14-1-13.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllOrderFrom : UIViewController <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate> {
    UITableView *TableView;
    NSMutableArray *OrderArray;
    UIButton *HeardButton;
}

@end
