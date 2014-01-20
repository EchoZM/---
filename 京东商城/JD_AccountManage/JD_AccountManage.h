//
//  JD_AccountManage.h
//  JD_MALL
//
//  Created by TY on 14-1-14.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JD_AccountManage : UIViewController <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate> {
    UITableView *TableView;
    NSMutableArray *TextArray;
    NSMutableArray *ImageArray;
    NSMutableArray *ViewArray;
    UIButton *HeardButton;
}

@end
